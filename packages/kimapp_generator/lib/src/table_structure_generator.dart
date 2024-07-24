import 'package:build/build.dart';
import 'package:kimapp/annotation.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

const _dartCoreTypes = {'String', 'int', 'double', 'bool', 'DateTime', 'Map', 'List', 'Set', 'Object'};
class ColumnDefinition {
  final String name;
  final String? type;
  final bool isNullable;
  final List<int> additionalInfo;
  final String? foreignKey;

  ColumnDefinition(this.name, this.type, this.isNullable, this.additionalInfo, this.foreignKey);

  factory ColumnDefinition.parse(String columnDef) {
    final parts = columnDef.split(':');
    final name = parts[0].trim();
    String? type;
    bool isNullable = false;
    List<int> additionalInfo = [];
    String? foreignKey;

    if (parts.length > 1) {
      final typeAndInfo = parts[1].split('[');
      type = typeAndInfo[0].trim();
      isNullable = type.endsWith('?');
      type = type.replaceAll('?', '');

      if (typeAndInfo.length > 1) {
        additionalInfo = typeAndInfo[1].replaceAll(']', '').split(',').map(int.parse).toList();
      }

      final foreignKeyMatch = RegExp(r'\((.*?)\)').firstMatch(parts[1]);
      if (foreignKeyMatch != null) {
        foreignKey = foreignKeyMatch.group(1);
        // Remove the foreign key part from the type
        type = type.split('(')[0].trim();
      }
    }

    return ColumnDefinition(name, type, isNullable, additionalInfo, foreignKey);
  }

  bool get hasExplicitType => type != null;
  bool get isJoinColumn => foreignKey != null;

  String? get baseType {
    if (type == null) return null;
    final genericMatch = RegExp(r'^(\w+)<').firstMatch(type!);
    return genericMatch != null ? genericMatch.group(1) : type;
  }
}
class AdditionalClassDefinition {
  final String className;
  final String? tableName;
  final List<ColumnDefinition> columns;
  final int classIndex;

  AdditionalClassDefinition(this.className, this.tableName, this.columns, this.classIndex);

  factory AdditionalClassDefinition.parse(String additionalClass, List<ColumnDefinition> baseColumns, int index, String defaultTableName) {
    final parts = additionalClass.split(':');
    final className = parts[0];
    String? tableName;
    List<ColumnDefinition> columns = [];

    if (parts.length > 1 && parts[1].startsWith('table')) {
      final tableMatch = RegExp(r'table(\((.*?)\))?').firstMatch(parts[1]);
      if (tableMatch != null) {
        tableName = tableMatch.group(2) ?? defaultTableName;
      } else {
        tableName = defaultTableName;
      }
    }

    final columnMatch = RegExp(r'\[(.*?)\]').firstMatch(additionalClass);
    if (columnMatch != null) {
      columns = columnMatch.group(1)!.split(',').map((col) => ColumnDefinition.parse(col.trim())).toList();
    } 

    final effectiveBaseColumns = baseColumns.where((col) => col.additionalInfo.contains(index)).toList();

    return AdditionalClassDefinition(className, tableName, [...effectiveBaseColumns, ...columns], index);
  }

  bool get isTableModel => tableName != null;
}

class TableStructureGenerator extends Generator {
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
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final providers = library.annotatedWith(TypeChecker.fromRuntime(TableStructure));

