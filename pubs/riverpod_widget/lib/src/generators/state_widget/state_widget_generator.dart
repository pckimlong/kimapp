import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/comment_generator.dart';
import 'package:source_gen/source_gen.dart';

import '../../../riverpod_widget.dart';
import '../../templates/proxy_widget_ref.dart';

class RiverpodStateWidgetGenerator extends GeneratorForAnnotation<StateWidget> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final providerDefinition = ProviderDefinition.parse(element);
    final buffer = StringBuffer();
    buffer.writeln('final providerDefinition = ${jsonEncode(providerDefinition.toMap())};');

    buffer.write(_generateBaseProxyWidget(providerDefinition));
    buffer.write('/*');

    buffer.write('*/');

    return buffer.toString();
  }

  String _generateBaseProxyWidget(ProviderDefinition definition) {
    return baseProxyWidgetRef(
      definition.baseName,
      classComment: CommentGenerator(
        lines: [
          'Proxy WidgetRef for ${definition.providerName}. This allow to add more methods to the WidgetRef',
        ],
        macro: '@${definition.baseName}.baseProxyWidgetRef',
      ),
    );
  }

  String _generateScopeWidget(ProviderDefinition definition) {
    return '';
  }
}
