import 'package:build/build.dart';
import 'package:riverpod_widget/src/core/generator.dart';
import 'package:source_gen/source_gen.dart';

/// Registry for all widget generators
class GeneratorRegistry {
  GeneratorRegistry._();

  static final GeneratorRegistry _instance = GeneratorRegistry._();

  /// Get the singleton instance
  static GeneratorRegistry get instance => _instance;

  /// List of registered generators
  final List<WidgetGenerator> _generators = [];

  /// Register a new generator
  void registerGenerator(WidgetGenerator generator) => _generators.add(generator);

  /// Get all registered generators
  List<WidgetGenerator> get generators => List.unmodifiable(_generators);

  /// Get all required imports from all registered generators
  List<String> getAllRequiredImports() {
    final imports = <String>{};

    for (final generator in _generators) {
      imports.addAll(generator.getRequiredImports());
    }

    return imports.toList();
  }

  /// Generate code for all registered generators
  Future<String> generateForLibrary(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();

    for (final generator in _generators) {
      final output = await generator.generate(library, buildStep);

      if (output.isNotEmpty) {
        buffer.writeln(output);
      }
    }

    return buffer.toString();
  }
}
