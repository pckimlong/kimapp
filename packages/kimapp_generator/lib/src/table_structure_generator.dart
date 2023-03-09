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

    final prefixName = annotation.read('classPrefixName');
    final className =
        prefixName.isNull ? "${tableName.pascalCase}Table" : "${prefixName.stringValue}Table";
    final columns = annotation.read('columns').listValue.map((e) => e.toStringValue()!);

    final classBuffer = StringBuffer();

    classBuffer.writeln("class $className {");
    classBuffer.writeln(" const $className._();");
    classBuffer.writeln("");
    classBuffer.writeln(' static const String table = "${tableName.toLowerCase()}";');
    classBuffer.writeln("");

    for (final col in columns) {
      classBuffer.writeln(' static const String ${_snakeCaseToCamelCase(col)} = "$col";');
    }
    classBuffer.writeln("}");

    return classBuffer.toString();
  }

  String _snakeCaseToCamelCase(String value) {
    if (value.isEmpty) return value;
    return value.camelCase;
  }
}
