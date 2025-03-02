#!/bin/bash

# Check if Personal Access Token is provided
if [ -z "$1" ]; then
    echo "Error: Personal Access Token (PAT) is required."
    echo "Usage: ./publish-extension.sh <PAT>"
    echo "You can create a PAT at https://dev.azure.com/<your-organization>/_usersSettings/tokens"
    exit 1
fi

PAT=$1

# Install vsce if not already installed
if ! command -v vsce &> /dev/null; then
    echo "Installing vsce..."
    npm install -g @vscode/vsce
fi

# Package the extension
echo "Packaging extension..."
vsce package

# Publish the extension
echo "Publishing extension to VS Code Marketplace..."
vsce publish -p $PAT

echo "Done! The extension has been published to the VS Code Marketplace." 