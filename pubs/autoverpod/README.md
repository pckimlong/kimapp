<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# Autoverpod

A package providing annotations for Riverpod widgets to simplify code generation and automate widget creation.

## Features

- Provides annotations for different types of widgets
- Supports form widgets with `@formWidget` annotation
- Supports state widgets with `@stateWidget` annotation
- Designed to work with code generators for Riverpod

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  autoverpod: ^0.0.3
```

## Usage

### Form Widget Annotation

Use the `@formWidget` annotation to mark a class or function as a form widget:

```dart
import 'package:autoverpod/autoverpod.dart';

@formWidget
class UserForm extends StatelessWidget {
  // Form implementation
}
```

### State Widget Annotation

Use the `@stateWidget` annotation to mark a class or function as a state widget:

```dart
import 'package:autoverpod/autoverpod.dart';

@stateWidget
class UserProfile extends StatelessWidget {
  // State widget implementation
}
```

## Additional Information

This package is part of a larger ecosystem for simplifying Riverpod-based widget development. It works best when used with a code generator that processes these annotations.

## License

This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