    if (providers.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();

    buffer.writeln("// ignore_for_file: invalid_annotation_target, unused_import");

    final imports = _getSourceFileImports(library);
    
    final currentFilePath = buildStep.inputId.path;
    final currentFileName = path.basename(currentFilePath);
    imports.add("import '$currentFileName';");

    // Add necessary imports
    buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
    buffer.writeln("import 'package:kimapp/kimapp.dart';");
    buffer.writeln();
    buffer.writeln(imports.join('\n'));
    buffer.writeln();

    bool hasGeneratedClasses = false;

    // First pass: check if any classes will be generated
    for (final provider in providers) {
      final annotation = provider.annotation;
      final generateRawClass = annotation.read('generateRawClass').boolValue;
      final additionalClasses = annotation.read('additionalClasses').listValue;

      if (generateRawClass || additionalClasses.isNotEmpty) {
        hasGeneratedClasses = true;
        break;
      }
    }

    // Add part statements if classes will be generated
    if (hasGeneratedClasses) {
      buffer.writeln("part '${path.basenameWithoutExtension(currentFilePath)}.table.freezed.dart';");
      buffer.writeln("part '${path.basenameWithoutExtension(currentFilePath)}.table.g.dart';");
      buffer.writeln();
    }

    for (final provider in providers){
      final annotation = provider.annotation;

      final tableName = annotation.read('tableName').stringValue;
      final prefixName = annotation.peek('classPrefixName')?.stringValue;
      final className = prefixName == null ? tableName.pascalCase : prefixName.pascalCase;
          final columns = annotation.read('columns').listValue
          .map((e) => e.toStringValue()!)
          .toList();

      final idColumn = annotation.peek('idColumn')?.stringValue;
      
      // Validate column formats
      _validateColumnFormats(columns, idColumn);

      final parsedColumns = columns.map(ColumnDefinition.parse).toList();

      
      final additionalClasses = annotation.read('additionalClasses').listValue
          .asMap()
          .entries
          .map((entry) => AdditionalClassDefinition.parse(entry.value.toStringValue()!, parsedColumns, entry.key, tableName))
          .toList();


      final generateRawClass = annotation.read('generateRawClass').boolValue;
      final rawClassTableMode = annotation.read('rawClassTableMode').boolValue;
      final customTypes = annotation.read('customTypes').listValue
          .map((e) => e.toTypeValue()!.getDisplayString(withNullability: false))
          .toSet();

      _validateCustomTypes(parsedColumns, customTypes, idColumn);

      for (final additionalClass in additionalClasses) {
        final additionalColumns = additionalClass.columns;
        _validateCustomTypes(additionalColumns, customTypes, idColumn);
      }

      // Generate ID class if idColumn is provided
      if (idColumn != null) {
        buffer.writeln(_generateIdClass(idColumn));
      }

      // Generate table class
      buffer.writeln(_generateTableClass(tableName, parsedColumns, className));

      // Generate raw data class if specified
      if (generateRawClass) {
        buffer.writeln(_generateRawDataClass(className, parsedColumns, tableName, rawClassTableMode));
      }

      // Generate additional classes
      for (final additionalClass in additionalClasses) {
        buffer.writeln(_generateAdditionalClass(additionalClass, className));
      }
    }

    return buffer.toString();
  }

   void _validateColumnFormats(List<String> columns, String? idColumn) {
    final validFormat = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*(\:[a-zA-Z<>?,]+(\[\d+(,\d+)*\])?)?$');
    
    for (final column in columns) {
      final splitColumn = column.split(':');
      if (splitColumn.length > 1 && idColumn != null) {
        final pureDataType = splitColumn[1].replaceAll(RegExp(r'\[.*?\]'), '');
        if (pureDataType == idColumn.split(':').first) continue;
      }

      if (!validFormat.hasMatch(column)) {
        throw InvalidGenerationSourceError(
          'Invalid column format: "$column". '
          'The correct format is "name" or "name:type" or "name:type[additionalInfo]".',
          todo: 'Correct the format of the column definition.',
        );
      }
    }
  }

