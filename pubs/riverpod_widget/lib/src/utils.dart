import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

final _dartfmt = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

extension ClassExtension on Class {
  String toDart() {
    return _dartfmt.format('${accept(DartEmitter())}');
  }
}
