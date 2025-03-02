class FieldDefination {
  final String name;
  final String type;
  final String? defaultValue;
  final bool isOptional;
  final List<String> comment;

  FieldDefination({
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.isOptional,
    this.comment = const [],
  });

  bool get isNullable => type.contains('?');

  String get typeWithNoNullable =>
      isNullable ? type.substring(0, type.length - 1) : type;

  String toClassField() {
    final text = 'final $type $name;';

    if (comment.isNotEmpty) {
      return '/// ${comment.join('\n/// ')}\n$text';
    }

    return text;
  }

  String toNamedConstructorField({bool commaSeperator = true}) {
    String text;

    if (defaultValue != null) {
      text = 'this.$name = $defaultValue';
    } else if (isOptional && isNullable) {
      text = 'this.$name';
    } else {
      text = 'required this.$name';
    }

    return text + (commaSeperator ? "," : "");
  }

  /// Wrap type with something else. eg. int => AsynValue<int>
  String wrapTypeWith(String wrapper) {
    return '${wrapper}<$type>';
  }
}
