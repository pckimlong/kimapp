import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../../riverpod_widget.dart';

class FormWidgetGenerator extends WidgetGenerator {
  @override
  final TypeChecker annotationTypeChecker = const TypeChecker.fromRuntime(FormWidget);

  @override
  List<String> getRequiredImports() {
    return [
      'package:flutter/widgets.dart',
      'package:flutter/material.dart',
      'package:flutter_riverpod/flutter_riverpod.dart',
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
    return '// TODO: Implement $baseName';
  }
}
