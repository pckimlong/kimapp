#!/bin/bash

# Install dependencies
echo "Installing dependencies..."
npm install

# Install vsce if not already installed
if ! command -v vsce &> /dev/null; then
    echo "Installing vsce..."
    npm install -g @vscode/vsce
fi

# Package the extension
echo "Packaging extension..."
vsce package

# Check if the user wants to publish the extension
read -p "Do you want to publish the extension to the VS Code Marketplace? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Check if the user is logged in
    if ! vsce verify-pat; then
        echo "You need to login to the VS Code Marketplace first."
        echo "Run 'vsce login <publisher>' and follow the instructions."
        exit 1
    fi

    # Publish the extension
    echo "Publishing extension..."
    vsce publish
    
    echo "Extension published successfully!"
else
    echo "Extension packaged but not published."
    echo "You can find the .vsix file in the current directory."
fi 