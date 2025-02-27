import 'package:build/build.dart';
import 'package:riverpod_widget/src/core/generator_registry.dart';
import 'package:riverpod_widget/src/core/unified_widget_builder.dart';
import 'package:riverpod_widget/src/generators/form_update_widget/form_update_widget_generator.dart';
import 'package:riverpod_widget/src/generators/form_widget/form_widget_generator.dart';
import 'package:riverpod_widget/src/generators/state_widget/state_widget_generator.dart';

/// Initialize the generator registry with all available generators
void _initializeRegistry() {
  final registry = GeneratorRegistry.instance;

  // Register all generators
  registry.registerGenerator(StateWidgetGenerator());
  registry.registerGenerator(FormWidgetGenerator());
  registry.registerGenerator(FormUpdateWidgetGenerator());
}

/// Builder factory for the riverpod_widget package
Builder riverpodWidgetGenerator(BuilderOptions options) {
  // Initialize the registry if it hasn't been already
  _initializeRegistry();

  // Return the unified builder
  return UnifiedWidgetBuilder();
}
