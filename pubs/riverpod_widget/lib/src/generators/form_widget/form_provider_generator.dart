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

/// Generator that creates provider extensions and helper methods for form state management.
/// This generator outputs to .g.dart files and handles:
/// - Form state management
/// - Submit functionality
/// - Success/error handling
/// - Field updates
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

    final provider = ProviderDefinition.parse(element, parseReturnTypeClassInfo: true);

    final buffer = StringBuffer();

    // Generate the form provider abstraction
    buffer.writeln(_generateFormProviderAbstraction(provider));

    return returnContent(buffer, comment: false);
  }
}

/// Generates the form provider abstraction code including:
/// - State management
/// - Submit functionality
/// - Field update methods
/// - Success/error handling
String _generateFormProviderAbstraction(ProviderDefinition provider) {
  final submitMethodInfo = _extractSubmitMethodInfo(provider);
  final stateProviderInfo = _generateStateProviderInfo(provider, submitMethodInfo);
  final updateMethods = _generateUpdateMethods(provider);

  return Class(
    (b) =>
        b
          ..name = '_\$${provider.baseName}Widget'
          ..abstract = true
          ..extend = refer('_\$${provider.baseName}')
          ..fields.add(stateProviderInfo.statusProvider)
          ..methods.addAll([
            _generateOnSuccessMethod(submitMethodInfo.rawResultType),
            _generateCallMethod(provider, submitMethodInfo, stateProviderInfo),
            _generateInvalidateSelfMethod(),
            _generateSubmitMethod(provider, submitMethodInfo),
            ...updateMethods,
          ]),
  ).accept(DartEmitter()).toString();
}

/// Contains information about the submit method
class SubmitMethodInfo {
  final String resultType;
  final String rawResultType;
  final String futureResultType;
  final List<Parameter> namedParams;
  final List<Parameter> positionalParams;

  SubmitMethodInfo({
    required this.resultType,
    required this.rawResultType,
    required this.futureResultType,
    required this.namedParams,
    required this.positionalParams,
  });
}

/// Contains information about the state provider
class StateProviderInfo {
  final String declaration;
  final String readProvider;
  final Field statusProvider;

  StateProviderInfo({
    required this.declaration,
    required this.readProvider,
    required this.statusProvider,
  });
}

/// Extracts information about the submit method
SubmitMethodInfo _extractSubmitMethodInfo(ProviderDefinition provider) {
  final submitMethod = provider.methods.firstWhereOrNull((m) => m.name == 'submit');
  final resultType = submitMethod?.returnType ?? 'Future<void>';

  final rawResultType =
      resultType.contains('Future')
          ? resultType.replaceFirst('Future<', '').replaceFirst('>', '')
          : resultType;

  final futureResultType = resultType.contains('Future') ? resultType : 'Future<$resultType>';

  return SubmitMethodInfo(
    resultType: resultType,
    rawResultType: rawResultType,
    futureResultType: futureResultType,
    namedParams: submitMethod?.codeBuilderParams().where((p) => p.named).toList() ?? [],
    positionalParams: submitMethod?.codeBuilderParams().where((p) => !p.named).toList() ?? [],
  );
}

/// Generates state provider information
StateProviderInfo _generateStateProviderInfo(
  ProviderDefinition provider,
  SubmitMethodInfo submitInfo,
) {
  final declaration =
      'StateProvider.autoDispose'
      '${provider.hasFamily ? ".family" : ""}'
      '<AsyncValue<${submitInfo.rawResultType}>?'
      '${provider.hasFamily ? ",${provider.familyAsRecordType}" : ""}>'
      '((ref${provider.hasFamily ? " ,_" : ""}) => null)';

  final readProvider =
      "callStateProvider"
      "${provider.hasFamily ? "(${provider.familyAsRecordBindString()})" : ""}";

  final statusProvider = Field(
    (b) =>
        b
          ..name = 'callStateProvider'
          ..static = true
          ..modifier = FieldModifier.final$
          ..assignment = Code(declaration),
  );

  return StateProviderInfo(
    declaration: declaration,
    readProvider: readProvider,
    statusProvider: statusProvider,
  );
}

/// Generates field update methods
List<Method> _generateUpdateMethods(ProviderDefinition provider) {
  final List<Method> updateMethods = [];

  if (provider.returnType.classInfo != null) {
    final returnClass = provider.returnType.classInfo!;
    final copyWithNames = returnClass.copyWithMethod?.parameters.map((e) => e.name).toSet() ?? {};

    for (final field in returnClass.fields) {
      if (copyWithNames.contains(field.name)) {
        updateMethods.add(
          _generateFieldUpdateMethod(
            provider,
            field.name,
            field.type,
            provider.returnType.baseType,
          ),
        );
      } else {
        // Add but not implemented
        updateMethods.add(
          Method(
            (b) =>
                b
                  ..name = 'update${field.name.pascalCase}'
                  ..returns = refer('void')
                  ..requiredParameters.add(
                    Parameter(
                      (b) =>
                          b
                            ..name = 'newValue'
                            ..type = refer(field.type),
                    ),
                  )
                  ..docs.add(
                    '/// Update the $field.name field of $returnClass.name class. Please override this method and manually update the field. since it is not available through copyWith method.',
                  ),
          ),
        );
      }
    }
  } else {
    updateMethods.add(_generateStateUpdateMethod(provider));
  }

  return updateMethods;
}

