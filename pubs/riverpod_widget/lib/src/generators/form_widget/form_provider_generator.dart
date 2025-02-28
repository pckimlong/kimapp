import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:riverpod_widget/riverpod_widget.dart';
import 'package:source_gen/source_gen.dart';

/// Generator that creates provider extensions and helper methods for form state management
/// This generator outputs to .g.dart files
class FormProviderGenerator extends GeneratorForAnnotation<FormWidget> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) return '';

    // This will be implemented by the user to generate provider extensions
    // and helper methods for form state management
    return '';
  }
}
