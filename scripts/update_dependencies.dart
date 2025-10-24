#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

/// Script to update kimapp package dependencies in external projects
/// Usage: dart scripts/update_dependencies.dart <path_to_pubspec.yaml> [package_version]

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart scripts/update_dependencies.dart <path_to_pubspec.yaml> [package_version]');
    print('Example: dart scripts/update_dependencies.dart ../my_app/pubspec.yaml');
    exit(1);
  }

  final pubspecPath = args[0];
  final specificVersion = args.length > 1 ? args[1] : null;

  if (!File(pubspecPath).existsSync()) {
    print('Error: pubspec.yaml not found at $pubspecPath');
    exit(1);
  }

  print('Updating kimapp dependencies in $pubspecPath...');

  // Latest versions (you can update these when releasing new versions)
  final latestVersions = {
    'kimapp': specificVersion ?? '0.0.3',
    'kimapp_supabase_helper': specificVersion ?? '0.0.3',
    'kimapp_generator': specificVersion ?? '0.0.2',
    'kimapp_utils': specificVersion ?? '0.0.3',
    'autoverpod': specificVersion ?? '0.0.4+1',
    'autoverpod_generator': specificVersion ?? '0.0.4+1',
  };

  try {
    final content = await File(pubspecPath).readAsString();
    final pubspec = jsonDecode(content) as Map<String, dynamic>;

    bool updated = false;

    // Update dependencies
    final dependencies = pubspec['dependencies'] as Map<String, dynamic>? ?? {};
    for (final entry in latestVersions.entries) {
      final packageName = entry.key;
      final version = entry.value;
      final tagRef = '${packageName}_v$version'.replaceAll('_', '-');

      if (dependencies.containsKey(packageName)) {
        final dep = dependencies[packageName];
        if (dep is Map<String, dynamic> && dep.containsKey('git')) {
          final gitDep = dep['git'] as Map<String, dynamic>;
          if (gitDep['ref'] != tagRef) {
            gitDep['ref'] = tagRef;
            updated = true;
            print('Updated $packageName to ref: $tagRef');
          }
        }
      }
    }

    if (updated) {
      // Write back the updated pubspec
      final updatedContent = const JsonEncoder.withIndent('  ').convert(pubspec);
      await File(pubspecPath).writeAsString(updatedContent);
      print('✅ Dependencies updated successfully!');
      print('Run "flutter pub get" to apply changes.');
    } else {
      print('ℹ️  All dependencies are already up to date.');
    }

  } catch (e) {
    print('Error updating dependencies: $e');
    exit(1);
  }
}