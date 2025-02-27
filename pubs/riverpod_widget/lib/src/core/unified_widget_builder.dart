import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:riverpod_widget/src/core/generator_registry.dart';
import 'package:source_gen/source_gen.dart';

/// A unified builder that uses all registered generators
class UnifiedWidgetBuilder implements Builder {
  final GeneratorRegistry _registry;

  UnifiedWidgetBuilder({GeneratorRegistry? registry})
    : _registry = registry ?? GeneratorRegistry.instance;

  @override
  Map<String, List<String>> get buildExtensions => {
    '.dart': ['.widget.dart'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    // Skip generated part files
    if (inputId.path.endsWith('.g.dart') ||
        inputId.path.endsWith('.freezed.dart') ||
        inputId.path.endsWith('.widget.dart')) {
      return;
    }

    if (!await buildStep.canRead(inputId)) return;

    final content = await buildStep.readAsString(inputId);
    if (content.isEmpty) return;

    // Skip if the file is not a library
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    // Skip if no generators can process this file
    final library = LibraryReader(await buildStep.resolver.libraryFor(inputId));
    bool hasAnnotations = false;

    for (final element in library.allElements) {
      for (final generator in _registry.generators) {
        if (generator.canProcess(element)) {
          hasAnnotations = true;
          break;
        }
      }
      if (hasAnnotations) break;
    }

    if (!hasAnnotations) return;

    final outputContent = await _generateOutput(library, buildStep);

    if (outputContent.isNotEmpty) {
      final outputId = inputId.changeExtension('.widget.dart');
      await buildStep.writeAsString(outputId, outputContent);
    }
  }

  Future<String> _generateOutput(LibraryReader library, BuildStep buildStep) async {
    final generatedCode = await _registry.generateForLibrary(library, buildStep);

    if (generatedCode.isEmpty) return '';

    // Get all required imports from registered generators
    final imports = _registry.getAllRequiredImports();

    // Create a library with imports and generated code
    final generatedLib = Library((b) {
      b.comments.addAll([
        "dart format width=80",
        "**************************************************************************",
        "GENERATED CODE - DO NOT MODIFY BY HAND",
        "**************************************************************************",
        "ignore_for_file: type=lint",
        "coverage:ignore-file",
      ]);

      // Import source file
      b.directives.add(Directive.import(buildStep.inputId.uri.toString()));

      // Add all imports
      for (final import in imports) {
        b.directives.add(Directive.import(import));
      }

      // Add the generated code
      b.body.add(Code("\n\n$generatedCode"));
    });

    return _dartfmt.format(generatedLib.accept(DartEmitter()).toString());
  }

  static final _dartfmt = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
}
