# Installation & Setup

This guide will get you up and running with KimappSchema in your Flutter project.

## Prerequisites

- Flutter SDK 3.0+
- Dart SDK 2.17+
- Basic knowledge of Dart/Flutter
- (Optional) Supabase project for database integration

## Installation

### 1. Add Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  kimapp: ^latest_version
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  collection: ^1.17.2

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  kimapp_generator: ^latest_version
```

### 2. Install Packages

```bash
flutter pub get
```

### 3. Configure Build Runner

Create or update `build.yaml` in your project root:

```yaml
targets:
  $default:
    builders:
      kimapp_generator|kimapp_schema_builder_generator:
        enabled: true
        options:
          # Optional: Customize generated file paths
          output_extension: ".schema.dart"
      
      kimapp_generator|kimapp_table_generator:
        enabled: true
        
      kimapp_generator|kimapp_model_generator:
        enabled: true
        
      kimapp_generator|kimapp_form_generator:
        enabled: true
```

## Project Structure

Organize your schema files in a logical structure:

```
lib/
├── src/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── user_schema.dart
│   │   │   └── profile_schema.dart
│   │   ├── content/
│   │   │   ├── post_schema.dart
│   │   │   └── comment_schema.dart
│   │   └── shared/
│   │       └── common_types.dart
├── main.dart
└── ...
```

## IDE Configuration

### VS Code

Install these extensions for better development experience:

1. **Dart** - Essential for Dart development
2. **Flutter** - Flutter framework support  
3. **Freezed** - Code generation support
4. **Error Lens** - Inline error display

### IntelliJ/Android Studio

- Enable Dart plugin
- Enable Flutter plugin
- Consider "Dart Data Class" plugin for Freezed support

## Build Configuration

### Analysis Options

Update your `analysis_options.yaml` to ignore generated files:

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.schema.dart"
    - "**/*.table.dart"

linter:
  rules:
    # Add any custom linting rules
    prefer_const_constructors: true
    unnecessary_const: true
```

### Git Ignore

Add generated files to your `.gitignore`:

```gitignore
# KimappSchema generated files
**/*.schema.dart
**/*.schema.freezed.dart
**/*.schema.g.dart
**/*.table.dart

# Other generated files
**/*.g.dart
**/*.freezed.dart
```

## First Schema Test

Create a test schema to verify your setup:

**`lib/test_schema.dart`**
```dart
import 'package:kimapp/kimapp.dart';

@Schema(tableName: 'test_items', className: 'TestItem')
class TestSchema extends KimappSchema {
  final id = Field.id<int>('id');
  final name = Field<String>('name');
  
  @override
  List<Model> get models => [
    Model('TestModel')..copyFields([id, name]),
  ];
}
```

### Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

**Expected Output:**
```
[INFO] Building...
[INFO] Generating build script...
[INFO] Generated build script.
[INFO] Running build...
[INFO] Generated 3 files.
```

**Generated Files:**
- `lib/test_schema.schema.dart`
- `lib/test_schema.schema.freezed.dart`  
- `lib/test_schema.schema.g.dart`

### Verify Generation

Check that you can import and use the generated code:

```dart
import 'package:your_app/test_schema.schema.dart';

void main() {
  // Test the generated model
  final item = TestModel(
    id: TestItemId.fromValue(1),
    name: 'Test Item',
  );
  
  print('Generated successfully: ${item.name}');
}
```

## Development Workflow

### Recommended Workflow

1. **Define Schema** - Create/update your schema file
2. **Generate Code** - Run build_runner
3. **Use Generated Models** - Import and use in your app
4. **Iterate** - Repeat as needed

### Watch Mode (Recommended)

For active development, use watch mode:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

This automatically regenerates code when you save schema files.

### Clean & Rebuild

When you encounter issues:

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

## Common Setup Issues

### Build Runner Not Finding Files

**Problem:** Build runner doesn't detect schema files
**Solution:** Ensure files:
- Have `.dart` extension
- Contain `@Schema()` annotation
- Extend `KimappSchema`
- Are in the correct directory structure

### Import Errors

**Problem:** Cannot import generated files
**Solution:** 
- Run build_runner first
- Check file paths in imports
- Ensure generated files exist

### Conflicting Outputs

**Problem:** "Conflicting outputs" error
**Solution:** Use `--delete-conflicting-outputs` flag:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Performance Issues

**Problem:** Slow code generation
**Solution:**
- Use `--low-resources-mode` for limited memory
- Exclude unnecessary directories in `build.yaml`
- Consider incremental builds

## Supabase Integration Setup

If you're using Supabase, add these dependencies:

```yaml
dependencies:
  supabase_flutter: ^2.0.0
  # ... other dependencies
```

Initialize Supabase in your app:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  
  runApp(MyApp());
}
```

## Next Steps

Now that you have KimappSchema set up:

1. **[Learn Core Concepts](./concepts.md)** - Understand the fundamentals
2. **[Create Your First Schema](./first-schema.md)** - Build a real schema
3. **[Explore Field Types](./field-types.md)** - See all available options

---

**← [Documentation Home](./README.md)** | **[Core Concepts](./concepts.md) →**