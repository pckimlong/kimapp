import 'package:code_builder/code_builder.dart';
import 'package:autoverpod_generator/src/templates/comment_generator.dart';

String generateBaseProxyWidgetRef(
  String name, {
  List<Method> methods = const [],
  CommentGenerator? classComment,
}) {
  return Class(
    (b) => b
      ..docs.addAll([if (classComment != null) classComment.content])
      ..name = name
      ..fields.add(
        Field(
          (b) => b
            ..modifier = FieldModifier.final$
            ..name = '_ref'
            ..type = refer(
              'WidgetRef',
              'package:flutter_riverpod/flutter_riverpod.dart',
            ),
        ),
      )
      ..constructors.add(
        Constructor(
          (b) => b
            ..docs.addAll([if (classComment != null) classComment.macroRef])
            ..requiredParameters.add(
              Parameter(
                (b) => b
                  ..toThis = true
                  ..name = '_ref',
              ),
            ),
        ),
      )
      ..methods.addAll([
        ...methods,
        Method(
          (b) => b
            ..name = 'context'
            ..type = MethodType.getter
            ..returns = refer('BuildContext')
            ..lambda = true
            ..body = refer('_ref.context').code,
        ),
        Method(
          (b) => b
            ..name = 'exists'
            ..returns = refer('bool')
            ..lambda = true
            ..requiredParameters.add(
              Parameter((b) => b..name = 'provider'),
            )
            ..body = refer('_ref.exists').call([refer('provider')]).code,
        ),
        Method(
          (b) => b
            ..name = 'invalidate'
            ..returns = refer('void')
            ..lambda = true
            ..requiredParameters.add(
              Parameter((b) => b..name = 'provider'),
            )
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..name = 'asReload'
                  ..named = true
                  ..type = refer('bool')
                  ..defaultTo = literalFalse.code,
              ),
            )
            ..body = refer('_ref.invalidate').call(
              [refer('provider')],
              {'asReload': refer('asReload')},
            ).code,
        ),
        Method(
          (b) => b
            ..name = 'listen'
            ..types.add(refer('T'))
            ..returns = refer('void')
            ..lambda = true
            ..requiredParameters.addAll([
              Parameter((b) => b..name = 'provider'),
              Parameter(
                (b) => b
                  ..name = 'listener'
                  ..type = refer('void Function(T?, T)'),
              ),
            ])
            ..optionalParameters.add(
              Parameter(
                (b) => b
                  ..name = 'onError'
                  ..named = true
                  ..type = refer('void Function(Object, StackTrace)?'),
              ),
            )
            ..body = refer('_ref.listen').call(
              [refer('provider'), refer('listener')],
              {'onError': refer('onError')},
            ).code,
        ),
        Method(
          (b) => b
            ..name = 'listenManual'
            ..types.add(refer('T'))
            ..returns = refer('ProviderSubscription<T>')
            ..lambda = true
            ..requiredParameters.addAll([
              Parameter((b) => b..name = 'provider'),
              Parameter(
                (b) => b
                  ..name = 'listener'
                  ..type = refer('void Function(T?, T)'),
              ),
            ])
            ..optionalParameters.addAll([
              Parameter(
                (b) => b
                  ..name = 'onError'
                  ..named = true
                  ..type = refer('void Function(Object, StackTrace)?'),
              ),
              Parameter(
                (b) => b
                  ..name = 'fireImmediately'
                  ..named = true
                  ..type = refer('bool')
                  ..defaultTo = literalFalse.code,
              ),
            ])
            ..body = refer('_ref.listenManual').call(
              [refer('provider'), refer('listener')],
              {
                'onError': refer('onError'),
                'fireImmediately': refer('fireImmediately'),
              },
            ).code,
        ),
        Method(
          (b) => b
            ..name = 'read'
            ..types.add(refer('T'))
            ..returns = refer('T')
            ..lambda = true
            ..requiredParameters.add(
              Parameter((b) => b..name = 'provider'),
            )
            ..body = refer('_ref.read').call([refer('provider')]).code,
        ),
        Method(
          (b) => b
            ..name = 'refresh'
            ..types.add(refer('State'))
            ..returns = refer('State')
            ..lambda = true
            ..requiredParameters.add(
              Parameter((b) => b..name = 'provider'),
            )
            ..body = refer('_ref.refresh').call([refer('provider')]).code,
        ),
        Method(
          (b) => b
            ..name = 'watch'
            ..types.add(refer('T'))
            ..returns = refer('T')
            ..lambda = true
            ..requiredParameters.add(
              Parameter((b) => b..name = 'provider'),
            )
            ..body = refer('_ref.watch').call([refer('provider')]).code,
        ),
      ]),
  ).accept(DartEmitter()).toString();
}
