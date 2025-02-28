import 'package:code_builder/code_builder.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';
import 'package:autoverpod_generator/src/templates/sub_proxy_widget.dart';

import '../state_widget_names.dart';

String generateStateWidgetProxy(ProviderDefinition provider) {
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
