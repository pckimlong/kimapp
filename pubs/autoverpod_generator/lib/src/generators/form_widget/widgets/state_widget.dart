import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';

import '../../state_widget/widgets/param_widget_wrapper.dart';
import 'debug_check.dart';

String generateStateWidget(ProviderDefinition provider) {
  final builderType =
      'Widget Function(BuildContext context, ${provider.formBaseProxyWidgetName} ref, Widget? child,)';
  return generateConsumerWidget(
    name: provider.formStateWidgetName,
    fields: [
      ClassField(
        name: 'builder',
        type: builderType,
        comment: [
          'The builder function that constructs the widget tree.',
          'Use ref.select for field-level updates to minimise rebuilds.',
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
      onStateChanged!(${provider.isAsyncValue ? 'pre?.value' : 'pre'}, ${provider.isAsyncValue ? 'next.value' : 'next'});
  });
}
return ${generateParamWidgetWrapper(provider, child: 'builder(context, ${provider.formBaseProxyWidgetName}(ref), child)')};
    ''',
  );
}
