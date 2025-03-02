# Kimapp Snippets

Code snippets for Kimapp development in Visual Studio Code.

## Features

This extension provides snippets for Dart/Flutter development with Kimapp:

### Autoverpod

Prefix: `kimapp-autoverpod`

Creates an Autoverpod form widget class with the following structure:

```dart
import 'package:autoverpod/autoverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'filename.g.dart';

@formWidget
@riverpod
class ClassName extends _$ClassName {
  @override
  ParamType build() {
    return ParamType(
      
    );
  }

  @override
  Future<ResultType> submit(ParamType state) {
    return ref.read(provider).method(state).getOrThrow();
  }

  @override
  void onSuccess(ResultType result) {}
}
```

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

To package the extension locally without publishing:
```bash
cd tools/extensions/kimapp-snippets
./package-extension.sh
```

This will create a .vsix file that you can install locally in VS Code.

## Release Notes

### 1.0.0

Initial release with Autoverpod snippet.

## License

MIT 