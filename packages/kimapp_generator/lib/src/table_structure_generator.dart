import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:kimapp/annotation.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

class TableStructureGenerator extends GeneratorForAnnotation<TableStructure> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final tableName = annotation.read('tableName').stringValue;
    final prefixName = annotation.peek('classPrefixName')?.stringValue;
    final className = prefixName == null ? tableName.pascalCase : prefixName.pascalCase;
    final columns = annotation.read('columns').listValue
        .map((e) => e.toStringValue()!)
        .toList();
    final idColumn = annotation.peek('idColumn')?.stringValue;
    final additionalClasses = annotation.read('additionalClasses').listValue
        .map((e) => e.toStringValue()!)
        .toList();
    final generateRawClass = annotation.read('generateRawClass').boolValue;

    final buffer = StringBuffer();

    buffer.writeln("// ignore_for_file: invalid_annotation_target, unnecessary_import");

    // Add necessary imports
    buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
    buffer.writeln("import 'package:json_annotation/json_annotation.dart';");
    buffer.writeln("import 'package:kimapp/kimapp.dart';");
    buffer.writeln();
    buffer.writeln("part 'table_structure_example.table.freezed.dart';");
    buffer.writeln("part 'table_structure_example.table.g.dart';");
    buffer.writeln();

    // Generate ID class if idColumn is provided
    if (idColumn != null) {
      buffer.writeln(_generateIdClass(idColumn));
    }

    // Generate table class
    buffer.writeln(_generateTableClass(tableName, columns, className));

    // Generate raw data class if specified
    if (generateRawClass) {
      buffer.writeln(_generateRawDataClass(className, columns));
    }

    // Generate additional Freezed classes
    for (final additionalClass in additionalClasses) {
      buffer.writeln(_generateAdditionalClass(additionalClass, columns, className));
    }

    return buffer.toString();
  }

  String _generateIdClass(String idColumn) {
    final parts = idColumn.split(':');
    if (parts.length != 2) {
      throw 'Error trying to parse idColumn string. To generate id class [idColumn] must include data type. eg [IdClassName:DataType]';
    }
    final className = parts[0].pascalCase;
    final dataType = parts[1];

    return '''
class $className extends Identity<$dataType> {
  const $className._(this.value);

  @override
  final $dataType value;

  factory $className.fromJson(dynamic value) {
    return $className._(value);
  }

  factory $className.fromValue($dataType value) {
    return $className._(value);
  }
}
''';
  }

  String _generateTableClass(String tableName, List<String> columns, String className) {
    final buffer = StringBuffer();
    buffer.writeln("class ${className}Table {");
    buffer.writeln("  const ${className}Table._();");
    buffer.writeln();
    buffer.writeln('  static const String table = "${tableName.toLowerCase()}";');
    buffer.writeln();

    for (final column in columns) {
      final parts = column.split(':');
      final columnName = parts[0];

      // Ensure column name starts with a letter and contains only valid characters
      if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(columnName)) {
        throw 'Invalid column name: $columnName. Column names must start with a letter and contain only letters, numbers, and underscores.';
      }

      buffer.writeln('  static const String ${columnName.camelCase} = "$columnName";');
    }

    buffer.writeln("}");
    return buffer.toString();
  }

  String _generateRawDataClass(String className, List<String> columns) {
    final buffer = StringBuffer();
    final props = <String, String>{};

    for (final column in columns) {
      final parts = column.split(':');
      if (parts.length == 2) {
        props[parts[0]] = parts[1].split('[')[0];
      }
    }

    buffer.writeln('@JsonSerializable()');
    buffer.writeln('class ${className}RawModel {');
    buffer.writeln('  ${className}RawModel({');
    for (final prop in props.keys) {
      final isNullable = props[prop]!.endsWith('?');
      buffer.writeln('    @JsonKey(name: \'$prop\') ${isNullable ? '' : 'required '}this.${prop.camelCase},');
    }
    buffer.writeln('  });');
    buffer.writeln();

    for (final entry in props.entries) {
      buffer.writeln('  @JsonKey(name: \'${entry.key}\')');
      buffer.writeln('  final ${entry.value} ${entry.key.camelCase};');
    }

    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  bool operator ==(covariant ${className}RawModel other) {');
    buffer.writeln('    if (identical(this, other)) return true;');
    buffer.writeln();
    buffer.writeln('    return ${props.keys.map((e) => "other.${e.camelCase} == ${e.camelCase}").join(' && ')};');
    buffer.writeln('  }');
    buffer.writeln();

    buffer.writeln('  @override');
    buffer.writeln('  int get hashCode => ${props.keys.map((e) => "${e.camelCase}.hashCode").join(' ^ ')};');
    buffer.writeln();

    buffer.writeln('  @override');
    buffer.writeln("  String toString() => '${className}RawModel(${props.keys.map((e) => "${e.camelCase}: \$${e.camelCase}").join(', ')})';");
    buffer.writeln();

    buffer.writeln('  ${className}RawModel copyWith({');
    for (final entry in props.entries) {
      final type = entry.value.endsWith('?') ? entry.value : '${entry.value}?';
      buffer.writeln('    $type ${entry.key.camelCase},');
    }
    buffer.writeln('  }) {');
    buffer.writeln('    return ${className}RawModel(');
    for (final prop in props.keys) {
      buffer.writeln('      ${prop.camelCase}: ${prop.camelCase} ?? this.${prop.camelCase},');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');

    buffer.writeln();
    buffer.writeln('  factory ${className}RawModel.fromJson(Map<String, dynamic> json) => _\$${className}RawModelFromJson(json);');
    buffer.writeln('  Map<String, dynamic> toJson() => _\$${className}RawModelToJson(this);');

    buffer.writeln('}');
    return buffer.toString();
  }
String _generateAdditionalClass(String additionalClass, List<String> defaultColumns, String parentClassName) {
    final buffer = StringBuffer();
    final parts = additionalClass.split(':');
    final className = parts[0];
    bool isTableModel = false;
    String? customTableName;
    List<String> customColumns = [];

    // Check if it's a TableModel
    if (parts.length > 1 && parts[1].startsWith('table')) {
      isTableModel = true;
      if (parts[1].contains('(') && parts[1].contains(')')) {
        customTableName = parts[1].substring(parts[1].indexOf('(') + 1, parts[1].indexOf(')'));
      }
    }

    // Parse custom columns if provided
    final customColumnMatch = RegExp(r'\[(.*?)\]').firstMatch(additionalClass);
    if (customColumnMatch != null) {
      customColumns = customColumnMatch.group(1)!.split(',');
    }

    final columnsToUse = customColumns.isNotEmpty ? customColumns : defaultColumns;

    if (isTableModel) {
      buffer.writeln('@freezed');
      buffer.writeln('class $className with _\$$className {');
      buffer.writeln('  const $className._();');
      buffer.writeln();
      buffer.writeln('  @TableModel(${customTableName ?? parentClassName}Table.table)');
      buffer.writeln('  const factory $className({');

      for (final column in columnsToUse) {
        final parts = column.split(':');
        if (parts.length == 2) {
          final columnName = parts[0];
          final dataType = parts[1].split('[')[0];
          final isNullable = dataType.endsWith('?');
          buffer.writeln('    @JsonKey(name: ${parentClassName}Table.${columnName.camelCase}) ${isNullable ? '' : 'required '}$dataType ${columnName.camelCase},');
        }
      }

      buffer.writeln('  }) = _$className;');
      buffer.writeln();
      buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);');
      buffer.writeln();
      buffer.writeln('  static const TableBuilder table = _table$className;');
      buffer.writeln('}');
    } else {
      buffer.writeln('@freezed');
      buffer.writeln('class $className with _\$$className {');
      buffer.writeln('  const $className._();');
      buffer.writeln('  const factory $className({');

      for (final column in columnsToUse) {
        final parts = column.split(':');
        if (parts.length == 2) {
          final columnName = parts[0];
          final dataType = parts[1].split('[')[0];
          final isNullable = dataType.endsWith('?');
          buffer.writeln('    @JsonKey(name: \'$columnName\') ${isNullable ? '' : 'required '}$dataType ${columnName.camelCase},');
        }
      }

      buffer.writeln('  }) = _$className;');
      buffer.writeln();
      buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);');
      buffer.writeln('}');
    }

    return buffer.toString();
  }

  List<int> _parseIndices(String columnDefinition) {
    final match = RegExp(r'\[(.*?)\]').firstMatch(columnDefinition);
    if (match != null) {
      return match.group(1)!.split(',').map(int.parse).toList();
    }
    return [];
  }
}
