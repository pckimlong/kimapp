import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:riverpod_widget_generator/src/models/provider_definition.dart';
import 'package:riverpod_widget_generator/src/templates/comment_generator.dart';
import 'package:riverpod_widget_generator/src/templates/sub_proxy_widget.dart';
import 'package:riverpod_widget_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

import '../../riverpod_widget_generator.dart';
import '../templates/proxy_widget_ref.dart';

class RiverpodStateWidgetGenerator extends GeneratorForAnnotation<StateWidget> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final baseName = element.name!;
    final baseProxy = baseProxyWidgetRef(
      baseName,
      classComment: CommentGenerator(lines: ['Testing'], macro: 'baseProxy'),
    );

    final subProxyName = '_${baseName}SubProxyWidgetRef';
    final subProxy = subProxyWidget(
      subProxyName,
      baseName: baseName,
      classComment: CommentGenerator(lines: ['SubProxy'], macro: 'subProxy'),
      finalFields: [
        Field(
          (b) =>
              b
                ..modifier = FieldModifier.final$
                ..name = 'test'
                ..type = refer('String'),
        ),
      ],
    );

    final buffer = StringBuffer();
    buffer.writeln(baseProxy);
    buffer.writeln(subProxy);
    final definition = ProviderDefinition.parse(element);
    buffer.writeln('final providerDefinition = ${jsonEncode(definition.toMap())};');
    return buffer.toString();
  }

  String animalClass() {
    final animal = Class(
      (b) =>
          b
            ..name = 'Testing'
            ..methods.add(
              Method.returnsVoid(
                (b) =>
                    b
                      ..name = 'eat'
                      ..body = refer('print').call([literalString('Yum!')]).code,
              ),
            ),
    );

    return animal.toDart();
  }
}
