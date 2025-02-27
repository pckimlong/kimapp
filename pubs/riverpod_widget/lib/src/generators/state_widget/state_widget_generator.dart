import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/consumer_widget.dart';
import 'package:riverpod_widget/src/templates/inherited_widget.dart';
import 'package:riverpod_widget/src/templates/proxy_widget_ref.dart';
import 'package:riverpod_widget/src/templates/sub_proxy_widget.dart';
import 'package:riverpod_widget/src/templates/utils.dart';
import 'package:source_gen/source_gen.dart';

import '../../../riverpod_widget.dart';

extension on ProviderDefinition {
  String get proxyWidgetName => '_${baseName}ProxyWidgetRef';
  String get subProxyWidgetName => '_${baseName}StateProxyWidgetRef';
  String get paramInheritedWidgetName => '_${baseName}InheritedWidget';
  String get providerScopeName => '${baseName}ProviderScope';
  String get paramWidgetName => '${baseName}ParamsWidget';
  String get stateWidgetName => '${baseName}StateWidget';
  String get selectWidgetName => '${baseName}SelectWidget';
}

class StateWidgetGenerator extends WidgetGenerator {
  @override
  final TypeChecker annotationTypeChecker = const TypeChecker.fromRuntime(StateWidget);

  @override
  bool canProcess(Element element) {
    return annotationTypeChecker.hasAnnotationOf(element);
  }

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final provider = ProviderDefinition.parse(element);
    final buffer = StringBuffer();

    buffer.writeln(_paramInheritedWidget(provider));
    buffer.writeln(_proxyWidgetRef(provider));
    buffer.writeln(_scopeWidget(provider));
    buffer.writeln(_debugCheckFunction(provider));
    buffer.writeln(_paramWidget(provider));
    buffer.writeln(_stateWidgetProxy(provider));
    buffer.writeln(_stateWidget(provider));
    buffer.writeln(_selectWidget(provider));

    return returnContent(buffer, comment: false);
  }

  @override
  List<String> getRequiredImports() {
    return [
      'package:flutter_riverpod/flutter_riverpod.dart',
      'package:kimapp_utils/kimapp_utils.dart',
      'package:flutter/material.dart',
    ];
  }
}

String _paramInheritedWidget(ProviderDefinition provider) {
  return generateInheritedWidget(
    name: provider.paramInheritedWidgetName,
    fields: [ClassField(name: 'params', type: provider.familyAsRecordType, isRequired: true)],
  );
}

String _scopeWidget(ProviderDefinition provider) {
  final isAsyncValue = provider.isAsyncValue;
  final stateType = provider.getProviderType(name: isAsyncValue ? 'asyncValue' : 'state');
  final baseReturnType = provider.returnType.baseType;
  final builderType =
      "Widget Function(BuildContext context, ${provider.proxyWidgetName} ref, $stateType, Widget? child,)?";
  final hasFamily = provider.familyParameters.isNotEmpty;

  String inheritedWidget({required String child}) {
    if (!hasFamily) return '';

    return '''
    ${provider.paramInheritedWidgetName}(
      params: ${provider.familyAsRecordBindString()},
      child: $child,
    )
    ''';
  }

  String asyncTypeBuilder() {
    if (!isAsyncValue) return 'return child ?? const SizedBox.shrink();';

    return '''
              final themeExtension = Theme.of(context).extension<KimappThemeExtension>();
              return state.when(
                data: (data) {
                  final result = this.data?.call(data) ?? child;
                  if (result == null) {
                    debugPrint('No child provided for ${provider.baseName}ProviderScope. Empty SizedBox will be returned.');
                    return const SizedBox.shrink();
                  }
                  return result;
                },
                error: (error, stack) =>
                    this.error?.call(error, stack) ?? 
                    themeExtension?.defaultErrorStateWidget?.call(context, ref, error) ??
                    const SizedBox.shrink(),
                loading: () => loading?.call() ?? 
                    themeExtension?.defaultLoadingStateWidget?.call(context, ref) ??
                    const SizedBox.shrink(),
              );
    ''';
  }

  return generateConsumerWidget(
    name: provider.providerScopeName,
    fields: [
      ...provider.familyParameters.map((p) => p.toClassField()),
      if (isAsyncValue) ...[
        ClassField(name: 'loading', type: 'Widget Function()?', isRequired: false),
        ClassField(
          name: 'error',
          type: 'Widget Function(Object error, StackTrace? stackTrace)?',
          isRequired: false,
        ),
        ClassField(name: 'data', type: 'Widget Function($baseReturnType data)?', isRequired: false),
      ],
      ClassField(name: 'builder', type: builderType, isRequired: false),
      ClassField(name: 'child', type: 'Widget?', isRequired: false),
      ClassField.providerListenable('onStateChanged', provider.getProviderType()),
    ],
    build: '''
if (onStateChanged != null) {
  ref.listen(${provider.providerNameWithFamily()}, onStateChanged!);
}

return ${inheritedWidget(child: '''
 Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(${provider.providerNameWithFamily()});

    if (builder != null) {
      return builder!(context, ${provider.proxyWidgetName}(ref), state, child);
    }
    
    ${asyncTypeBuilder()}
  },
 )
