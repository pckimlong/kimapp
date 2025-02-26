import 'package:code_builder/code_builder.dart';
import 'package:riverpod_widget/src/templates/comment_generator.dart';
import 'package:riverpod_widget/src/utils.dart';

String subProxyWidget(
  String name, {
  required String baseName,

  List<Field> finalFields = const [],
  CommentGenerator? classComment,
}) {
  final parentName = '_${baseName}ProxyWidgetRef';
  return Class(
    (b) =>
        b
          ..docs.addAll([if (classComment != null) classComment.content])
          ..name = name
          ..extend = refer(parentName)
          ..fields.addAll(finalFields)
          ..constructors.add(
            Constructor(
              (b) =>
                  b
                    ..docs.addAll([if (classComment != null) classComment.macroRef])
                    ..requiredParameters.add(
                      Parameter(
                        (b) =>
                            b
                              ..name = '_ref'
                              ..toSuper = true,
                      ),
                    )
                    ..optionalParameters.addAll(
                      finalFields.map(
                        (e) => Parameter(
                          (b) =>
                              b
                                ..toThis = true
                                ..named = true
                                ..name = e.name
                                ..required = true, // Assuming fields should be required
                        ),
                      ),
                    ),
            ),
          ),
  ).toDart();
}
