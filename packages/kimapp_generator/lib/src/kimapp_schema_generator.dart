import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:kimapp/kimapp_schema.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

class KimappSchemaGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    try {
      final schemas = library.annotatedWith(TypeChecker.fromRuntime(KimappSchema));

      if (schemas.isEmpty) {
        return '';
      }

      final buffer = StringBuffer();

      buffer.writeln("// ignore_for_file: invalid_annotation_target, unused_import");
      buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
      buffer.writeln("import 'package:kimapp/kimapp.dart';");
      buffer.writeln();

      final currentFilePath = buildStep.inputId.path;
      final currentFileName = path.basename(currentFilePath);
      buffer.writeln("import '$currentFileName';");
      buffer.writeln();
      buffer.writeln("part '${path.basenameWithoutExtension(currentFilePath)}.schema.freezed.dart';");
      buffer.writeln("part '${path.basenameWithoutExtension(currentFilePath)}.schema.g.dart';");
      buffer.writeln();

      for (final schema in schemas) {
        final annotation = ConstantReader(schema.annotation.objectValue);
        
        final tableName = _safeRead(annotation, 'tableName', 'string')!;
        final className = _safeRead(annotation, 'className', 'string') ?? tableName.pascalCase;
        final baseModelName = _safeRead(annotation, 'baseModelName', 'string') ?? '${className}RawModel';
        
        final columns = _safeReadList(annotation, 'columns')
            .map((e) => _createFieldDefinition(ConstantReader(e)))
            .toList();

        final models = _safeReadList(annotation, 'models')
            .map((e) => ModelDefinition.fromAnnotation(ConstantReader(e)))
            .toList();

          // Check for duplicate field names
          _checkDuplicateFields(columns);

          // Generate ID class if there's an IdField
          final idField = columns.firstWhereOrNull((col) => col is IdFieldDefinition);
          if (idField != null) {
            buffer.writeln(_generateIdClass(idField as IdFieldDefinition, className));
          }

          // Generate table constraint class
          buffer.writeln(_generateTableConstraintClass(tableName, columns, className));

          // Generate base model class
          buffer.writeln(_generateBaseModelClass(baseModelName, tableName, columns));

          // Generate additional model classes
          for (final model in models) {
            buffer.writeln(_generateModelClass(model, columns, className, tableName));
          }

          // Check for incorrect model names in addToModels
          _checkIncorrectModelNames(columns, models);
      }

