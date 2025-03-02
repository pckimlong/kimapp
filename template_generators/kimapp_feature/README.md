# Kimapp Feature Generator

This is a shared code generator for Kimapp features. It can be used by both Mason templates and VS Code extensions.

## Overview

The Kimapp Feature Generator provides a unified way to generate feature code for Kimapp applications. By centralizing the code generation logic, we ensure that both the Mason template and VS Code extension generate the same code structure.

## Usage

### From Mason

The Mason template uses the shared code generator through the post_gen.dart hook:

```dart
// In post_gen.dart
final result = await _useSharedGenerator(
  name: name,
  idDataType: idDataType,
  generateUI: generateUI,
  outputDir: outputDir,
);
```

### From VS Code Extension

The VS Code extension uses the shared code generator directly:

```javascript
// In extension.js
const { generateFeature } = require('../../template_generators/kimapp_feature/src');

// ...

const success = await generateFeature({
  name: featureName,
  idDataType: idDataType,
  generateUI: generateUI === 'Yes',
  outputDir: targetDir
});
```

## Structure

The shared code generator consists of:

1. `src/index.js` - The main JavaScript entry point that exports the `generateFeature` function
2. `package.json` - The package configuration

## Maintenance

When updating the feature generation logic, you only need to update the shared code generator, and both the Mason template and VS Code extension will automatically use the updated logic.

## Generated Code Structure

The generator creates the following structure for a feature:

```
feature_name/
├── feature_name_schema.dart
├── i_feature_name_repo.dart
├── params/
│   └── feature_name_list_param.dart
└── providers/
    ├── feature_name_list_provider.dart
    ├── feature_name_detail_provider.dart
    ├── feature_name_create_provider.dart
    ├── feature_name_update_provider.dart
    ├── feature_name_delete_provider.dart
    └── feature_name_list_pagination_provider.dart
```

If UI generation is enabled, it will also generate UI components using the `kimapp_feature_ui` Mason template. 