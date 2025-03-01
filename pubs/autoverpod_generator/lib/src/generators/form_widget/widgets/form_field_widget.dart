import 'package:autoverpod_generator/src/generators/form_widget/form_widget_names.dart';
import 'package:autoverpod_generator/src/generators/form_widget/widgets/debug_check.dart';
import 'package:autoverpod_generator/src/models/field_definition.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/consumer_widget.dart';
import 'package:autoverpod_generator/src/templates/sub_proxy_widget.dart';
import 'package:autoverpod_generator/src/templates/utils.dart';
import 'package:code_builder/code_builder.dart';
import 'package:recase/recase.dart';

/// Generates a form field widget for a specific provider field
///
/// Creates both the proxy reference and the actual widget implementation
String generateFormFieldWidget(ProviderDefinition provider, FieldDefinition field) {
  final isTextField = field.type == 'String' || field.type == 'String?';
  final proxyRefName = '_${provider.baseName}${field.name.pascalCase}ProxyWidgetRef';

  final proxyWidget = _generateFormFieldProxy(
    provider: provider,
    field: field,
    proxyRefName: proxyRefName,
    isTextField: isTextField,
  );

  final formFieldWidget = isTextField
      ? _generateTextFieldWidget(provider: provider, field: field, proxyRefName: proxyRefName)
      : _generateStandardFieldWidget(
          provider: provider,
          field: field,
          proxyRefName: proxyRefName,
        );

  return "$proxyWidget\n\n$formFieldWidget";
}

/// Creates the proxy widget reference that provides field-specific utilities
String _generateFormFieldProxy({
  required ProviderDefinition provider,
  required FieldDefinition field,
  required String proxyRefName,
  required bool isTextField,
}) {
  return generateSubProxyWidget(
    proxyRefName,
    parentName: provider.formBaseProxyWidgetName,
    finalFields: [
      if (isTextField)
        Field(
          (b) => b
            ..name = 'textController'
            ..type = refer('TextEditingController')
            ..modifier = FieldModifier.final$
            ..docs.add(
              '/// Text controller for the field. This is automatically created by the form widget and handles cleanup automatically.',
            ),
        ),
    ],
    methods: [
      Method(
        (b) => b
          ..name = field.name
          ..type = MethodType.getter
          ..returns = refer(field.type)
          ..lambda = true
          ..body = Code('select((state) => state.${field.name})'),
      ),
      Method(
        (b) => b
          ..name = 'update${field.name.pascalCase}'
          ..requiredParameters.add(
            Parameter(
              (b) => b
                ..name = 'newValue'
                ..type = refer(field.type),
            ),
          )
          ..returns = refer('void')
          ..lambda = true
          ..body = Code('notifier.update${field.name.pascalCase}(newValue)'),
      ),
    ],
  );
}

/// Generates the proxy instantiation code with proper parameters
String _createProxyInstance({required String proxyRefName, required bool isTextField}) {
  return '$proxyRefName(ref${isTextField ? ', textController: _textController' : ''})';
}

/// Generates a standard (non-text) form field widget
String _generateStandardFieldWidget({
  required ProviderDefinition provider,
  required FieldDefinition field,
  required String proxyRefName,
}) {
  return generateConsumerWidget(
    name: provider.fieldWidgetName(field),
    fields: [
      ClassField(name: 'builder', type: 'Widget Function(BuildContext context, $proxyRefName ref)'),
    ],
    build: '''
${generateDebugCheckCall(provider)}
  final proxy = ${_createProxyInstance(proxyRefName: proxyRefName, isTextField: false)};
  return builder(context, proxy);
  ''',
  );
}

/// Generates a specialized form field widget for text input fields (String types)
String _generateTextFieldWidget({
  required ProviderDefinition provider,
  required FieldDefinition field,
  required String proxyRefName,
}) {
  String paramDeclaration() {
    if (!provider.hasFamily) return '';
    return 'final params = ${provider.formInheritedWidgetName}.of(context).params;';
  }

  return '''
class ${provider.fieldWidgetName(field)} extends ConsumerStatefulWidget {
  const ${provider.fieldWidgetName(field)}({
    super.key,
    this.textController,
    required this.builder,
  });

  /// Text controller for the field. If not provided, one will be created automatically.
  final TextEditingController? textController;

  /// Builder function that will be called with the context and ref.
  /// Field utilities are accessible via [ref]
  final Widget Function(BuildContext context, $proxyRefName ref) builder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ${provider.fieldWidgetName(field)}State();
}

class ${provider.fieldWidgetName(field)}State extends ConsumerState<${provider.fieldWidgetName(field)}> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();${paramDeclaration()}
    final initialValue = ref.read(${provider.providerNameWithFamily(prefix: 'params')})${provider.isAsyncValue ? '.valueOrNull?' : ''}.${field.name};
    _textController = widget.textController ?? TextEditingController(text: initialValue);

    // Setup listener for provider changes
    ref.listenManual(
      ${provider.providerNameWithFamily(prefix: 'params')}.select(
        (value) => value${provider.isAsyncValue ? '.requireValue' : ''}.${field.name}
      ),
      _handleFieldValueChange,
      fireImmediately: false,
    );

    _textController.addListener(_syncTextToProvider);
  }

  /// Handles when the provider value changes and updates the text controller
  void _handleFieldValueChange(dynamic previous, dynamic next) {
    if (previous == next) return;
    if (_textController.text == next) return;

    // Ensure we're not updating a disposed controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textController.text = ${field.isNullable ? 'next ?? ""' : 'next'};
      }
    });
  }

  /// Syncs text field changes to the provider
  void _syncTextToProvider() {
    if (!mounted) return;
    ${paramDeclaration()}
    ref.read(${provider.providerNameWithFamily(prefix: 'params')}.notifier)
       .update${field.name.pascalCase}(_textController.text);
  }

  @override
  void dispose() {
    _textController.removeListener(_syncTextToProvider);
    // Only dispose if we created the controller
    if (widget.textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ${generateDebugCheckCall(provider)}
    final proxy = ${_createProxyInstance(proxyRefName: proxyRefName, isTextField: true)};
    return widget.builder(context, proxy);
  }
}
''';
}
