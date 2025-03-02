# Kimapp Snippets

Code snippets for Kimapp development.

## Features

### Code Snippets

This extension provides a set of code snippets for Kimapp development.

### Feature Generation

This extension also provides a feature generation functionality that allows you to quickly create a new feature with all the necessary files and boilerplate code.

To use this functionality:

1. Right-click on a directory in the file explorer
2. Select "Create Kimapp Feature" from the context menu
3. Enter the feature name (in snake_case)
4. Select the ID data type (int or String)
5. Choose whether to generate UI for the feature

The extension will generate the following files and directories directly under the directory you right-clicked on:

```
{selected_directory}/{feature_name}/
├── {feature_name}_schema.dart
├── i_{feature_name}_repo.dart
├── params/
│   └── {feature_name}_list_param.dart
└── providers/
    ├── {feature_name}_list_provider.dart
    ├── {feature_name}_detail_provider.dart
    ├── {feature_name}_create_provider.dart
    ├── {feature_name}_update_provider.dart
    ├── {feature_name}_delete_provider.dart
    └── {feature_name}_list_pagination_provider.dart
```

## Requirements

- Visual Studio Code 1.60.0 or higher

## Extension Settings

This extension contributes the following settings:

* None

## Known Issues

* None

## Release Notes

### 1.0.0

Initial release of Kimapp Snippets

### 1.1.0

Added feature generation functionality

## Working with Markdown

**Note:** You can author your README using Visual Studio Code.  Here are some useful editor keyboard shortcuts:

* Split the editor (`Cmd+\` on macOS or `Ctrl+\` on Windows and Linux)
* Toggle preview (`Shift+CMD+V` on macOS or `Shift+Ctrl+V` on Windows and Linux)
* Press `Ctrl+Space` (Windows, Linux) or `Cmd+Space` (macOS) to see a list of Markdown snippets

### For more information

* [Visual Studio Code's Markdown Support](http://code.visualstudio.com/docs/languages/markdown)
* [Markdown Syntax Reference](https://help.github.com/articles/markdown-basics/)

**Enjoy!**

## Installation

1. Open VS Code
2. Press `Ctrl+P` (or `Cmd+P` on macOS)
3. Type `ext install pckimlong.kimapp-snippets`
4. Press Enter

## Publishing

### Manual Publishing

To publish this extension to the VS Code Marketplace, follow these steps:

1. Create a Personal Access Token (PAT) on Azure DevOps:
   - Go to https://dev.azure.com/[your-organization]/_usersSettings/tokens
   - Create a new token with the "Marketplace (publish)" scope

2. Run the publish script:
   ```bash
   cd tools/extensions/kimapp-snippets
   ./publish-extension.sh <your-PAT> marketplace
   ```

3. The extension will be packaged and published to the VS Code Marketplace.

### Automated Publishing with GitHub Actions

This extension includes a GitHub Actions workflow that automates the publishing process:

1. Set up GitHub Secret:
   - `VSCODE_MARKETPLACE_TOKEN`: Your VS Code Marketplace PAT

2. Trigger the workflow with specific commit messages:
   ```bash
   # Publish to VS Code Marketplace
   git commit -m "Updated snippets [publish-snippets]"
   
   # Publish and create a GitHub Release
   git commit -m "Updated snippets [publish-snippets] [release-snippets]"
   ```

For more details, see [GITHUB_ACTIONS.md](./GITHUB_ACTIONS.md).

## Development

### Building the Extension

This extension depends on the `kimapp_feature` JavaScript code located at `/template_generators/kimapp_feature` in the repository root. When packaging or publishing the extension, the `copy-kimapp-feature.js` script automatically copies this code to the extension's `src/kimapp_feature` directory.

To build the extension:

1. Make sure the `kimapp_feature` code is up to date
2. Run `npm run package` to create the VSIX file

The copied code is not committed to source control as it's considered a build artifact.

## License

MIT 