import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../../../riverpod_widget.dart';

class FormUpdateWidgetGenerator extends WidgetGenerator {
  @override
  final TypeChecker annotationTypeChecker = const TypeChecker.fromRuntime(FormUpdateWidget);

  @override
  List<String> getRequiredImports() {
    return [
      'package:flutter/widgets.dart',
      'package:flutter/material.dart',
      'package:flutter_riverpod/flutter_riverpod.dart',
      'dart:async',
    ];
  }

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) return '';

    return _generateWidget(element.displayName);
  }

  String _generateWidget(String baseName) {
    final className = 'FormUpdate$baseName';

    final clazz = Class(
      (b) =>
          b
            ..name = className
            ..extend = refer('StatelessWidget', 'package:flutter/widgets.dart')
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'build'
                      ..returns = refer('Widget', 'package:flutter/widgets.dart')
                      ..requiredParameters.add(
                        Parameter(
                          (b) =>
                              b
                                ..name = 'context'
                                ..type = refer('BuildContext', 'package:flutter/widgets.dart'),
                        ),
                      )
                      ..annotations.add(refer('override'))
                      ..body = Code('return Container();'),
              ),
            ),
    );

    return clazz.accept(DartEmitter()).toString();
  }
}
