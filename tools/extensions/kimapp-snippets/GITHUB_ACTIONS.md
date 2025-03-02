# GitHub Actions Workflow for Kimapp Snippets

This extension includes a GitHub Actions workflow that automates the publishing process to the VS Code Marketplace. The workflow is triggered by specific commit messages.

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

The workflow is triggered by specific commit messages. Use the following patterns in your commit messages:

| Commit Message Pattern | Action |
|------------------------|--------|
| `[publish-snippets]` | Triggers the workflow, packages the extension, and publishes to VS Code Marketplace |
| `[release-snippets]` | Creates a GitHub Release with the .vsix file |

## Examples

```bash
# Publish to VS Code Marketplace
git commit -m "Updated snippets [publish-snippets]"

# Publish and create a GitHub Release
git commit -m "Updated snippets [publish-snippets] [release-snippets]"
```

## Workflow File

The workflow is defined in `.github/workflows/publish-kimapp-snippets.yml`. It runs on pushes to the `main` or `master` branch that include changes to the extension files.

## Monorepo Considerations

This workflow is designed to work in a monorepo where the extension is located in the `tools/extensions/kimapp-snippets` directory. The workflow will only trigger when files in this directory are changed.

## Build Process

The extension depends on the `kimapp_feature` JavaScript code located at `/template_generators/kimapp_feature` in the repository root. When packaging or publishing the extension, the `copy-kimapp-feature.js` script automatically copies this code to the extension's `src/kimapp_feature` directory.

Make sure your CI/CD workflow:

1. Has access to the `kimapp_feature` code
2. Runs `npm run package` which will automatically run the copy script before packaging 