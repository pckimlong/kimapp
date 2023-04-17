import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kimapp/kimapp.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/src/dart/element/inheritance_manager3.dart' show InheritanceManager3;
import 'package:collection/collection.dart';

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

    final className = element.thisType.toString();
    final tableName = annotation.peek('tableName')?.stringValue;

    final constructor = element.unnamedConstructor;
    if (constructor is! ConstructorElement) {
      throw 'Default constructor for ${element.name} is missing';
    }

    final allField = constructor.parameters.map((e) => e as FieldElement);
    final fields = <TableFieldInfo>[];

    for (final fieldElement in allField) {
      String? key;
      String? candidateKey;
      String? foreignKey;
      String? joinedModel;

      // Ignore this and continue to next if the fieldElement is private
      if (fieldElement.isPrivate) {
        continue;
      }

      const checker = TypeChecker.fromRuntime(JsonKey);

      final annotation = checker.firstAnnotationOf(fieldElement) ??
          (fieldElement.getter == null ? null : checker.firstAnnotationOf(fieldElement.getter!));

      final reader = ConstantReader(annotation);

      if (reader.peek('ignore')?.boolValue == true) {
        break;
      }

      key = reader.peek('name')?.stringValue;

      // If the field is a list, we add more algorithm to check if it is a joined column
      if (fieldElement.type.isDartCoreList) {
        // Check if it has metadata
        if (fieldElement.metadata.isNotEmpty) {
          // Check if it has JoinedColumn
          if (_fieldHasAnnotation(JoinedColumn, fieldElement)) {
            const checker = TypeChecker.fromRuntime(JoinedColumn);
            final annotation = checker.firstAnnotationOf(fieldElement) ??
                (fieldElement.getter == null
                    ? null
                    : checker.firstAnnotationOf(fieldElement.getter!));
            final reader = ConstantReader(annotation);
            candidateKey = reader.peek('candidateKey')?.stringValue;
            foreignKey = reader.peek('foreignKey')?.stringValue;
            var elementType = fieldElement.type as ParameterizedType;
            var listType = elementType.typeArguments[0].getDisplayString(withNullability: true);
            joinedModel = listType;
          }
        } else {
          // If it doesn't have metadata, then it might be a list of freezed model
          // Use freezed workaround to get the type
          // find private field with the same name as the list
          final privateField =
              allField.firstWhereOrNull((e) => e.name == "_${fieldElement.name}" && e.isPrivate);

          // If founded then check if it has JoinedColumn
          if (privateField != null && _fieldHasAnnotation(JoinedColumn, privateField)) {
            const checker = TypeChecker.fromRuntime(JoinedColumn);
            final annotation = checker.firstAnnotationOf(privateField) ??
                (privateField.getter == null
                    ? null
                    : checker.firstAnnotationOf(privateField.getter!));
            final reader = ConstantReader(annotation);
            candidateKey = reader.peek('candidateKey')?.stringValue;
            foreignKey = reader.peek('foreignKey')?.stringValue;
            var elementType = privateField.type as ParameterizedType;
            var listType = elementType.typeArguments[0].getDisplayString(withNullability: true);
            joinedModel = listType;
          }
        }
      } else {
        // Not a list just check if it has JoinedColumn
        if (_fieldHasAnnotation(JoinedColumn, fieldElement)) {
          const checker = TypeChecker.fromRuntime(JoinedColumn);
          final annotation = checker.firstAnnotationOf(fieldElement) ??
              (fieldElement.getter == null
                  ? null
                  : checker.firstAnnotationOf(fieldElement.getter!));
          final reader = ConstantReader(annotation);
          candidateKey = reader.peek('candidateKey')?.stringValue;
          foreignKey = reader.peek('foreignKey')?.stringValue;
          if (fieldElement.type.isDartCoreList) {
            var elementType = fieldElement.type as ParameterizedType;
            var listType = elementType.typeArguments[0].getDisplayString(withNullability: true);
            joinedModel = listType;
          } else {
            joinedModel = fieldElement.type.toString();
          }
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

bool _fieldHasAnnotation(Type annotationType, FieldElement element) {
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

List<FieldElement> _getAllField(ClassElement element) {
  List<FieldElement> fieldElements = [];

  /// Since how freezed treat with list field, I need to allow private field if it is a list
  fieldElements
      .addAll(element.fields.where((e) => !e.isStatic && (!e.isPrivate || e.type.isDartCoreList)));

  final manager = InheritanceManager3();

  for (final v in manager.getInheritedConcreteMap2(element).values) {
    assert(v is! FieldElement);
    const checker = TypeChecker.fromRuntime(Object);

    if (checker.isExactly(v.enclosingElement)) {
      continue;
    }

    if (v is PropertyAccessorElement && v.isGetter) {
      final variable = v.variable as FieldElement;
      assert(!fieldElements.contains(variable));
      fieldElements.add(variable);
    }
  }

  return fieldElements;
}
