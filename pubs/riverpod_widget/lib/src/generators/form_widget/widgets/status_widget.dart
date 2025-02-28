import 'package:riverpod_widget/src/generators/form_widget/form_widget_names.dart';
import 'package:riverpod_widget/src/generators/form_widget/widgets/debug_check.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/consumer_widget.dart';
import 'package:riverpod_widget/src/templates/utils.dart';

String generateStatusWidget(ProviderDefinition provider) {
  // TODO: Consider passing form key to this ref
  return generateConsumerWidget(
    name: provider.formStatusWidgetName,
    fields: [
      ClassField(
        name: 'builder',
        type:
            'Widget Function(BuildContext context, ${provider.formBaseProxyWidgetName} ref, ${provider.getSubmitMethodInfo().asyncValueType} status)',
      ),
    ],
    build: '''
${generateDebugCheckCall(provider)}
final stateRef = ${provider.formBaseProxyWidgetName}(ref);
return builder(context, stateRef, stateRef.status);
''',
  );
}
