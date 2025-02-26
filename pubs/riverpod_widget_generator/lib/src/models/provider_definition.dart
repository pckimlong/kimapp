// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:analyzer/dart/element/element.dart';
import 'package:riverpod_widget_generator/src/models/provider_return_type_definition.dart';
import 'package:source_gen/source_gen.dart';

import 'method_definition.dart';
import 'param_definition.dart';

enum ProviderType { classBased, functionBased }

enum ProviderModifier { autoDispose, family, keepAlive }

class ProviderDefinition {
  final String baseName;
  final String providerName;
  final ProviderType providerType;
  final ProviderReturnTypeDefinition returnType;
  final List<ParamDefinition> familyParameters;
  final List<MethodDefinition> methods;
  final Set<ProviderModifier> modifiers;
  final String? documentation;
  final List<String> dependencies;
  final Map<String, List<String>> genericParameters;

  ProviderDefinition({
    required this.baseName,
    required this.providerName,
    required this.providerType,
    required this.returnType,
    this.familyParameters = const [],
    this.methods = const [],
    this.modifiers = const {},
    this.documentation,
    this.dependencies = const [],
    this.genericParameters = const {},
  });

  factory ProviderDefinition.parse(Element element) {
    try {
      final isClass = element is ClassElement;
      final baseName = element.name!;
      final providerName = '${baseName}Provider';
      final modifiers = _parseModifiers(element);
      final dependencies = _parseDependencies(element);
      final genericParams = _parseGenericParameters(element);
      final documentation = element.documentationComment;

      if (isClass) {
        final classElement = element;
        final buildMethod = classElement.methods.firstWhere(
          (m) => m.name == 'build',
          orElse:
              () =>
                  throw InvalidGenerationSourceError(
                    'Provider class must have a build method',
                    element: element,
                  ),
        );

        return ProviderDefinition(
          baseName: baseName,
          providerName: providerName,
          providerType: ProviderType.classBased,
          returnType: ProviderReturnTypeDefinition.parse(buildMethod.returnType),
          familyParameters: buildMethod.parameters.map((p) => ParamDefinition.parse(p)).toList(),
          methods: classElement.methods.map((m) => MethodDefinition.parseMethod(m)).toList(),
          modifiers: modifiers,
          documentation: documentation,
          dependencies: dependencies,
          genericParameters: genericParams,
        );
      } else {
        // Function-based provider
        final functionElement = element as FunctionElement;

        return ProviderDefinition(
          baseName: baseName,
          providerName: providerName,
          providerType: ProviderType.functionBased,
          returnType: ProviderReturnTypeDefinition.parse(functionElement.returnType),
          familyParameters:
              functionElement.parameters
                  .skip(1) // Skip first param (Ref)
                  .map((p) => ParamDefinition.parse(p))
                  .toList(),
          modifiers: modifiers,
          documentation: documentation,
          dependencies: dependencies,
          genericParameters: genericParams,
        );
      }
    } catch (e, stack) {
      throw InvalidGenerationSourceError(
        'Error parsing provider definition: $e\n$stack',
        element: element,
      );
    }
  }

  static Set<ProviderModifier> _parseModifiers(Element element) {
    final modifiers = <ProviderModifier>{};
    for (final metadata in element.metadata) {
      final annotation = metadata.computeConstantValue();
      if (annotation != null) {
        final type = annotation.type?.toString();
        if (type?.contains('autoDispose') == true) {
          modifiers.add(ProviderModifier.autoDispose);
        } else if (type?.contains('family') == true) {
          modifiers.add(ProviderModifier.family);
        } else if (type?.contains('keepAlive') == true) {
          modifiers.add(ProviderModifier.keepAlive);
        }
      }
    }
    return modifiers;
  }

  static List<String> _parseDependencies(Element element) {
    final dependencies = <String>[];
    if (element is ClassElement) {
      for (final field in element.fields) {
        if (field.type.toString().contains('Provider')) {
          dependencies.add(field.type.toString());
        }
      }
    }
    return dependencies;
  }

  static Map<String, List<String>> _parseGenericParameters(Element element) {
    final genericParams = <String, List<String>>{};
    if (element is ClassElement) {
      for (final typeParam in element.typeParameters) {
        final bound = typeParam.bound;
        final bounds = bound != null ? [bound.toString()] : <String>[];
        genericParams[typeParam.name] = bounds;
      }
    }
    return genericParams;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseName': baseName,
      'returnType': returnType.toMap(),
      'providerName': providerName,
      'providerType': providerType.toString(),
      'familyParameters': familyParameters.map((x) => x.toMap()).toList(),
      'methods': methods.map((x) => x.toMap()).toList(),
      'modifiers': modifiers.map((x) => x.toString).toList(),
      'documentation': documentation,
      'dependencies': dependencies,
      'genericParameters': genericParameters,
    };
  }
}
