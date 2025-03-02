# GitHub Actions Workflow for Kimapp Snippets

This extension includes a GitHub Actions workflow that automates the publishing process to the VS Code Marketplace and creates GitHub releases. The workflow is triggered by specific commit messages.

## Setting Up GitHub Secrets

Before using the workflow, you need to set up the following secret in your GitHub repository:

1. Go to your GitHub repository
2. Click on "Settings" > "Secrets and variables" > "Actions"
3. Add the following secret:

   - `VSCODE_MARKETPLACE_TOKEN`: Your Personal Access Token for the VS Code Marketplace
   
   Note: You can use the same token you used for manual publishing: 
   ```
   VSCODE_MARKETPLACE_TOKEN=D53CT5MFJesrH4bPS6J4piKq6vODmDUNYRoLgg5Z2lc7LxORnT0vJQQJ99BCACAAAAAAAAAAAAASAZDO366h
   ```

## Triggering the Workflow

The workflow is triggered by specific commit messages. Use the following pattern in your commit messages:

| Commit Message Pattern | Action |
|------------------------|--------|
| `[publish-snippets]` | Triggers the workflow, runs tests, packages the extension, publishes to VS Code Marketplace, and creates a GitHub Release |

## Example

```bash
# Publish to VS Code Marketplace and create a GitHub Release
git commit -m "Updated snippets [publish-snippets]"
```

## Workflow Steps

The workflow performs the following steps:

1. Checks out the code
2. Sets up Node.js
3. Installs dependencies
4. Verifies the kimapp_feature source code exists
5. Copies the kimapp_feature code to the extension
6. Runs tests to ensure the feature generator works correctly
7. Packages the extension
8. Verifies the package was created successfully
9. Publishes to VS Code Marketplace
10. Creates a GitHub Release with the .vsix file

## Workflow File

The workflow is defined in `.github/workflows/publish-kimapp-snippets.yml`. It runs on pushes to the `main` or `master` branch that include changes to the extension files or the kimapp_feature source code.

## Monorepo Considerations

This workflow is designed to work in a monorepo where:
- The extension is located in the `tools/extensions/kimapp-snippets` directory
- The kimapp_feature source code is located in the `template_generators/kimapp_feature` directory

The workflow will trigger when files in either of these directories are changed.

## Build Process

The extension depends on the `kimapp_feature` JavaScript code located at `/template_generators/kimapp_feature` in the repository root. When packaging or publishing the extension, the `copy-kimapp-feature.js` script automatically copies this code to the extension's `src/kimapp_feature` directory.

The workflow:

1. Ensures it has access to the `kimapp_feature` code
2. Runs the copy script to include the latest code
3. Runs tests to verify the feature generator works correctly
4. Packages the extension for distribution 