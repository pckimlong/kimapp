import 'package:riverpod_widget/src/templates/comment_generator.dart';
import 'package:riverpod_widget/src/templates/utils.dart';

String generateInheritedWidget({
  required String name,
  required List<ClassField> fields,
  CommentGenerator? comment,
}) {
  return '''
${comment.getContent()}class $name extends InheritedWidget {
  ${comment.getMacroRef()}
  const $name({
    super.key,
    ${fields.map((e) => e.toNamedConstructorField()).join('\n')}
    required super.child,
  });

  ${fields.map((e) => e.toClassField()).join('\n')}

  static $name of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<$name>()!;
  }

  @override
  bool updateShouldNotify(covariant $name oldWidget) {
    return ${fields.isEmpty ? "true" : fields.map((e) => '${e.name} != oldWidget.${e.name}').join(' && ')};
  }
}
''';
}
