import 'package:analyzer/dart/element/element.dart';
import 'package:autoverpod/autoverpod.dart';
import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';
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
  final submitMethodInfo = provider.getSubmitMethodInfo();
  final stateProviderInfo = _generateStateProviderInfo(provider, submitMethodInfo);
  final updateMethods = _generateUpdateMethods(provider);

  final proxyClass = Class(
    (b) => b
      ..name = '_\$${provider.baseName}Widget'
      ..abstract = true
      ..extend = refer('_\$${provider.baseName}')
      ..fields.add(stateProviderInfo.statusProvider)
      ..methods.addAll([
        _generateOnSuccessMethod(submitMethodInfo.rawResultType),
        _generateCallMethod(provider, submitMethodInfo, stateProviderInfo),
        _generateInvalidateSelfMethod(provider),
        _generateSubmitMethod(provider, submitMethodInfo),
        ...updateMethods,
      ]),
  ).accept(DartEmitter()).toString();

  final callStatusDeclaration = 'StateProvider.autoDispose'
      '${provider.hasFamily ? ".family" : ""}'
      '<AsyncValue<${submitMethodInfo.rawResultType}>?'
      '${provider.hasFamily ? ",${provider.familyAsRecordType}" : ""}>'
      '((ref${provider.hasFamily ? " ,_" : ""}) => null)';

  return '''
final ${provider.callStatusProviderName} = $callStatusDeclaration;

$proxyClass
''';
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

/// Generates state provider information
StateProviderInfo _generateStateProviderInfo(
  ProviderDefinition provider,
  SubmitMethodInfo submitInfo,
) {
  final declaration = 'StateProvider.autoDispose'
      '${provider.hasFamily ? ".family" : ""}'
      '<AsyncValue<${submitInfo.rawResultType}>?'
      '${provider.hasFamily ? ",${provider.familyAsRecordType}" : ""}>'
      '((ref${provider.hasFamily ? " ,_" : ""}) => null)';

  final readProvider = "${provider.callStatusProviderName}"
      "${provider.hasFamily ? "(${provider.familyAsRecordBindString()})" : ""}";

  final statusProvider = Field(
    (b) => b
      ..name = provider.callStatusProviderName
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

  ///
  updateMethods.add(_generateStateUpdateMethod(provider));

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
            (b) => b
              ..name = 'update${field.name.pascalCase}'
              ..returns = refer('void')
              ..requiredParameters.add(
                Parameter(
                  (b) => b
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
  final updateStatement = provider.isAsyncValue
      ? 'state.whenData((state) => state.copyWith($fieldName: newValue))'
      : 'state.copyWith($fieldName: newValue)';

  return Method(
    (b) => b
      ..name = 'update${fieldName.pascalCase}'
      ..docs.add('/// Update the $fieldName field of $baseType class.')
      ..returns = refer('void')
      ..requiredParameters.add(
        Parameter(
          (b) => b
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
  final updateStatement = provider.isAsyncValue ? 'state.whenData(update)' : 'update(state)';

  return Method(
    (b) => b
      ..name = 'updateState'
      ..returns = refer('void')
      ..docs.add(
        '/// Update the state of the form.\n'
        '/// This allow for more flexible to update specific fields.',
      )
      ..requiredParameters.add(
        Parameter(
          (b) => b
            ..name = 'update'
            ..type = refer(
              '${provider.returnType.baseType} Function(${provider.returnType.baseType} state)',
            ),
        ),
      )
      ..lambda = true
      ..body = Code('state = $updateStatement'),
  );
}

/// Generates the onSuccess callback method
Method _generateOnSuccessMethod(String rawResultType) {
  return Method(
    (b) => b
      ..name = 'onSuccess'
      ..annotations.add(refer('protected'))
      ..returns = refer('void')
      ..docs.add(
        '/// Callback for when the form is successfully submitted.\n'
        '/// Override this method to handle the result or perform side effects.',
      )
      ..requiredParameters.add(
        Parameter(
          (b) => b
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
  final loadingCheck = provider.isAsyncValue
      ? '''
  // Ignore if form is not loaded yet
  if (this.state.isLoading) return const AsyncValue.loading();
  // Cannot submit when form is not loaded yet
  if (this.state.hasValue == false) return const AsyncValue.loading();
'''
      : '';

  return Method(
    (b) => b
      ..name = 'call'
      ..annotations.addAll([refer('protected'), refer('nonVirtual')])
      ..modifier = MethodModifier.async
      ..returns = refer(provider.callFunctionReturnType)
      ..requiredParameters.addAll(
        submitInfo.positionalParams.where((e) => e.name != 'state').toList(),
      )
      ..optionalParameters.addAll(submitInfo.namedParams)
      ..body = Code('''
$loadingCheck

final _callStatus = ref.read(${stateInfo.readProvider});
final _updateCallStatus = ref.read(${stateInfo.readProvider}.notifier);

    // If it's already loading, return loading
if (_callStatus?.isLoading == true) return const AsyncValue.loading();

if (_callStatus?.hasValue == true) {
  return _callStatus!;
}

_updateCallStatus.state = const AsyncValue.loading();
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

_updateCallStatus.state = result;

if (result.hasValue) {
  onSuccess(result.requireValue);
}

return result;
'''),
  );
}

/// Generates the invalidateSelf method
Method _generateInvalidateSelfMethod(ProviderDefinition provider) {
  return Method(
    (b) => b
      ..name = 'invalidateSelf'
      ..returns = refer('void')
      ..body = Code(
        'ref.invalidate(${provider.callStatusProviderName});\nref.invalidateSelf();',
      ),
  );
}

/// Generates the submit method signature
Method _generateSubmitMethod(ProviderDefinition provider, SubmitMethodInfo submitInfo) {
  return Method(
    (b) => b
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
            (b) => b
              ..name = 'state'
              ..type = refer(provider.returnType.baseType),
          ),
      ])
      ..requiredParameters.addAll(submitInfo.positionalParams)
      ..optionalParameters.addAll(submitInfo.namedParams),
  );
}