/// Generates a method for updating a specific field
Method _generateFieldUpdateMethod(
  ProviderDefinition provider,
  String fieldName,
  String fieldType,
  String baseType,
) {
  final updateStatement =
      provider.isAsyncValue
          ? 'state.whenData((state) => state.copyWith($fieldName: newValue))'
          : 'state.copyWith($fieldName: newValue)';

  return Method(
    (b) =>
        b
          ..name = 'update${fieldName.pascalCase}'
          ..docs.add('/// Update the $fieldName field of $baseType class.')
          ..returns = refer('void')
          ..requiredParameters.add(
            Parameter(
              (b) =>
                  b
                    ..name = 'newValue'
                    ..type = refer(fieldType),
            ),
          )
          ..lambda = true
          ..body = Code('state = $updateStatement'),
  );
}

/// Generates a method for updating the entire state
Method _generateStateUpdateMethod(ProviderDefinition provider) {
  final updateStatement = provider.isAsyncValue ? 'state.whenData((_) => newState)' : 'newState';

  return Method(
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
          ..body = Code('state = $updateStatement'),
  );
}

/// Generates the onSuccess callback method
Method _generateOnSuccessMethod(String rawResultType) {
  return Method(
    (b) =>
        b
          ..name = 'onSuccess'
          ..annotations.add(refer('protected'))
          ..returns = refer('void')
          ..docs.add(
            '/// Callback for when the form is successfully submitted.\n'
            '/// Override this method to handle the result or perform side effects.',
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
  );
}

/// Generates the call method that handles form submission
Method _generateCallMethod(
  ProviderDefinition provider,
  SubmitMethodInfo submitInfo,
  StateProviderInfo stateInfo,
) {
  final loadingCheck =
      provider.isAsyncValue
          ? '''
  // Ignore if form is not loaded yet
  if (this.state.isLoading) return const AsyncValue.loading();
  // Cannot submit when form is not loaded yet
  if (this.state.hasValue == false) return const AsyncValue.loading();
'''
          : '';

  return Method(
    (b) =>
        b
          ..name = 'call'
          ..annotations.addAll([refer('protected'), refer('nonVirtual')])
          ..modifier = MethodModifier.async
          ..returns = refer('Future<AsyncValue<${submitInfo.rawResultType}>>')
          ..requiredParameters.addAll(submitInfo.positionalParams)
          ..optionalParameters.addAll(submitInfo.namedParams)
          ..body = Code('''
$loadingCheck

final callState = ref.read(${stateInfo.readProvider});
final updateCallState = ref.read(${stateInfo.readProvider}.notifier);

    // If it's already loading, return loading
if (callState?.isLoading == true) return const AsyncValue.loading();

if (callState?.hasValue == true) {
  return callState!;
}

updateCallState.state = const AsyncValue.loading();
final result = await AsyncValue.guard(() async => await submit(
  ${submitInfo.positionalParams.map((e) {
            if (e.name == 'state') {
              if (provider.isAsyncValue) {
                return 'this.state.requireValue';
              } else {
                return 'this.state';
              }
            }
            return e.name;
          }).join(', ')}
  ${submitInfo.namedParams.isNotEmpty ? "${submitInfo.positionalParams.isNotEmpty ? ',' : ''}${submitInfo.namedParams.map((e) => "${e.name}: ${e.name}").join(', ')}" : ""}
));

updateCallState.state = result;

if (result.hasValue) {
  onSuccess(result.requireValue);
}

return result;
'''),
  );
}

/// Generates the invalidateSelf method
Method _generateInvalidateSelfMethod() {
  return Method(
    (b) =>
        b
          ..name = 'invalidateSelf'
          ..returns = refer('void')
          ..body = Code('ref.invalidate(callStateProvider);\nref.invalidateSelf();'),
  );
}

/// Generates the submit method signature
Method _generateSubmitMethod(ProviderDefinition provider, SubmitMethodInfo submitInfo) {
  return Method(
    (b) =>
        b
          ..name = 'submit'
          ..annotations.add(refer('visibleForOverriding'))
          ..docs.addAll([
            '/// Internal submit implementation for form submission.',
            '/// ',
            '/// ⚠️ WARNING: Do not call this method directly - use [call] instead.',
            '/// Direct usage bypasses:',
            '/// - Error handling',
            '/// - Loading state management ',
            '/// - Success callback handling',
            '/// - Form validation',
            '/// ',
            '/// This method should be overridden to implement the actual form submission logic:',
            '/// 1. Validate form data',
            '/// 2. Transform data if needed',
            '/// 3. Call API/repository methods',
            '/// 4. Return success/failure result',
          ])
          ..modifier = MethodModifier.async
          ..returns = refer(submitInfo.futureResultType)
          ..requiredParameters.addAll([
            if (!submitInfo.positionalParams.any((e) => e.name == 'state'))
              Parameter(
                (b) =>
                    b
                      ..name = 'state'
                      ..type = refer(provider.returnType.baseType),
              ),
          ])
          ..requiredParameters.addAll(submitInfo.positionalParams)
          ..optionalParameters.addAll(submitInfo.namedParams),
  );
}