  void _validateCustomTypes(List<ColumnDefinition> columns, Set<String> customTypes, String? idColumn) {
    for (final column in columns) {
      if(column.baseType == idColumn?.split(':').first) continue;

      if (column.hasExplicitType && 
          !_isDartCoreType(column.baseType!) && 
          !customTypes.contains(column.baseType)) {
        throw InvalidGenerationSourceError(
          'Custom type "${column.baseType}" used in column "${column.name}" is not provided in the customTypes list.',
          todo: 'Add "${column.baseType}" to the customTypes list in the @TableStructure annotation.',
        );
      }
    }
  }
  bool _isDartCoreType(String type) {
    return _dartCoreTypes.contains(type) || type.startsWith('List<') || type.startsWith('Map<') || type.startsWith('Set<');
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


  String _generateTableClass(String tableName, List<ColumnDefinition> columns, String className) {
    final buffer = StringBuffer();

    buffer.writeln("class ${className}Table {");
    buffer.writeln("  const ${className}Table._();");
    buffer.writeln();
    buffer.writeln('  static const String table = "${tableName.toLowerCase()}";');
    buffer.writeln();

    for (final column in columns) {
      final constantName = column.name.split('[')[0].camelCase;
      buffer.writeln('  static const String $constantName = "${column.name}";');
    }

    buffer.writeln("}");
    return buffer.toString();
  }

  String _generateRawDataClass(String className, List<ColumnDefinition> columns, String tableName, bool rawClassTableMode) {
    final buffer = StringBuffer();

    buffer.writeln('@freezed');
    buffer.writeln('class ${className}RawModel with _\$${className}RawModel {');
    buffer.writeln('  const ${className}RawModel._();');
    buffer.writeln();
    
    if (rawClassTableMode) {
      buffer.writeln('  @TableModel("$tableName")');
    }
    
    buffer.writeln('  const factory ${className}RawModel({');

    for (final column in columns) {
      if (column.hasExplicitType) {
        buffer.writeln('    @JsonKey(name: "${column.name}") ${column.isNullable ? '' : 'required '}${column.type}${column.isNullable ? '?' : ''} ${column.name.camelCase},');
      }
    }

    buffer.writeln('  }) = _${className}RawModel;');
    buffer.writeln();
    buffer.writeln('  factory ${className}RawModel.fromJson(Map<String, dynamic> json) => _\$${className}RawModelFromJson(json);');
    
    if (rawClassTableMode) {
      buffer.writeln();
      buffer.writeln('  static const TableBuilder table = _table${className}RawModel;');
    }
    
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateAdditionalClass(AdditionalClassDefinition additionalClass, String parentClassName) {
    final buffer = StringBuffer();

    final classNameParts = additionalClass.className.split('[');
    final className = classNameParts[0];
    final additionalFields = classNameParts.length > 1 ? classNameParts[1].replaceAll(']', '').split(',') : [];

    buffer.writeln('@freezed');
    buffer.writeln('class $className with _\$$className {');
    buffer.writeln('  const $className._();');
    buffer.writeln();
    
    if (additionalClass.isTableModel) {
      buffer.writeln('  @TableModel("${additionalClass.tableName}")');
    }
    
    buffer.writeln('  const factory $className({');

    for (final column in additionalClass.columns) {
      if (column.isJoinColumn) {
        buffer.writeln('    @JoinedColumn(foreignKey: "${column.foreignKey}")');
      }
      final nullabilitySuffix = column.isNullable ? '?' : '';
      final requiredKeyword = column.isNullable ? '' : 'required ';
      buffer.writeln('    @JsonKey(name: "${column.name}") $requiredKeyword${column.type}$nullabilitySuffix ${column.name.camelCase},');
    }

    // Add additional fields
    for (final field in additionalFields) {
      final parts = field.split(':');
      if (parts.length == 2) {
        final fieldName = parts[0].trim();
        final fieldType = parts[1].trim();
        buffer.writeln('    required $fieldType $fieldName,');
      }
    }

    buffer.writeln('  }) = _$className;');
    buffer.writeln();
    buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);');
    
    if (additionalClass.isTableModel) {
      buffer.writeln();
      buffer.writeln('  static const TableBuilder table = _table$className;');
    }
    
    buffer.writeln('}');

    return buffer.toString();
  }
}