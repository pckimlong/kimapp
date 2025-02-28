import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/consumer_widget.dart';
import 'package:riverpod_widget/src/templates/utils.dart';

import '../state_widget_names.dart';
import 'debug_check.dart';
import 'param_widget_wrapper.dart';

String generateStateWidget(ProviderDefinition provider) {
  final builderType =
      'Widget Function(BuildContext context, ${provider.proxyWidgetName} ref, Widget? child,)';
  return generateConsumerWidget(
    name: provider.stateWidgetName,
    fields: [
      ClassField(
        name: 'builder',
        type: builderType,
        comment: [
          'The builder function that constructs the widget tree.',
          'Access the state directly via ref.state, which is equivalent to ref.watch(${provider.providerNameWithFamily(prefix: 'params')})',
          '',
          'For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)',
          'The ref parameter provides type-safe access to the provider state and notifier',
        ],
      ),
      ClassField(name: 'child', type: 'Widget?', isRequired: false),
      ClassField.providerListenable(
        'onStateChanged',
        provider.returnType.baseTypeNonNullable,
        bothNullable: true,
      ),
    ],
    build: '''
${generateDebugCheckCall(provider)}
if (onStateChanged != null) {
  ${provider.paramsDeclaration}
  ref.listen(${provider.providerNameWithFamily(prefix: 'params')}, (pre, next) {
    if (pre != next)
      onStateChanged!(${provider.isAsyncValue ? 'pre?.valueOrNull' : 'pre'}, ${provider.isAsyncValue ? 'next.valueOrNull' : 'next'});
  });
}
return ${generateParamWidgetWrapper(provider, child: 'builder(context, ${provider.subProxyWidgetName}(ref), child)')};
    ''',
  );
}
