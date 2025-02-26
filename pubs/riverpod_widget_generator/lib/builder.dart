import 'package:build/build.dart';
import 'package:riverpod_widget_generator/src/generators/state_widget_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder riverpodStateWidgetGenerator(BuilderOptions options) =>
    SharedPartBuilder([RiverpodStateWidgetGenerator()], 'riverpod_state_widget_generator');
