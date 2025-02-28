import 'package:autoverpod_generator/src/models/provider_definition.dart';

import '../state_widget_names.dart';

String generateDebugCheckFunction(ProviderDefinition provider) {
  final className = provider.providerScopeName;

  return '''
  bool _debugCheckHas$className(BuildContext context) {
    assert(() {
      if (context.widget is! $className &&
          context.findAncestorWidgetOfExactType<$className>() == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No $className found'),
          ErrorDescription(
            '\${context.widget.runtimeType} widgets require a $className widget ancestor.',
          ),
        ]);
      }
      return true;
    }());
    return true;
  }
  ''';
}

String generateDebugCheckCall(ProviderDefinition provider) {
  return '''
  _debugCheckHas${provider.providerScopeName}(context);
  ''';
}
