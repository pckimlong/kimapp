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
      throw ArgumentError(
          'Only classes can be annotated with @TableModel. $element is not a ClassElement.');
    }

    final className = _getClassName(element);
    final tableName = annotation.peek('tableName')?.stringValue;

    final constructor = element.unnamedConstructor;
    if (constructor is! ConstructorElement) {
      throw ArgumentError('Default constructor for ${element.name} is missing');
    }

    final fields = _extractFields(constructor);

    return _buildTableDefinition(className, tableName, fields);
  }

  String _getClassName(ClassElement element) {
    return element.supertype!.element.name;
  }

  List<TableFieldInfo> _extractFields(ConstructorElement constructor) {
    final fields = <TableFieldInfo>[];

    for (final fieldElement in constructor.parameters) {
      if (fieldElement.isPrivate) {
        continue;
      }

      final key = _getKeyFromJsonKey(fieldElement);
      final (candidateKey, foreignKey, joinedModel) = _getJoinedColumnInfo(fieldElement);

      fields.add(
        TableFieldInfo(
          key: key ?? fieldElement.name,
          candidateKey: candidateKey,
          foreignKey: foreignKey,
          joinedModel: joinedModel,
        ),
      );
    }

    return fields;
  }

  String? _getKeyFromJsonKey(ParameterElement fieldElement) {
    const checker = TypeChecker.fromRuntime(JsonKey);
    final annotation = checker.firstAnnotationOf(fieldElement);
    if (annotation == null) return null;

    final reader = ConstantReader(annotation);
    if (reader.peek('ignore')?.boolValue == true) {
      return null;
    }

    return reader.peek('name')?.stringValue;
  }

  (String?, String?, String?) _getJoinedColumnInfo(ParameterElement fieldElement) {
    if (!_fieldHasAnnotation(JoinedColumn, fieldElement)) {
      return (null, null, null);
    }

    const checker = TypeChecker.fromRuntime(JoinedColumn);
    final annotation = checker.firstAnnotationOf(fieldElement);
    final reader = ConstantReader(annotation);

    final candidateKey = reader.peek('candidateKey')?.stringValue;
    final foreignKey = reader.peek('foreignKey')?.stringValue;
    final joinedModel = _getJoinedModel(fieldElement);

    return (candidateKey, foreignKey, joinedModel);
  }

  String? _getJoinedModel(ParameterElement fieldElement) {
    if (fieldElement.type.isDartCoreList || fieldElement.type.toString().contains('IList')) {
      var elementType = fieldElement.type as ParameterizedType;
      return elementType.typeArguments[0].toString();
    }
    return fieldElement.type.toString();
  }

  String _buildTableDefinition(String className, String? tableName, List<TableFieldInfo> fields) {
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
