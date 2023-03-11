import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:recase/recase.dart';
import 'package:kimapp/kimapp.dart';
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

    final tableClassName = "${className}Table";
    final columns = annotation.read('columns').listValue.map((e) => e.toStringValue()!);

    /// Generate id class if any
    final idColumns = annotation.peek('idColumn')?.stringValue;
    final generateIdClass = idColumns != null;
    String? idClassName;
    String? idDataType;
    if (generateIdClass) {
      if (!idColumns.contains(':')) {
        throw 'Error trying to parse idColumn string. To generate id class [idColumn] must include data type. eg [IdClassName:DataType]';
      }

      idClassName = idColumns.split(':').first.pascalCase;
      idDataType = idColumns.split(':').last;
    }

    // Generate class
    final List<String> generatedColumns = [];
    final Map<String, String> rawModelClass = {};

    for (final col in columns) {
      // Check if column has special characters
      if (col.contains(':')) {
        final columnAndType = col.split(':');
        if (columnAndType.length != 2) {
          throw 'Error trying to parse column name. To generate raw data class model column must provider [ColumnName:DataType]';
        }

        final columnName = columnAndType.first;
        final dataType = columnAndType.last;

        final columnString = ' static const String ${columnName.camelCase} = "$columnName";';
        generatedColumns.add(columnString);

        rawModelClass.addAll({columnName.camelCase: dataType});
        break;
      }

      final columnString = ' static const String ${col.camelCase} = "$col";';
      generatedColumns.add(columnString);
    }

    final classBuffer = StringBuffer();

    /// Add freezed import if able to generate raw model class
    if (rawModelClass.isNotEmpty) {
      classBuffer.write(
        '''
        // ignore_for_file: invalid_annotation_target

        import 'package:freezed_annotation/freezed_annotation.dart';
        part 'wow.g.dart';
        part 'wow.freezed.dart';
      ''',
      );
    }

    /// Generate id class
    if (generateIdClass) {
      classBuffer.writeln("class $idClassName extends Identity<String> {");
      classBuffer.writeln("const $idClassName._{};");
      classBuffer.writeln("");
      classBuffer.writeln("@override");
      classBuffer.writeln("final $idDataType value");
      classBuffer.writeln("");
      classBuffer.writeln("factory $idClassName.fromJson(dynamic value) {");
      classBuffer.writeln("return $idClassName._(value);");
      classBuffer.writeln("}");
      classBuffer.writeln("factory $idClassName.fromValue($idDataType value) {");
      classBuffer.writeln("return $idClassName._(value);");
      classBuffer.writeln("}");
      classBuffer.writeln("}");
    }

    /// Generate table class
    classBuffer.writeln("class $tableClassName {");
    classBuffer.writeln(" const $tableClassName._();");
    classBuffer.writeln("");
    classBuffer.writeln(' static const String table = "${tableName.toLowerCase()}";');
    classBuffer.writeln("");
    classBuffer.write(generatedColumns.join('\n'));
    classBuffer.writeln("}");

    /// Generate raw model class
    if (rawModelClass.isNotEmpty) {
      classBuffer.write(
        '''
      @freezed
      class ${className}RawModel with _\$${className}RawModel {
        const ${className}RawModel._();

        const factory ${className}RawModel({
      ''',
      );

      // properties
      for (final key in rawModelClass.keys) {
        final dataType = rawModelClass[key]!;
        classBuffer.writeln('@JsonKey($tableName.$key) required $dataType $key,');
      }

      classBuffer.write(
        '''
      }) = _${className}RawModel;

        factory ${className}RawModel.fromJson(Map<String, dynamic> json) => _\$${className}RawModelFromJson(json);
      }
      ''',
      );
    }

    return classBuffer.toString();
  }
}
