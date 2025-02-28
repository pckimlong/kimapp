import 'package:riverpod_widget/src/models/provider_definition.dart';

import '../state_widget_names.dart';

String generateParamWidgetWrapper(ProviderDefinition provider, {required String child}) {
  if (!provider.hasFamily) return child;

  return '''
  ${provider.paramWidgetName}(
    builder: (context, ref, params) => $child,
  )
  ''';
}
