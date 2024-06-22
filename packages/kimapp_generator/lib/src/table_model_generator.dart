import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kimapp/kimapp.dart';
import 'package:source_gen/source_gen.dart';

class TableModelGenerator extends GeneratorForAnnotation<TableModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw 'Only classes can be annotated with @TableModel. $element is not a ClassElement.';
    }

    /// Freezed generated has been update, in order to get the class name, we need to get nested class supertype
    final className = element.supertype!.element.supertype.toString();
    final tableName = annotation.peek('tableName')?.stringValue;

    final constructor = element.unnamedConstructor;
    if (constructor is! ConstructorElement) {
      throw 'Default constructor for ${element.name} is missing';
    }

    final fields = <TableFieldInfo>[];

    for (final fieldElement in constructor.parameters) {
      String? key;
      String? candidateKey;
      String? foreignKey;
      String? joinedModel;

      // Ignore this and continue to next if the fieldElement is private
      if (fieldElement.isPrivate) {
        continue;
      }

      const checker = TypeChecker.fromRuntime(JsonKey);

      final annotation = checker.firstAnnotationOf(fieldElement);

      final reader = ConstantReader(annotation);

      if (reader.peek('ignore')?.boolValue == true) {
        break;
      }

      key = reader.peek('name')?.stringValue;

      // If the field is a list, we add more algorithm to check if it is a joined column
      if (_fieldHasAnnotation(JoinedColumn, fieldElement)) {
        const checker = TypeChecker.fromRuntime(JoinedColumn);
        final annotation = checker.firstAnnotationOf(fieldElement);
        final reader = ConstantReader(annotation);
        candidateKey = reader.peek('candidateKey')?.stringValue;
        foreignKey = reader.peek('foreignKey')?.stringValue;
        if (fieldElement.type.isDartCoreList || fieldElement.type.toString().contains('IList')) {
          var elementType = fieldElement.type as ParameterizedType;
          var listType = elementType.typeArguments[0].toString();
          joinedModel = listType;
        } else {
          joinedModel = fieldElement.type.toString();
        }
      }

      key ??= fieldElement.name;

      fields.add(
        TableFieldInfo(
          key: key,
          candidateKey: candidateKey,
          foreignKey: foreignKey,
          joinedModel: joinedModel,
        ),
      );
    }

    final classBuffer = StringBuffer();

    classBuffer.writeln(
        'const _table${className.replaceAll('_', '').replaceAll('\$', '')} = TableBuilder(');
    classBuffer.writeln(' tableName: "$tableName",');
    classBuffer.writeln(' columns: [');

    for (final f in fields) {
      if (f.joinedModel != null) {
        classBuffer.writeln(
          " ColumnBuilder.join(${f.joinedModel!.replaceAll('?', '')}.table, key: ${f.key == null ? "null" : '"${f.key}"'}, candidateKey: ${f.candidateKey == null ? 'null' : "'${f.candidateKey}'"}, foreignKey: ${f.foreignKey == null ? "null" : "'${f.foreignKey}'"}),",
        );
      } else {
        classBuffer.writeln(" ColumnBuilder('${f.key}'),");
      }
    }

    classBuffer.writeln(' ],');
    classBuffer.writeln(');');

    return classBuffer.toString();
  }
}

bool _fieldHasAnnotation(Type annotationType, ParameterElement element) {
  final annotations = TypeChecker.fromRuntime(annotationType).annotationsOf(element);
  return annotations.isNotEmpty;
}

class TableFieldInfo {
  final String? key;
  final String? candidateKey;
  final String? foreignKey;
  final String? joinedModel;
  TableFieldInfo({
    this.key,
    this.candidateKey,
    this.foreignKey,
    this.joinedModel,
  });
}
