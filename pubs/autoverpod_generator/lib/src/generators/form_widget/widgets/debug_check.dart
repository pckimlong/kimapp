import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';

String generateDebugCheckFunction(ProviderDefinition provider) {
  final widgetName = provider.formWidgetName;
  return '''
  bool _debugCheckHas${provider.baseName}Form(BuildContext context) {
    assert(() {
      if (context.widget is! $widgetName &&
          context.findAncestorWidgetOfExactType<$widgetName>() == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No $widgetName found'),
          ErrorDescription(
            '\${context.widget.runtimeType} widgets require a $widgetName widget ancestor.',
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
  _debugCheckHas${provider.baseName}Form(context);
  ''';
}
