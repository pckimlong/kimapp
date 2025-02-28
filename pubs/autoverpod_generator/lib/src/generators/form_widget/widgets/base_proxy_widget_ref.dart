import 'package:code_builder/code_builder.dart';
import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/proxy_widget_ref.dart';

String generateFormBaseProxyWidgetRef(ProviderDefinition provider) {
  return generateBaseProxyWidgetRef(
    provider.formBaseProxyWidgetName,
    methods: [
      if (provider.hasFamily)
        Method(
          (b) =>
              b
                ..returns = refer(provider.familyAsRecordType)
                ..name = 'params'
                ..type = MethodType.getter
                ..lambda = true
                ..body = Code('${provider.formInheritedWidgetName}.of(context).params'),
        ),
      Method(
        (b) =>
            b
              ..name = 'status'
              ..type = MethodType.getter
              ..returns = refer(provider.getSubmitMethodInfo().asyncValueType)
              ..lambda = true
              ..body = Code('''
                  _ref.watch(${provider.callStatusProviderNameWithFamily(prefix: 'params')})
                '''),
      ),
      Method(
        (b) =>
            b
              ..name = 'formKey'
              ..type = MethodType.getter
              ..returns = refer('GlobalKey<FormState>')
              ..lambda = true
              ..body = Code('${provider.formInheritedWidgetName}.of(context).formKey'),
      ),
      Method(
        (b) =>
            b
              ..name = 'notifier'
              ..type = MethodType.getter
              ..returns = refer(provider.baseName)
              ..lambda = true
              ..body = Code('''
                  _ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier)
                '''),
      ),
      Method((b) {
        final submitInfo = provider.getSubmitMethodInfo();

        // Generate parameter call strings
        final positionalParamsString = submitInfo.positionalParams
            .where((e) => e.name != 'state')
            .map((param) => param.name)
            .join(', ');

        final namedParamsString = submitInfo.namedParams
            .map((param) => '${param.name}: ${param.name}')
            .join(', ');

        // Combine parameters for the call
        String callParams = '';
        if (positionalParamsString.isNotEmpty && namedParamsString.isNotEmpty) {
          callParams = '$positionalParamsString, $namedParamsString';
        } else if (positionalParamsString.isNotEmpty) {
          callParams = positionalParamsString;
        } else if (namedParamsString.isNotEmpty) {
          callParams = namedParamsString;
        }

        b
          ..name = 'submit'
          ..returns = refer(provider.callFunctionReturnType)
          ..docs.add(
            '/// Submits the form. Internally this calls [notifier.submit] with the form key validated.',
          )
          ..modifier = MethodModifier.async
          ..requiredParameters.addAll(
            submitInfo.positionalParams.where((e) => e.name != 'state').toList(),
          )
          ..optionalParameters.addAll(submitInfo.namedParams)
          ..body = Code('''
    if (!(formKey.currentState?.validate() ?? false)) {
      return AsyncValue.error(Exception('Form is not valid'), StackTrace.current);
    }
    formKey.currentState?.save();

    return await notifier($callParams);
''');
      }),
      Method(
        (b) =>
            b
              ..name = 'state'
              ..type = MethodType.getter
              ..lambda = true
              ..returns = refer(provider.returnType.baseType)
              ..body = Code(
                '_ref.watch(${provider.providerNameWithFamily(prefix: 'params')})${provider.isAsyncValue ? '.requireValue' : ''}',
              ),
      ),
      Method(
        (b) =>
            b
              ..name = 'select'
              ..returns = refer('Selected')
              ..types.add(refer('Selected'))
              ..requiredParameters.add(
                Parameter(
                  (b) =>
                      b
                        ..name = 'selector'
                        ..type = refer('Selected Function(${provider.returnType.baseType})'),
                ),
              )
              ..lambda = true
              ..body = Code(
                '_ref.watch(${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector(value${provider.isAsyncValue ? '.requireValue' : ''})))',
              ),
      ),
    ],
  );
}