''')};
''',
  );
}

String _proxyWidgetRef(ProviderDefinition provider) {
  return generateBaseProxyWidgetRef(
    provider.proxyWidgetName,
    methods: [
      if (provider.hasNotifier)
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
      if (provider.hasFamily)
        Method(
          (b) =>
              b
                ..returns = refer(provider.familyAsRecordType)
                ..name = 'params'
                ..type = MethodType.getter
                ..lambda = true
                ..body = Code('${provider.paramInheritedWidgetName}.of(context).params'),
        ),
    ],
  );
}

String _paramWidget(ProviderDefinition provider) {
  if (!provider.hasFamily) return '';

  final builderType =
      "Widget Function(BuildContext context, ${provider.proxyWidgetName} ref, ${provider.familyAsRecordType} params)";

  return generateConsumerWidget(
    name: provider.paramWidgetName,
    fields: [ClassField(name: 'builder', type: builderType, isRequired: true)],
    build: '''
${_debugCheckCall(provider)}
final params = ${provider.paramInheritedWidgetName}.of(context).params;
return builder(context, ${provider.proxyWidgetName}(ref), params);
  ''',
  );
}

String _debugCheckFunction(ProviderDefinition provider) {
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

String _debugCheckCall(ProviderDefinition provider) {
  return '''
  _debugCheckHas${provider.providerScopeName}(context);
  ''';
}

String _paramWidgetWrapper(ProviderDefinition provider, {required String child}) {
  if (!provider.hasFamily) return child;

  return '''
  ${provider.paramWidgetName}(
    builder: (context, ref, params) => $child,
  )
  ''';
}

String _stateWidgetProxy(ProviderDefinition provider) {
  return generateSubProxyWidget(
    provider.subProxyWidgetName,
    parentName: provider.proxyWidgetName,
    methods: [
      Method(
        (b) =>
            b
              ..name = 'state'
              ..type = MethodType.getter
              ..lambda = true
              ..returns = refer(provider.returnType.baseType)
              ..body = Code(
                '_ref.watch(${provider.providerNameWithFamily(prefix: 'params')}).requireValue',
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
                '_ref.watch(${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector(value.requireValue)))',
              ),
      ),
    ],
  );
}

String _stateWidget(ProviderDefinition provider) {
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
if (onStateChanged != null) {
  final params = ${provider.paramInheritedWidgetName}.of(context).params;
  ref.listen(${provider.providerNameWithFamily(prefix: 'params')}, (pre, next) {
    if (pre != next)
      onStateChanged!(pre?.valueOrNull, next.valueOrNull);
  });
}
return ${_paramWidgetWrapper(provider, child: 'builder(context, ref, child)')};
    ''',
  );
}

String _selectWidget(ProviderDefinition provider) {
  final builderType =
      'Widget Function(BuildContext context, ${provider.subProxyWidgetName} ref, Selected value)';

  return generateConsumerWidget(
    name: provider.selectWidgetName,
    generic: 'Selected',
    fields: [
      ClassField(
        name: 'selector',
        type: 'Selected Function(${provider.returnType.baseType} state)',
        isRequired: true,
      ),
      ClassField(name: 'builder', type: builderType, isRequired: true),
      ClassField.providerListenable('onStateChanged', 'Selected', bothNullable: true),
    ],
    build: '''
${_debugCheckCall(provider)}
if (onStateChanged != null) {
  final params = ${provider.paramInheritedWidgetName}.of(context).params;
  ref.listen(
    ${provider.providerNameWithFamily(prefix: 'params')}.select((value) => selector(value.requireValue)),
    (pre, next) {
      if (pre != next) onStateChanged!(pre, next);
    },
  );
}
final stateRef = ${provider.subProxyWidgetName}(ref);
return builder(context, stateRef, stateRef.select(selector));
    ''',
  );
}