      return buffer.toString();
      } catch (e, s) {
        print('Error in KimappSchemaGenerator: $e');
        print('Stack trace: $s');
        rethrow;
      }
  }

  String? _safeRead(ConstantReader reader, String field, String type) {
    try {
      final value = reader.read(field);
      switch (type) {
        case 'string':
          return value.isNull ? null : value.stringValue;
        case 'bool':
          return value.boolValue.toString();
        default:
          throw ArgumentError('Unsupported type: $type');
      }
    } catch (e) {
      print('Error reading field "$field" of type "$type": $e');
      return null;
    }
  }

  List<DartObject> _safeReadList(ConstantReader reader, String field) {
    try {
      final value = reader.read(field);
      return value.isNull ? [] : value.listValue;
    } catch (e) {
      print('Error reading list field "$field": $e');
      return [];
    }
  }

  FieldDefinition _createFieldDefinition(ConstantReader reader) {
    try {
      if (reader.peek('generateAs') != null) {
        return IdFieldDefinition.fromAnnotation(reader);
      } else if (reader.peek('foreignKey') != null) {
        return JoinFieldDefinition.fromAnnotation(reader);
      } else {
        return FieldDefinition.fromAnnotation(reader);
      }
    } catch (e) {
      print('Error creating FieldDefinition: $e');
      rethrow;
    }
  }

  void _checkDuplicateFields(List<FieldDefinition> columns) {
    final fieldNames = columns.map((e) => e.name).toSet();
    if (fieldNames.length != columns.length) {
      throw InvalidGenerationSourceError('Duplicate field names found in schema definition.');
    }
  }

  void _checkIncorrectModelNames(List<FieldDefinition> columns, List<ModelDefinition> models) {
    final modelNames = models.map((e) => e.name).toSet();
    for (final column in columns) {
      for (final modelName in column.addToModels) {
        if (!modelNames.contains(modelName)) {
          throw InvalidGenerationSourceError('Invalid model name "$modelName" in addToModels for field "${column.name}".');
        }}
    }
  }

  String _generateIdClass(IdFieldDefinition idField, String className) {
    final idClassName = idField.generateAs ?? '${className}Id';
    return '''
/// Represents the unique identifier for a $className.
class $idClassName extends Identity<${idField.type}> {
  const $idClassName._(this.value);

  @override
  final ${idField.type} value;

  factory $idClassName.fromJson(dynamic value) {
    return $idClassName._(value);
  }

  factory $idClassName.fromValue(${idField.type} value) {
    return $idClassName._(value);
  }
}
''';
  }

  String _generateTableConstraintClass(String tableName, List<FieldDefinition> columns, String className) {
    final buffer = StringBuffer();

    buffer.writeln("/// Defines the table structure for $className.");
    buffer.writeln("class ${className}Table {");
    buffer.writeln("  const ${className}Table._();");
    buffer.writeln();
    buffer.writeln('  /// The name of the database table.');
    buffer.writeln('  static const String table = "${tableName.toLowerCase()}";');
    buffer.writeln();

    for (final column in columns) {
      if (column is JoinFieldDefinition) {
        if (column.foreignKey != null) {
          buffer.writeln('  /// Foreign key column: ${column.name}');
          buffer.writeln('  static const String ${column.name.camelCase} = "${column.foreignKey}";');
        }
      } else {
        buffer.writeln('  /// Column: ${column.name}');
        buffer.writeln('  static const String ${column.name.camelCase} = "${column.name}";');
      }
    }

    buffer.writeln("}");
    return buffer.toString();
  }

  String _generateBaseModelClass(String baseModelName, String tableName, List<FieldDefinition> columns) {
    final buffer = StringBuffer();

    buffer.writeln('/// Base model class for $baseModelName.');
    buffer.writeln('@freezed');
    buffer.writeln('class $baseModelName with _\$$baseModelName {');
    buffer.writeln('  const $baseModelName._();');
    buffer.writeln();
    buffer.writeln('  @TableModel("$tableName")');
    buffer.writeln('  const factory $baseModelName({');

    for (final column in columns) {
      if (!column.ignoreRaw && column.type != null) {
        final nullabilitySuffix = column.type!.endsWith('?') ? '' : '';
        final requiredKeyword = column.type!.endsWith('?') ? '' : 'required ';
        buffer.writeln('    /// ${column.name} field');
        if (column is JoinFieldDefinition && column.foreignKey != null) {
          buffer.writeln('    @JsonKey(name: "${column.foreignKey}") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
        } else {
          buffer.writeln('    @JsonKey(name: "${column.name}") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
        }
      }
    }

    buffer.writeln('  }) = _$baseModelName;');
    buffer.writeln();
    buffer.writeln('  /// Creates an instance of $baseModelName from a JSON map.');
    buffer.writeln('  factory $baseModelName.fromJson(Map<String, dynamic> json) => _\$${baseModelName}FromJson(json);');
    buffer.writeln();
    buffer.writeln('  /// Supabase table configuration for this model.');
    buffer.writeln('  static const TableBuilder table = _table$baseModelName;');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateModelClass(ModelDefinition model, List<FieldDefinition> schemaColumns, String className, String baseTableName) {
  final buffer = StringBuffer();

  buffer.writeln('/// Represents the ${model.name} model.');
  buffer.writeln('@freezed');
  buffer.writeln('class ${model.name} with _\$${model.name} {');
  buffer.writeln('  const ${model.name}._();');
  buffer.writeln();
  
  if (model.supabaseTable != null) {
    final tableName = model.supabaseTable!.tableName ?? baseTableName;
    buffer.writeln('  @TableModel("$tableName")');
  }
  
  buffer.write('  const factory ${model.name}(');

  final fields = <String>[];

  // Add fields from schema columns that are included in this model
  for (final column in schemaColumns) {
    if (column.addToModels.contains(model.name) && column.type != null) {
      final nullabilitySuffix = column.type!.endsWith('?') ? '' : '';
      final requiredKeyword = column.type!.endsWith('?') ? '' : 'required ';
      final fieldName = column is JoinFieldDefinition && column.foreignKey != null
          ? column.foreignKey!
          : column.name;
      fields.add('    @JsonKey(name: "$fieldName") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
    }
  }

  // Add model-specific fields
  for (final field in model.columns) {
    if (field.type != null) {
      final nullabilitySuffix = field.type!.endsWith('?') ? '' : '';
      final requiredKeyword = field.type!.endsWith('?') ? '' : 'required ';
      fields.add('    @JsonKey(name: "${field.name}") $requiredKeyword${field.type}$nullabilitySuffix ${field.name.camelCase},');
    }
  }

  if (fields.isNotEmpty) {
    buffer.writeln('{');
    buffer.writeln(fields.join('\n'));
    buffer.writeln('  })');
  } else {
    buffer.writeln(')');
  }

  buffer.writeln(' = _${model.name};');
  buffer.writeln();
  buffer.writeln('  /// Creates an instance of ${model.name} from a JSON map.');
  buffer.writeln('  factory ${model.name}.fromJson(Map<String, dynamic> json) => _\$${model.name}FromJson(json);');
  
  if (model.supabaseTable != null) {
    buffer.writeln();
    buffer.writeln('  /// Supabase table configuration for this model.');
    buffer.writeln('  static const TableBuilder table = _table${model.name};');
  }
  
  buffer.writeln('}');

  return buffer.toString();
}
}

class FieldDefinition {
  FieldDefinition(this.name, this.type, this.addToModels, this.ignoreRaw);

  factory FieldDefinition.fromAnnotation(ConstantReader annotation) {
    try {
      final name = annotation.read('name').stringValue;
      final typeObj = annotation.read('type').objectValue;
      final type = typeObj.toTypeValue()?.getDisplayString(withNullability: true);
      final addToModels = annotation.read('addToModels').listValue
          .map((e) => e.toStringValue())
          .whereType<String>()
          .toList();
      final ignoreRaw = annotation.read('ignoreRaw').boolValue;

      return FieldDefinition(name, type, addToModels, ignoreRaw);
    } catch (e) {
      print('Error in FieldDefinition.fromAnnotation: $e');
      rethrow;
    }
  }

  final List<String> addToModels;
  final bool ignoreRaw;
  final String name;
  final String? type;
}

class IdFieldDefinition extends FieldDefinition {
  IdFieldDefinition(String name, String? type, List<String> addToModels, bool ignoreRaw, this.generateAs)
      : super(name, type, addToModels, ignoreRaw);

  factory IdFieldDefinition.fromAnnotation(ConstantReader annotation) {
    final field = FieldDefinition.fromAnnotation(annotation);
    final generateAs = annotation.read('generateAs').stringValue;

    return IdFieldDefinition(
      field.name,
      field.type,
      field.addToModels,
      field.ignoreRaw,
      generateAs,
    );
  }

  final String? generateAs;
}

class JoinFieldDefinition extends FieldDefinition {
  JoinFieldDefinition(String name, String? type, List<String> addToModels, bool ignoreRaw, this.foreignKey, this.candidateKey)
      : super(name, type, addToModels, ignoreRaw);

  factory JoinFieldDefinition.fromAnnotation(ConstantReader annotation) {
    final field = FieldDefinition.fromAnnotation(annotation);
    final foreignKey = annotation.read('foreignKey').stringValue;
    final candidateKey = annotation.read('candidateKey').stringValue;

    return JoinFieldDefinition(
      field.name,
      field.type,
      field.addToModels,
      field.ignoreRaw,
      foreignKey,
      candidateKey,
    );
  }

  final String? candidateKey;
  final String? foreignKey;
}

class ModelDefinition {
  final String name;
  final List<FieldDefinition> columns;
  final SupabaseTable? supabaseTable;

  ModelDefinition(this.name, this.columns, this.supabaseTable);

  factory ModelDefinition.fromAnnotation(ConstantReader annotation) {
    try {
      final name = annotation.read('name').stringValue;
      final columns = annotation.read('columns').listValue
          .map((e) => FieldDefinition.fromAnnotation(ConstantReader(e)))
          .toList();

      final supabaseTableObj = annotation.peek('supabaseTable');
      SupabaseTable? supabaseTable;
      if (supabaseTableObj != null && !supabaseTableObj.isNull) {
        final tableNameObj = supabaseTableObj.read('tableName');
        final tableName = tableNameObj.isNull ? null : tableNameObj.stringValue;
        supabaseTable = SupabaseTable(tableName: tableName);
      }

      return ModelDefinition(name, columns, supabaseTable);
    } catch (e) {
      print('Error in ModelDefinition.fromAnnotation: $e');
      rethrow;
    }
  }
}