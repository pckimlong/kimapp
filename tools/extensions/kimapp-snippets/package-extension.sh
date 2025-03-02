#!/bin/bash

# Install vsce if not already installed
if ! command -v vsce &> /dev/null; then
    echo "Installing vsce..."
    npm install -g @vscode/vsce
fi

# Package the extension
echo "Packaging extension..."
vsce package

echo "Done! The .vsix file has been created." 