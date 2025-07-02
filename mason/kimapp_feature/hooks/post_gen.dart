import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

void run(HookContext context) async {
  final progress = context.logger.progress('Generating kimapp feature');

  try {
    // Get variables from mason context
    final name = context.vars['name'] as String;
    final idDataType = context.vars['id_data_type'] as String;

    // Get the project root directory (where mason was called from)
    final outputDir = Directory.current.path;

    // Find the kimapp project directory with template_generators
    final kimappProjectDir = await findKimappProjectDir();
    if (kimappProjectDir == null) {
      progress.fail('Could not find kimapp project with template generators');
      return;
    }

    final sourceTemplateDir = path.join(kimappProjectDir, 'template_generators', 'kimapp_feature');
    final tempTemplateDir = path.join(outputDir, '.temp_kimapp_feature_generator');

    try {
      // Copy template generator to temp directory
      await copyDirectory(sourceTemplateDir, tempTemplateDir);

      // Install dependencies in temp directory
      final installResult = await Process.run(
        'npm',
        ['install', '--production'],
        workingDirectory: tempTemplateDir,
      );

      if (installResult.exitCode != 0) {
        context.logger.warn('Failed to install npm dependencies, continuing...');
      }

      // Run the template generator
      final result = await Process.run(
        'node',
        [
          path.join(tempTemplateDir, 'cli.js'),
          '--name',
          name,
          '--id-data-type',
          idDataType,
          '--output-dir',
          path.join(outputDir, 'lib', 'src', 'features'),
        ],
        workingDirectory: tempTemplateDir,
      );

      if (result.exitCode == 0) {
        progress.complete('✓ kimapp feature generated successfully');

        // Log any output from the generator
        if (result.stdout.toString().isNotEmpty) {
          context.logger.info(result.stdout.toString());
        }
      } else {
        progress.fail('Failed to generate kimapp feature');

        // Log error output
        if (result.stderr.toString().isNotEmpty) {
          context.logger.err(result.stderr.toString());
        }
        if (result.stdout.toString().isNotEmpty) {
          context.logger.info(result.stdout.toString());
        }
      }
    } finally {
      // Clean up temp directory
      if (Directory(tempTemplateDir).existsSync()) {
        await Directory(tempTemplateDir).delete(recursive: true);
      }
    }
  } catch (e) {
    progress.fail('Error generating kimapp feature: $e');
  }
}

Future<String?> findKimappProjectDir() async {
  // Common locations where kimapp project might be
  final possiblePaths = [
    // Check if we're already in the kimapp project
    Directory.current.path,
    // Check parent directories
    path.join(Directory.current.path, '..'),
    path.join(Directory.current.path, '..', '..'),
    path.join(Directory.current.path, '..', '..', '..'),
    // Check common development directories
    path.join(Platform.environment['HOME'] ?? '', 'Development', 'projects', 'kimapp'),
    path.join(Platform.environment['HOME'] ?? '', 'Projects', 'kimapp'),
    path.join(Platform.environment['HOME'] ?? '', 'kimapp'),
  ];

  for (final possiblePath in possiblePaths) {
    final templateGeneratorsPath = path.join(possiblePath, 'template_generators', 'kimapp_feature');
    if (Directory(templateGeneratorsPath).existsSync()) {
      return possiblePath;
    }
  }

  return null;
}

Future<void> copyDirectory(String source, String destination) async {
  final sourceDir = Directory(source);
  if (!sourceDir.existsSync()) {
    throw Exception('Source directory does not exist: $source');
  }

  // Create destination directory
  final destDir = Directory(destination);
  if (destDir.existsSync()) {
    await destDir.delete(recursive: true);
  }
  await destDir.create(recursive: true);

  // Copy all files and subdirectories
  await for (final entity in sourceDir.list(recursive: true)) {
    final relativePath = path.relative(entity.path, from: source);
    final destPath = path.join(destination, relativePath);

    // Skip node_modules
    if (relativePath.contains('node_modules')) {
      continue;
    }

    if (entity is Directory) {
      await Directory(destPath).create(recursive: true);
    } else if (entity is File) {
      final destFile = File(destPath);
      await destFile.parent.create(recursive: true);
      await entity.copy(destPath);
    }
  }
}
