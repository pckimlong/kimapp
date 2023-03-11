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

    /// Generate id class
    if (generateIdClass) {
      classBuffer.writeln("import 'package:kimapp/kimapp.dart';");
      classBuffer.writeln();
      classBuffer.writeln("class $idClassName extends Identity<$idDataType> {");
      classBuffer.writeln(" const $idClassName._(this.value);");
      classBuffer.writeln("");
      classBuffer.writeln(" @override");
      classBuffer.writeln(" final $idDataType value;");
      classBuffer.writeln("");
      classBuffer.writeln(" factory $idClassName.fromJson(dynamic value) {");
      classBuffer.writeln("   return $idClassName._(value);");
      classBuffer.writeln(" }");
      classBuffer.writeln(" factory $idClassName.fromValue($idDataType value) {");
      classBuffer.writeln("   return $idClassName._(value);");
      classBuffer.writeln(" }");
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
      final props = rawModelClass.keys;

      String dataType(String prop) => rawModelClass[prop] as String;

      classBuffer.write(
        '''
        class ${className}RawModel {
          ${className}RawModel({
            ${props.map((e) => "required this.$e").join(',\n')}
          });

          ${props.map((e) => "final ${dataType(e)} $e;").join('\n')}

          @override
          bool operator ==(covariant ${className}RawModel other) {
            if (identical(this, other)) return true;

            return ${props.map((e) => "other.$e == $e").join('\n\t\t&&')};
          }

          @override
          int get hashCode => ${props.map((e) => "$e.hashCode").join('^')};

          @override
          String toString() => '${className}RawModel(${props.map((e) => "$e: \$$e").join(', ')})';

          ${className}RawModel copyWith({
            ${props.map((e) => "${dataType(e).endsWith('?') ? dataType(e) : "${dataType(e)}?"} $e").join(',\n')}
          }) {
            return ${className}RawModel(
              ${props.map((e) => "$e: $e ?? this.$e").join(',\n')}
            );
          }
        }
      ''',
      );
    }

    return classBuffer.toString();
  }
}
