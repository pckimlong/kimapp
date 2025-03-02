#!/bin/bash

# Exit on error
set -e

# Install vsce if not already installed
if ! command -v vsce &> /dev/null; then
    echo "Installing vsce..."
    npm install -g @vscode/vsce
fi

# Run the copy-kimapp-feature.js script
echo "Running copy-kimapp-feature.js..."
node "$(dirname "$0")/copy-kimapp-feature.js"

# Verify that the kimapp_feature directory was copied successfully
DEST_DIR="$(dirname "$0")/src/kimapp_feature"
if [ ! -d "$DEST_DIR" ]; then
    echo "Error: kimapp_feature directory was not copied correctly."
    echo "Please check if the source directory exists at: $(dirname "$0")/../../../template_generators/kimapp_feature"
    exit 1
fi

# Verify that the index.js file exists
if [ ! -f "$DEST_DIR/src/index.js" ]; then
    echo "Error: kimapp_feature/src/index.js file is missing."
    exit 1
fi

# Package the extension
echo "Packaging extension..."
vsce package

# Run the test script to verify the generator is working
echo "Testing the kimapp_feature generator..."
node "$(dirname "$0")/test-generator.js"

echo "Done! The .vsix file has been created." 