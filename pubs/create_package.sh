#!/bin/bash

# create_package.sh - Helper script for creating a new package

# Function to display help
show_help() {
  echo "Usage: ./create_package.sh [package_name] [options]"
  echo ""
  echo "Options:"
  echo "  --description=\"Description of the package\"  - Set the package description"
  echo "  --no-example                               - Don't create an example project"
  echo "  --help                                     - Show this help message"
  echo ""
  echo "Example:"
  echo "  ./create_package.sh my_package --description=\"A new Flutter package\""
}

# Check if a package name is provided
if [ $# -eq 0 ] || [ "$1" == "--help" ]; then
  show_help
  exit 1
fi

PACKAGE_NAME=$1
shift

# Default values
DESCRIPTION="A new Flutter package"
CREATE_EXAMPLE=true

# Parse options
for i in "$@"; do
  case $i in
    --description=*)
      DESCRIPTION="${i#*=}"
      shift
      ;;
    --no-example)
      CREATE_EXAMPLE=false
      shift
      ;;
    *)
      echo "Unknown option: $i"
      show_help
      exit 1
      ;;
  esac
done

# Create the package directory
PACKAGE_DIR="pubs/$PACKAGE_NAME"
if [ -d "$PACKAGE_DIR" ]; then
  echo "Error: Package directory already exists: $PACKAGE_DIR"
  exit 1
fi

echo "Creating package: $PACKAGE_NAME"
echo "Description: $DESCRIPTION"

# Create the package
flutter create --template=package --org=com.kimapp "$PACKAGE_DIR"

# Update the pubspec.yaml with the description
sed -i '' "s/description: A new Flutter package.*/description: $DESCRIPTION/" "$PACKAGE_DIR/pubspec.yaml"

# Create an example project if requested
if [ "$CREATE_EXAMPLE" = true ]; then
  echo "Creating example project..."
  mkdir -p "$PACKAGE_DIR/example"
  
  # Create pubspec.yaml for the example
  cat > "$PACKAGE_DIR/example/pubspec.yaml" << EOF
name: ${PACKAGE_NAME}_example
description: Example for the $PACKAGE_NAME package
version: 1.0.0
publish_to: none

environment:
  sdk: ^3.7.0

dependencies:
  flutter:
    sdk: flutter
  $PACKAGE_NAME:
    path: ../

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
EOF

  # Create a simple example main.dart
  mkdir -p "$PACKAGE_DIR/example/lib"
  cat > "$PACKAGE_DIR/example/lib/main.dart" << EOF
import 'package:flutter/material.dart';
import 'package:$PACKAGE_NAME/$PACKAGE_NAME.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$PACKAGE_NAME Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '$PACKAGE_NAME Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is an example of $PACKAGE_NAME package',
            ),
          ],
        ),
      ),
    );
  }
}
EOF

  # Create a README.md for the example
  cat > "$PACKAGE_DIR/example/README.md" << EOF
# ${PACKAGE_NAME}_example

Example for the $PACKAGE_NAME package.

## Getting Started

This is a simple example of how to use the $PACKAGE_NAME package.

To run the example:

```bash
cd example
flutter run
```
EOF
fi

# Update the pubrelease.yaml file to include the new package
echo "Updating pubrelease.yaml..."
# Ensure there's no trailing newline before appending
if [ -s "pubs/pubrelease.yaml" ]; then
  # Check if the file ends with a newline
  if [ "$(tail -c 1 "pubs/pubrelease.yaml" | wc -l)" -eq 0 ]; then
    # File doesn't end with a newline, add one
    echo "" >> "pubs/pubrelease.yaml"
  fi
fi

cat >> "pubs/pubrelease.yaml" << EOF
  $PACKAGE_NAME:
    path: $PACKAGE_NAME
    before:
      - melos format --scope=$PACKAGE_NAME
      - melos analyze --scope=$PACKAGE_NAME
      - melos test --scope=$PACKAGE_NAME
      - melos build_all --scope=$PACKAGE_NAME
EOF

echo "Package created successfully: $PACKAGE_DIR"
echo "Run 'melos bootstrap' to update dependencies" 