import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/base_proxy_widget_ref.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/debug_check.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/form_field_widget.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/form_widget.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/param_inherited_widget.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/param_widget.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/select_widget.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/state_widget.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/status_widget.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../../autoverpod_generator.dart';

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
    final provider = ProviderDefinition.parse(element, parseReturnTypeClassInfo: true);
    if (provider.providerType != ProviderType.classBased) {
      throw InvalidGenerationSourceError(
        'FormWidget annotation can only be applied to class-based providers.',
        element: element,
      );
    }

    final buffer = StringBuffer();

    buffer.writeln(generateParamInheritedWidget(provider));
    buffer.writeln(generateFormBaseProxyWidgetRef(provider));
    buffer.writeln(generateFormWidget(provider));
    buffer.writeln(generateDebugCheckFunction(provider));
    buffer.writeln(generateParamWidget(provider));
    buffer.writeln(generateSelectWidget(provider));
    buffer.writeln(generateStateWidget(provider));
    buffer.writeln(generateStatusWidget(provider));

    for (final field in provider.returnType.classInfo?.fields ?? []) {
      buffer.writeln(generateFormFieldWidget(provider, field));
    }

    return returnContent(buffer, comment: false);
  }
}
