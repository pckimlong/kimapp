import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/consumer_widget.dart';
import 'package:riverpod_widget/src/templates/utils.dart';

import '../state_widget_names.dart';
import 'debug_check.dart';

String generateParamWidget(ProviderDefinition provider) {
  if (!provider.hasFamily) return '';

  final builderType =
      "Widget Function(BuildContext context, ${provider.proxyWidgetName} ref, ${provider.familyAsRecordType} params)";

  return generateConsumerWidget(
    name: provider.paramWidgetName,
    fields: [ClassField(name: 'builder', type: builderType, isRequired: true)],
    build: '''
${generateDebugCheckCall(provider)}
final params = ${provider.paramInheritedWidgetName}.of(context).params;
return builder(context, ${provider.proxyWidgetName}(ref), params);
  ''',
  );
}
