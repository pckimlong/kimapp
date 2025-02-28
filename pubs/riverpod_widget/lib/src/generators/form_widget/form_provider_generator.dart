import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:recase/recase.dart';
import 'package:riverpod_widget/riverpod_widget.dart';
import 'package:riverpod_widget/src/templates/utils.dart';
import 'package:source_gen/source_gen.dart';

import '../../models/provider_definition.dart';

/// Generator that creates provider extensions and helper methods for form state management
/// This generator outputs to .g.dart files
class FormProviderGenerator extends GeneratorForAnnotation<FormWidget> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'FormWidget annotation can only be applied to classes.',
        element: element,
      );
    }

    final buffer = StringBuffer();
    final provider = ProviderDefinition.parse(element, parseReturnTypeClassInfo: true);

    buffer.writeln('final type = ${jsonEncode(provider.toMap())};');
    buffer.writeln(_providerAbstraction(provider));

    return returnContent(buffer, comment: false);
  }
}

String _providerAbstraction(ProviderDefinition provider) {
  final submitMethod = provider.methods.firstWhereOrNull((m) => m.name == 'submit');
  final resultType = submitMethod?.returnType ?? 'Future<void>';
  final rawResultType =
      resultType.contains('Future')
          ? resultType.replaceFirst('Future<', '').replaceFirst('>', '')
          : resultType;
  final futureResultType = resultType.contains('Future') ? resultType : 'Future<$resultType>';

  final namedParams = submitMethod?.codeBuilderParams().where((p) => p.named).toList() ?? [];
  final positionalParams = submitMethod?.codeBuilderParams().where((p) => !p.named).toList() ?? [];
  final callStateProviderDeclaration =
      'StateProvider.autoDispose${provider.hasFamily ? ".family" : ""}<AsyncValue<$rawResultType>?${provider.hasFamily ? ",${provider.familyAsRecordType}" : ""}>((ref${provider.hasFamily ? " ,_" : ""}) => null)';
  final readCallStateProvider =
      "callStateProvider${provider.hasFamily ? "(${provider.familyAsRecordBindString()})" : ""}";

  String updateStateStatement(String statement) {
    if (provider.isAsyncValue) {
      return 'state.whenData((state) => $statement)';
    }

    return statement;
  }

  final statusProvider = Field(
    (b) =>
        b
          ..name = 'callStateProvider'
          ..static = true
          ..modifier = FieldModifier.final$
          ..assignment = Code(callStateProviderDeclaration),
  );

  final List<Method> updateFieldMethods = [];

  if (provider.returnType.classInfo != null) {
    final returnClass = provider.returnType.classInfo!;
    final copyWithNames = returnClass.copyWithMethod?.parameters.map((e) => e.name) ?? [];

    for (final field in returnClass.fields) {
      updateFieldMethods.add(
        Method(
          (b) =>
              b
                ..name = 'update${field.name.pascalCase}'
                ..docs.add(
                  '/// Update the ${field.name} field of ${provider.returnType.baseType} class.',
                )
                ..returns = refer('void')
                ..requiredParameters.add(
                  Parameter(
                    (b) =>
                        b
                          ..name = 'newValue'
                          ..type = refer(field.type),
                  ),
                )
                ..lambda = copyWithNames.contains(field.name)
                ..body =
                    copyWithNames.contains(field.name)
                        ? Code(
                          'state = ${updateStateStatement('state.copyWith(${field.name}: newValue)')}',
                        )
                        : null,
        ),
      );
    }
  } else {
    // update full state
    updateFieldMethods.add(
      Method(
        (b) =>
            b
              ..name = 'updateState'
              ..returns = refer('void')
              ..requiredParameters.add(
                Parameter(
                  (b) =>
                      b
                        ..name = 'newState'
                        ..type = refer(provider.returnType.baseType),
                ),
              )
              ..lambda = true
              ..body = Code('state = ${updateStateStatement('newState')}'),
      ),
    );
  }

  return Class(
    (b) =>
        b
          ..name = '_\$${provider.baseName}Widget'
          ..abstract = true
          ..extend = refer('_\$${provider.baseName}')
          ..fields.addAll([statusProvider])
          ..methods.addAll([
            Method(
              (b) =>
                  b
                    ..name = 'onSuccess'
                    ..annotations.add(refer('protected'))
                    ..returns = refer('void')
                    ..docs.add(
                      '/// Callback for when the form is successfully submitted. Override this method to handle the result. eg perform side effects in other providers.',
                    )
                    ..requiredParameters.add(
                      Parameter(
                        (b) =>
                            b
                              ..name = 'result'
                              ..type = refer(rawResultType),
                      ),
                    )
                    ..body = Code(''),
            ),
            Method(
              (b) =>
                  b
                    ..name = 'call'
                    ..annotations.add(refer('protected'))
                    ..annotations.add(refer('nonVirtual'))
                    ..modifier = MethodModifier.async
                    ..returns = refer('Future<AsyncValue<$rawResultType>>')
                    ..requiredParameters.addAll(positionalParams)
                    ..optionalParameters.addAll(namedParams)
                    ..body = Code('''
    ${provider.isAsyncValue ? """
  // Ignore if form is not loaded yet
    if (state.isLoading) return const AsyncValue.loading();
""" : ""}

    final callState = ref.read($readCallStateProvider);
    final updateCallState = ref.read($readCallStateProvider.notifier);

    // If it's already loading, return loading
    if (callState?.isLoading == true) return const AsyncValue.loading();

    if (callState?.hasValue == true) {
      return callState!;
    }

    updateCallState.state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async => await submit(
      ${positionalParams.map((e) => e.name).join(', ')}
      ${namedParams.isNotEmpty ? "${positionalParams.isNotEmpty ? ',' : ''}${namedParams.map((e) => "${e.name}: ${e.name}").join(', ')}" : ""}
    ));

    updateCallState.state = result;

    if (result.hasValue) {
      onSuccess(result.requireValue);
    }

    return result;
'''),
            ),
            Method(
              (b) =>
                  b
                    ..name = 'invalidateSelf'
                    ..returns = refer('void')
                    ..body = Code('ref.invalidate(callStateProvider);\nref.invalidateSelf();'),
            ),
            Method(
              (b) =>
                  b
                    ..name = 'submit'
                    ..annotations.add(refer('visibleForOverriding'))
                    ..docs.add(
                      '/// Internal submit implementation - DO NOT CALL DIRECTLY\n'
                      '///\n'
                      '/// ⚠️ Warning: This method should not be called directly. Use [call] instead.\n'
                      '/// Direct usage of this method will bypass error handling and status management.\n'
                      '///\n'
                      '/// This method is intended to be overridden by implementing classes to provide\n'
                      '/// the actual submission logic.',
                    )
                    ..modifier = MethodModifier.async
                    ..returns = refer(futureResultType)
                    ..requiredParameters.addAll(positionalParams)
                    ..optionalParameters.addAll(namedParams),
            ),
            ...updateFieldMethods,
          ]),
  ).accept(DartEmitter()).toString();
}
