#!/bin/bash

# Script to release kimapp packages with proper tagging
# Usage: ./scripts/release_package.sh <package_name> <version>

set -e

PACKAGE_NAME=$1
VERSION=$2

if [ -z "$PACKAGE_NAME" ] || [ -z "$VERSION" ]; then
    echo "Usage: $0 <package_name> <version>"
    echo "Example: $0 kimapp 0.0.4"
    echo "Available packages: kimapp, kimapp_supabase_helper, kimapp_generator, kimapp_utils"
    exit 1
fi

PACKAGE_PATH="packages/$PACKAGE_NAME"
TAG_NAME="${PACKAGE_NAME}-v${VERSION}"

# Check if package exists
if [ ! -d "$PACKAGE_PATH" ]; then
    echo "Error: Package $PACKAGE_NAME not found at $PACKAGE_PATH"
    exit 1
fi

# Check if tag already exists
if git rev-parse "$TAG_NAME" >/dev/null 2>&1; then
    echo "Error: Tag $TAG_NAME already exists"
    exit 1
fi

echo "Releasing $PACKAGE_NAME version $VERSION"

# Update version in pubspec.yaml
echo "Updating version in $PACKAGE_PATH/pubspec.yaml..."
sed -i '' "s/^version: .*/version: $VERSION/" "$PACKAGE_PATH/pubspec.yaml"

# Check if version was updated
if ! grep -q "^version: $VERSION" "$PACKAGE_PATH/pubspec.yaml"; then
    echo "Error: Failed to update version in pubspec.yaml"
    exit 1
fi

# Commit the version change
echo "Committing version change..."
git add "$PACKAGE_PATH/pubspec.yaml"
git commit -m "Bump $PACKAGE_NAME to v$VERSION"

# Create and push tag
echo "Creating tag $TAG_NAME..."
git tag "$TAG_NAME"

echo "Pushing changes and tag..."
CURRENT_BRANCH=$(git branch --show-current)
git push origin "$CURRENT_BRANCH"
git push origin "$TAG_NAME"

echo "✅ Successfully released $PACKAGE_NAME v$VERSION"
echo "📦 Tag: $TAG_NAME"
echo ""
echo "To use this version in other projects, update their pubspec.yaml:"
echo "ref: $TAG_NAME"