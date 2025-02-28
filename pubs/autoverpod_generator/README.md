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

# AutoVerpod Generator

A Flutter package for generating widgets with Riverpod integration.

## Features

- Generate stateless widgets with Riverpod integration
- Generate form widgets with Riverpod integration
- Generate form update widgets with Riverpod integration
- Extensible architecture for adding custom generators

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  autoverpod: ^1.0.0

dev_dependencies:
  autoverpod_generator: ^1.0.0
  build_runner: ^2.4.0
```

## Usage

### Basic Usage

1. Add annotations to your classes:

```dart
import 'package:autoverpod/autoverpod.dart';

@stateWidget
class MyState {
  // Your state class
}

@formWidget
class MyForm {
  // Your form class
}

@formUpdateWidget
class MyFormUpdate {
  // Your form update class
}
```

2. Run the build_runner to generate the widgets:

```bash
flutter pub run build_runner build
```

3. Use the generated widgets in your app:

```dart
import 'my_state.widget.dart';

// Use the generated widgets
StateMyState();
FormMyForm();
FormUpdateMyFormUpdate();
```

## Creating Custom Generators

The package is designed to be extensible, allowing you to create custom generators for your specific needs.

### Step 1: Create a new annotation

Create a new annotation class that extends `WidgetAnnotation`:

```dart
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';
import 'package:autoverpod/autoverpod.dart';

@Target({TargetKind.classType, TargetKind.function})
@sealed
class MyCustomWidget extends WidgetAnnotation {
  const MyCustomWidget();
}

const myCustomWidget = MyCustomWidget();
```

### Step 2: Create a new generator

Create a new generator class that implements `WidgetGenerator`:

```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:autoverpod_generator/autoverpod_generator.dart';
import 'package:source_gen/source_gen.dart';

class MyCustomWidgetGenerator implements WidgetGenerator {
  @override
  final TypeChecker annotationTypeChecker = const TypeChecker.fromRuntime(MyCustomWidget);

  @override
  bool canProcess(Element element) {
    return annotationTypeChecker.hasAnnotationOf(element);
  }

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    for (var element in library.allElements) {
      if (canProcess(element)) {
        buffer.writeln(_generateWidget(element.displayName));
      }
    }

    return buffer.toString();
  }

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) return '';
    if (!canProcess(element)) return '';

    return _generateWidget(element.displayName);
  }

  String _generateWidget(String baseName) {
    final className = 'MyCustom$baseName';

    final clazz = Class(
      (b) =>
          b
            ..name = className
            ..extend = refer('StatelessWidget')
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'build'
                      ..returns = refer('Widget')
                      ..requiredParameters.add(
                        Parameter(
                          (b) =>
                              b
                                ..name = 'context'
                                ..type = refer('BuildContext'),
                        ),
                      )
                      ..annotations.add(refer('override'))
                      ..body = Code('return Container();'),
              ),
            ),
    );

    return clazz.accept(DartEmitter()).toString();
  }
  
  @override
  List<String> get requiredImports => [
    'package:flutter/material.dart',
  ];
}
```

### Step 3: Register your generator

Register your generator in the `builder.dart` file:

```dart
import 'package:build/build.dart';
import 'package:autoverpod_generator/src/core/generator_registry.dart';
import 'package:autoverpod_generator/src/core/unified_widget_builder.dart';
import 'package:autoverpod_generator/src/generators/form_update_widget/form_update_widget_generator.dart';
import 'package:autoverpod_generator/src/generators/form_widget/form_widget_generator.dart';
import 'package:autoverpod_generator/src/generators/state_widget/state_widget_generator.dart';
import 'package:autoverpod_generator/src/generators/my_custom_widget/my_custom_widget_generator.dart';

void _initializeRegistry() {
  final registry = GeneratorRegistry.instance;
  
  // Register all generators
  registry.registerGenerator(StateWidgetGenerator());
  registry.registerGenerator(FormWidgetGenerator());
  registry.registerGenerator(FormUpdateWidgetGenerator());
  
  // Register your custom generator
  registry.registerGenerator(MyCustomWidgetGenerator());
}

Builder autoverpodGenerator(BuilderOptions options) {
  _initializeRegistry();
  return UnifiedWidgetBuilder();
}
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
