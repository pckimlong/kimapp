import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Base class for all widget generators
class WidgetGenerator {
  /// The annotation type checker used to identify elements to process
  TypeChecker get annotationTypeChecker =>
      throw UnimplementedError('Subclasses must override annotationTypeChecker');

  /// Generate code for the given library
  ///
  /// This method is used by the build system and should not be overridden
  /// by implementers. Instead, override [generateForAnnotatedElement].
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();

    for (var element in library.allElements) {
      if (canProcess(element)) {
        final annotation = ConstantReader(annotationTypeChecker.firstAnnotationOf(element));

        final output = await generateForAnnotatedElement(element, annotation, buildStep);

        if (output.isNotEmpty) {
          buffer.writeln(output);
        }
      }
    }

    return buffer.toString();
  }

  /// Get the list of imports required by this generator
  List<String> getRequiredImports() => [];

  /// Check if this generator should process the given element
  ///
  /// This method is used internally and should not be overridden
  /// unless you need custom annotation detection logic.
  bool canProcess(Element element) {
    return annotationTypeChecker.hasAnnotationOf(element);
  }

  /// Generate code for a specific annotated element
  ///
  /// This is the main method that implementers should override.
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    throw UnimplementedError('Subclasses must override generateForAnnotatedElement');
  }
}
