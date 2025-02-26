class CommentGenerator {
  final List<String> lines;
  final String? raw;
  final String? macro;

  const CommentGenerator({
    this.lines = const [],
    this.raw,
    this.macro,
  });

  bool get hasComment => lines.isNotEmpty || (raw != null && raw!.isNotEmpty);

  String get content {
    if (!hasComment) {
      return '';
    }

    final comment = raw ?? "/// " + lines.join('\n/// ');

    if (macro != null) {
      return '/// {@template $macro}\n$comment\n/// {@endtemplate}\n';
    }

    return comment + '\n';
  }

  String get macroRef {
    if (macro != null) {
      return '/// {@macro $macro}\n';
    }
    return '';
  }
}

extension CommentGeneratorExtension on CommentGenerator? {
  String getComment({String? overrideMacro}) {
    if (this == null) {
      return '';
    }

    if (overrideMacro == null) {
      return this!.content;
    }

    return CommentGenerator(
      macro: overrideMacro,
      lines: this!.lines,
      raw: this!.raw,
    ).content;
  }

  String getMacroRef({String? overrideMacro}) {
    if (this == null) {
      return '';
    }

    if (overrideMacro == null) {
      return this!.macroRef;
    }

    return CommentGenerator(
      macro: overrideMacro,
      lines: this!.lines,
      raw: this!.raw,
    ).macroRef;
  }
}
