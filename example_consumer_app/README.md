# Example Consumer App

This is a minimal example demonstrating how to use kimapp packages in an external Flutter application.

## Setup Instructions

1. Copy this example app structure to your desired location
2. Update the Git repository URL in `pubspec.yaml` to point to your kimapp repository
3. Run `flutter pub get`
4. Start developing!

## Key Files to Examine

- `pubspec.yaml` - Shows how to configure Git dependencies
- `lib/main.dart` - Basic usage example
- `DEPENDENCY_USAGE.md` - Detailed instructions for different scenarios

## Development Workflow

### For Production
Use Git dependencies with specific tags (as shown in pubspec.yaml)

### For Local Development
Uncomment the `dependency_overrides` section in pubspec.yaml and adjust paths to point to your local kimapp packages directory.

## Switching Between Development and Production

1. **Development Mode**: Uncomment `dependency_overrides`, comment out Git dependencies
2. **Production Mode**: Comment out `dependency_overrides`, use Git dependencies
3. Run `flutter pub get` after switching

## Getting Updates

When new package versions are released:

1. Update the `ref` values in the Git dependencies
2. Run `flutter pub get`
3. Or use the update script: `dart ../kimapp/scripts/update_dependencies.dart pubspec.yaml`