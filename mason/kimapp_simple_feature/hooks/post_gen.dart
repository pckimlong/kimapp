import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final generate = context.vars['generate_ui'];

  if (generate == false) {
    return;
  }

  final progress = context.logger.progress('Running UI generation');

  // Get the variables from the current generation
  final name = context.vars['name'];
  final outputDir = context.vars['output_directory'];

  // Run mason make command with the correct variable format
  final result = await Process.run(
    'mason',
    ['make', 'kimapp_feature_ui', '--name', name],
    workingDirectory: outputDir,
  );

  if (result.exitCode != 0) {
    progress.fail('UI generation failed: ${result.stderr}');
    return;
  }

  progress.complete('UI generation complete');
}
