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
    final schemas = library.annotatedWith(TypeChecker.fromRuntime(KimappSchema));
    if (schemas.isEmpty) return '';

    final buffer = StringBuffer();
    buffer.writeln("// ignore_for_file: invalid_annotation_target, unused_import");
    buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
    buffer.writeln("import 'package:kimapp/kimapp.dart';");
    buffer.writeln();

    final currentFilePath = buildStep.inputId.path;
    final currentFileName = path.basename(currentFilePath);
    final basename = path.basenameWithoutExtension(currentFilePath);

    final imports = _getSourceFileImports(library);
    for (final import in imports) {
      if (!import.contains(basename)) buffer.writeln(import);
    }

    buffer.writeln("import '$currentFileName';");
    buffer.writeln();
    buffer.writeln("part '${basename}.schema.freezed.dart';");
    buffer.writeln("part '${basename}.schema.g.dart';");
    buffer.writeln();

    for (final schema in schemas) {
      final annotation = ConstantReader(schema.annotation.objectValue);
      final tableName = _safeRead(annotation, 'tableName', 'string')!;
      final className = _safeRead(annotation, 'className', 'string') ?? tableName.pascalCase;
      final baseModelName = _safeRead(annotation, 'baseModelName', 'string') ?? '${className}RawModel';
      
      final fields = _safeReadList(annotation, 'fields')
          .map((e) => _createFieldDefinition(ConstantReader(e)))
          .toList();

      final models = _safeReadList(annotation, 'models')
          .map((e) => ModelDefinition.fromAnnotation(ConstantReader(e)))
          .toList();

      _checkDuplicateFields(fields);

      final idField = fields.firstWhereOrNull((field) => field is IdFieldDefinition);
      if (idField != null) {
        buffer.writeln(_generateIdClass(idField as IdFieldDefinition, className));
      }

      buffer.writeln(_generateTableConstraintClass(tableName, fields, className));
      buffer.writeln(_generateBaseModelClass(baseModelName, tableName, fields));

      for (final model in models) {
        buffer.writeln(_generateModelClass(model, fields, className, tableName));
      }

      _checkIncorrectModelNames(fields, models);
    }

    return buffer.toString();
  }

   Set<String> _getSourceFileImports(LibraryReader library) {
    final imports = Set<String>();
    for (var import in library.element.importedLibraries) {
        final uri = import.source.uri;
          String importStr = "import '${uri.toString()}';";
          
          // Avoid duplicating package imports
          if (!uri.isScheme('dart') &&

              !uri.toString().contains('package:flutter/') && 
              !uri.toString().contains('package:flutter_riverpod/') &&
              !uri.toString().contains('package:riverpod/') &&
              !uri.toString().contains('annotation/') &&
              !uri.toString().contains('package:kimapp/')) {
            imports.add(importStr);
          }
    }

    return imports;
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
      final fieldType = _safeRead(reader, 'fieldType', 'string') ?? 'Field';
      switch (fieldType) {
        case 'IdField':
          return IdFieldDefinition.fromAnnotation(reader);
        case 'JoinField':
          return JoinFieldDefinition.fromAnnotation(reader);
        default:
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
    final buffer = StringBuffer();

    buffer.writeln('/// Represents the unique identifier for a $className.');
    buffer.writeln('/// This class wraps the `${idField.type}` value, providing type safety and encapsulation.');
    buffer.writeln('class $idClassName extends Identity<${idField.type}> {');
    buffer.writeln('  const $idClassName._(this.value);');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  final ${idField.type} value;');
    buffer.writeln();
    buffer.writeln('  /// Creates an instance of $idClassName from a JSON value.');
    buffer.writeln('  /// Accepts ${idField.type} representations.');
    buffer.writeln('  /// Throws ArgumentError if the value is null or not of type ${idField.type}.');
    buffer.writeln('  factory $idClassName.fromJson(dynamic value) {');
    buffer.writeln('    if (value is ${idField.type}) {');
    buffer.writeln('      return $idClassName._(value);');
    buffer.writeln('    } else if (value == null) {');
    buffer.writeln('      throw ArgumentError.notNull(\'value\');');
    buffer.writeln('    } else {');
    buffer.writeln('      throw ArgumentError(\'Value of $idClassName must be of type ${idField.type}, but was \${value.runtimeType}. Please provide the correct type.\');');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  /// Creates an instance of $idClassName from a ${idField.type} value.');
    buffer.writeln('  factory $idClassName.fromValue(${idField.type} value) {');
    buffer.writeln('    return $idClassName._(value);');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateTableConstraintClass(String tableName, List<FieldDefinition> columns, String className) {
    final buffer = StringBuffer();

    final idColumns = columns.where((col) => col is IdFieldDefinition).toList();
    final regularColumns = columns.where((col) => col is! IdFieldDefinition && col is! JoinFieldDefinition).toList();
    final joinColumns = columns.whereType<JoinFieldDefinition>().toList();

    buffer.writeln("/// Defines the table structure for $className.");
    buffer.writeln("/// This class provides constant string values for table and column names,");
    buffer.writeln("/// facilitating type-safe database operations and query building.");
    buffer.writeln("class ${className}Table {");
    buffer.writeln("  const ${className}Table._();");
    buffer.writeln();
    buffer.writeln('  /// The name of the database table for $className entities.');
    buffer.writeln('  /// Use this constant for constructing SQL queries to ensure consistency.');
    buffer.writeln('  static const String table = "${tableName.toLowerCase()}";');
    buffer.writeln();

    for (final column in columns) {
      if (column is JoinFieldDefinition) {
        continue;
      } else {
        buffer.writeln('  /// Column: ${column.name}');
        buffer.writeln('  /// Represents the ${column.name.replaceAll('_', ' ')} of the $className entity.');
        if (column is IdFieldDefinition) {
          buffer.writeln('  /// This is the primary key column for the $className table.');
          buffer.writeln('  /// Data type: `${column.type}`');
        } else if (column.type != null) {
          buffer.writeln('  /// Data type: `${column.type}`');
        }
        buffer.writeln('  static const String ${column.name.camelCase} = "${column.name}";');
      }
      buffer.writeln();
    }

    buffer.writeln('  /// List of all column names for $className table.');
    buffer.writeln('  static const List<String> allColumns = [');
    for (final column in columns) {
      if (column is JoinFieldDefinition) {
        continue;
      }
      buffer.writeln('    ${column.name.camelCase},');
    }
    buffer.writeln('  ];');
    buffer.writeln();

    if (idColumns.isNotEmpty) {
      buffer.writeln('  /// List of primary key column names for $className table.');
      buffer.writeln('  static const List<String> primaryKeys = [');
      for (final column in idColumns) {
        buffer.writeln('    ${column.name.camelCase},');
      }
      buffer.writeln('  ];');
      buffer.writeln();
    }

    buffer.writeln();
    buffer.writeln("}");
    return buffer.toString();
  }
  
  String _generateBaseModelClass(String baseModelName, String tableName, List<FieldDefinition> columns) {
    final buffer = StringBuffer();
    final idField = columns.firstWhereOrNull((col) => col is IdFieldDefinition) as IdFieldDefinition?;

    buffer.writeln('/// Base model class for $baseModelName.');
    buffer.writeln('@freezed');
    buffer.writeln('class $baseModelName with _\$$baseModelName {');
    buffer.writeln('  const $baseModelName._();');
    buffer.writeln();
    buffer.writeln('  @TableModel("$tableName")');
    buffer.writeln('  const factory $baseModelName({');

    // Handle ID field first
    if (idField != null) {
      final idType = idField.generateAs ?? '${baseModelName}Id';
      buffer.writeln('    /// ${idField.name} field');
      buffer.writeln('    @JsonKey(name: "${idField.name}") required $idType ${idField.name.camelCase},');
    }

    // Handle other fields
    for (final column in columns) {
      if (column is! IdFieldDefinition && !column.ignoreRaw && column.type != null) {
        final nullabilitySuffix = column.type!.endsWith('?') ? '' : '';
        final requiredKeyword = column.type!.endsWith('?') ? '' : 'required ';
        buffer.writeln('    /// ${column.name} field');
        if (column is JoinFieldDefinition) {
          buffer.writeln('    @JoinedColumn(foreignKey: ${column.foreignKey == null ? null : '"${column.foreignKey}"'}, candidateKey: ${column.candidateKey == null ? null : '"${column.candidateKey}"'})');
          buffer.writeln('    @JsonKey(name: "${column.name}") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
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
    final idField = schemaColumns.firstWhereOrNull((col) => col is IdFieldDefinition) as IdFieldDefinition?;

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

    // Add ID field if it exists and should be inherited
    if (idField != null && (model.inheritAllFields || idField.addToModels.contains(model.name))) {
      final idType = idField.generateAs ?? '${className}Id';
      fields.add('    @JsonKey(name: "${idField.name}") required $idType ${idField.name.camelCase},');
    }

    // Add fields from schema columns that are included in this model
    for (final column in schemaColumns) {
      if (column is! IdFieldDefinition && 
          (model.inheritAllFields || column.addToModels.contains(model.name)) && 
          column.type != null) {
        final nullabilitySuffix = column.type!.endsWith('?') ? '' : '';
        final requiredKeyword = column.type!.endsWith('?') ? '' : 'required ';
        if (column is JoinFieldDefinition) {
          fields.add('    @JoinedColumn(foreignKey: ${column.foreignKey == null ? null : '"${column.foreignKey}"'}, candidateKey: ${column.candidateKey == null ? null : '"${column.candidateKey}"'})');
          fields.add('    @JsonKey(name: "${column.name}") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
        } else {
          fields.add('    @JsonKey(name: "${column.name}") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
        }
      }
    }

    // Add model-specific fields
    for (final field in model.fields) {
      if (field.type != null) {
        final nullabilitySuffix = field.type!.endsWith('?') ? '' : '';
        final requiredKeyword = field.type!.endsWith('?') ? '' : 'required ';
        if (field is JoinFieldDefinition) {
          fields.add('    @JoinedColumn(foreignKey: ${field.foreignKey == null ? null : '"${field.foreignKey}"'}, candidateKey: ${field.candidateKey == null ? null : '"${field.candidateKey}"'})');
          fields.add('    @JsonKey(name: "${field.name}") $requiredKeyword${field.type}$nullabilitySuffix ${field.name.camelCase},');
        } else {
          fields.add('    @JsonKey(name: "${field.name}") $requiredKeyword${field.type}$nullabilitySuffix ${field.name.camelCase},');
        }
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
    final name = annotation.read('name').stringValue;
    final typeObj = annotation.peek('type');
    
    String? type;
    String? typeModifier;
    
    if (typeObj != null && !typeObj.isNull) {
      final typeField = typeObj.objectValue.getField('type');
      final typeModifierField = typeObj.objectValue.getField('typeModifier');
      
      type = typeField?.toTypeValue()?.getDisplayString(withNullability: false);
      typeModifier = typeModifierField?.toStringValue();
      
      if (type == null && typeModifier == '?') {
        throw InvalidGenerationSourceError('Type is required for field "$name".');
      }
      
      type = _constructFullType(type, typeModifier);
    }
    
    return FieldDefinition(
      name,
      type,
      annotation.read('addToModels').listValue
        .map((e) => e.toStringValue())
        .whereType<String>()
        .toList(),
      annotation.read('ignoreRaw').boolValue,
    );
  }

  static String? _constructFullType(String? baseType, String? modifier) {
    if (baseType == null && modifier == null) return null;
    if (modifier == null) return baseType;
    if (modifier == '?') return '$baseType?';
    return modifier.endsWith('?') ? modifier : modifier;
  }
  final String name;
  final String? type;
  final List<String> addToModels;
  final bool ignoreRaw;
}

class IdFieldDefinition extends FieldDefinition {
  IdFieldDefinition(String name, String? type, List<String> addToModels, bool ignoreRaw, this.generateAs)
      : super(name, type, addToModels, ignoreRaw);

  factory IdFieldDefinition.fromAnnotation(ConstantReader annotation) {
    final field = FieldDefinition.fromAnnotation(annotation);
    final generateAs = annotation.read('generateAs').stringValue;

    return IdFieldDefinition(field.name, field.type, field.addToModels, field.ignoreRaw, generateAs);
  }

  final String? generateAs;
}

class JoinFieldDefinition extends FieldDefinition {
  JoinFieldDefinition(String name, String? type, List<String> addToModels, bool ignoreRaw, this.foreignKey, this.candidateKey)
      : super(name, type, addToModels, ignoreRaw);

  factory JoinFieldDefinition.fromAnnotation(ConstantReader annotation) {
    final field = FieldDefinition.fromAnnotation(annotation);
    final foreignKey = annotation.peek('foreignKey')?.stringValue;
    final candidateKey = annotation.peek('candidateKey')?.stringValue;

    return JoinFieldDefinition(field.name, field.type, field.addToModels, field.ignoreRaw, foreignKey, candidateKey);
  }

  final String? foreignKey;
  final String? candidateKey;
}

class ModelDefinition {
  ModelDefinition(this.name, this.fields, this.supabaseTable, this.inheritAllFields);

  factory ModelDefinition.fromAnnotation(ConstantReader annotation) {
    final name = annotation.read('name').stringValue;
    final fields = annotation.read('fields').listValue
        .map((e) => FieldDefinition.fromAnnotation(ConstantReader(e)))
        .toList();

    final supabaseTableObj = annotation.peek('supabaseTable');
    SupabaseTable? supabaseTable;
    if (supabaseTableObj != null && !supabaseTableObj.isNull) {
      final tableNameObj = supabaseTableObj.read('tableName');
      final tableName = tableNameObj.isNull ? null : tableNameObj.stringValue;
      supabaseTable = SupabaseTable(tableName: tableName);
    }

    final inheritAllFields = annotation.read('inheritAllFields').boolValue;

    return ModelDefinition(name, fields, supabaseTable, inheritAllFields);
  }

  final String name;
  final List<FieldDefinition> fields;
  final SupabaseTable? supabaseTable;
  final bool inheritAllFields;
}