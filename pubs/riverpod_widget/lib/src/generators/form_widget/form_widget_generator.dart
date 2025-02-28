import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/utils.dart';
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
    final provider = ProviderDefinition.parse(element);
    if (provider.providerType != ProviderType.classBased) {
      throw InvalidGenerationSourceError(
        'FormWidget annotation can only be applied to class-based providers.',
        element: element,
      );
    }

    final buffer = StringBuffer();

    buffer.writeln('// Test if this work');

    return returnContent(buffer, comment: false);
  }
}
