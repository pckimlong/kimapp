import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/base_proxy_widget_ref.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/debug_check.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/field_updater.dart';
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
      'package:flutter_hooks/flutter_hooks.dart',
      'package:hooks_riverpod/hooks_riverpod.dart',
    ];
  }

  /// Get imports for all field types in the return type class
  List<String> _getFieldTypeImports(ProviderDefinition provider) {
    final imports = <String>{};
    final classInfo = provider.returnType.classInfo;

    if (classInfo != null) {
      for (final field in classInfo.fields) {
        if (field.importPath != null) {
          imports.add(field.importPath!);
        }
      }
    }

    return imports.toList();
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

    // Get field type imports
    final fieldImports = _getFieldTypeImports(provider);

    // Add field type imports to registry
    for (final import in fieldImports) {
      GeneratorRegistry.instance.addImport(import);
    }

    final buffer = StringBuffer();

    buffer.writeln(generateFieldUpdaterExtension(provider));
    buffer.writeln(generateParamInheritedWidget(provider));
    buffer.writeln(generateFormBaseProxyWidgetRef(provider));
    buffer.writeln(generateFormScopeWidget(provider));
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
