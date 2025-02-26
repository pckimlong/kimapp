import 'package:kimapp_generator/src/utils/comment_generator.dart';
import 'package:kimapp_generator/src/utils/field_defination.dart';

String generateConsumerWidget({
  required String name,
  required Set<FieldDefination> fields,
  required String build,
  CommentGenerator? comment,
  bool useHook = false,
}) {
  return '''
${comment.getComment()}class $name extends ${useHook ? 'HookConsumerWidget' : 'ConsumerWidget'} {
  ${comment.getMacroRef()}\tconst $name({
    super.key,
    ${fields.map((e) => e.toNamedConstructorField()).join('\n')}
  });

  ${fields.map((e) => e.toClassField()).join('\n')}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    $build
  }
}''';
}
