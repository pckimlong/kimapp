import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/utils.dart';
import 'package:source_gen/source_gen.dart';

import '../../../riverpod_widget.dart';
import 'widgets/debug_check.dart';
import 'widgets/param_inherited_widget.dart';
import 'widgets/param_widget.dart';
import 'widgets/proxy_widget_ref.dart';
import 'widgets/scope_widget.dart';
import 'widgets/select_widget.dart';
import 'widgets/state_widget.dart';
import 'widgets/state_widget_proxy.dart';

/// Generator for creating state-based widgets from providers
class StateWidgetGenerator extends WidgetGenerator {
  @override
  final TypeChecker annotationTypeChecker = const TypeChecker.fromRuntime(StateWidget);

  @override
  bool canProcess(Element element) {
    return annotationTypeChecker.hasAnnotationOf(element);
  }

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final provider = ProviderDefinition.parse(element);
    final buffer = StringBuffer();

    buffer.writeln(generateParamInheritedWidget(provider));
    buffer.writeln(generateProxyWidgetRef(provider));
    buffer.writeln(generateScopeWidget(provider));
    buffer.writeln(generateDebugCheckFunction(provider));
    buffer.writeln(generateParamWidget(provider));
    buffer.writeln(generateStateWidgetProxy(provider));
    buffer.writeln(generateStateWidget(provider));
    buffer.writeln(generateSelectWidget(provider));

    return returnContent(buffer, comment: false);
  }

  @override
  List<String> getRequiredImports() {
    return [
      'package:flutter_riverpod/flutter_riverpod.dart',
      'package:kimapp_utils/kimapp_utils.dart',
      'package:flutter/material.dart',
    ];
  }
}
