import 'dart:io';

/// A simple script to help manage package dependencies in example projects.
///
/// Usage:
/// ```
/// dart package_helper.dart use_local [package_name]
/// dart package_helper.dart use_published [package_name]
/// ```
///
/// If no package name is provided, it will apply to all packages in the pubs directory.
void main(List<String> args) async {
  if (args.isEmpty) {
    print('Please provide a command: use_local or use_published');
    exit(1);
  }

  final command = args[0];
  final packageName = args.length > 1 ? args[1] : null;

  final pubsDir = Directory('pubs');
  if (!pubsDir.existsSync()) {
    print('pubs directory not found');
    exit(1);
  }

  final packages = pubsDir.listSync().whereType<Directory>().where((dir) {
    final pubspecFile = File('${dir.path}/pubspec.yaml');
    return pubspecFile.existsSync();
  }).where((dir) {
    if (packageName == null) return true;
    return dir.path.split('/').last == packageName;
  }).toList();

  if (packages.isEmpty) {
    print('No packages found${packageName != null ? ' with name $packageName' : ''}');
    exit(1);
  }

  for (final package in packages) {
    final packageDirName = package.path.split('/').last;
    final exampleDir = Directory('${package.path}/example');

    if (!exampleDir.existsSync()) {
      print('No example directory found for $packageDirName');
      continue;
    }

    final examplePubspecFile = File('${exampleDir.path}/pubspec.yaml');
    if (!examplePubspecFile.existsSync()) {
      print('No pubspec.yaml found in example directory for $packageDirName');
      continue;
    }

    final pubspecContent = await examplePubspecFile.readAsString();
    final lines = pubspecContent.split('\n');

    final updatedLines = <String>[];
    bool inDependencies = false;
    bool foundPackage = false;

    for (final line in lines) {
      if (line.trim() == 'dependencies:') {
        inDependencies = true;
        updatedLines.add(line);
        continue;
      }

      if (inDependencies && line.trim().startsWith('$packageDirName:')) {
        foundPackage = true;

        if (command == 'use_local') {
          // Use local path dependency
          updatedLines.add('  $packageDirName:');
          updatedLines.add('    path: ../');
        } else if (command == 'use_published') {
          // Get the version from the package's pubspec.yaml
          final packagePubspecFile = File('${package.path}/pubspec.yaml');
          final packagePubspec = await packagePubspecFile.readAsString();
          final versionLine =
              packagePubspec.split('\n').firstWhere((line) => line.trim().startsWith('version:'));
          final version = versionLine.split(':')[1].trim();

          updatedLines.add('  $packageDirName: ^$version');
        } else {
          print('Unknown command: $command');
          exit(1);
        }

        // Skip any indented lines that follow (existing dependency configuration)
        var i = lines.indexOf(line) + 1;
        while (i < lines.length && (lines[i].startsWith('    ') || lines[i].trim().isEmpty)) {
          i++;
        }
        continue;
      }

      if (inDependencies && line.trim().startsWith('dev_dependencies:')) {
        inDependencies = false;
      }

      updatedLines.add(line);
    }

    if (!foundPackage && inDependencies && command == 'use_local') {
      // Add the package dependency if it doesn't exist
      final dependenciesIndex = updatedLines.indexWhere((line) => line.trim() == 'dependencies:');
      updatedLines.insert(dependenciesIndex + 1, '  $packageDirName:');
      updatedLines.insert(dependenciesIndex + 2, '    path: ../');
    }

    await examplePubspecFile.writeAsString(updatedLines.join('\n'));

    print(
        'Updated ${examplePubspecFile.path} to ${command == 'use_local' ? 'use local path' : 'use published version'}');
  }

  print('Done!');
}
