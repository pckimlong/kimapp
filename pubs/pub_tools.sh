#!/bin/bash

# pub_tools.sh - Helper script for package development

# Function to display help
show_help() {
  echo "Usage: ./pub_tools.sh [command] [package_name]"
  echo ""
  echo "Commands:"
  echo "  bootstrap       - Bootstrap all packages"
  echo "  deps            - Update dependencies in all packages"
  echo "  format          - Format code in all packages"
  echo "  analyze         - Run analyzer on all packages"
  echo "  build           - Run build_runner in all packages"
  echo "  test            - Run tests in all packages"
  echo "  clean           - Clean all packages"
  echo "  publish_dry     - Dry-run publishing a package"
  echo "  publish         - Publish a package to pub.dev"
  echo "  use_local       - Use local path dependencies in example projects"
  echo "  use_published   - Use published versions in example projects"
  echo "  local_deps      - Enable local dependencies for interdependent packages"
  echo "  no_local_deps   - Disable local dependencies for interdependent packages"
  echo ""
  echo "Examples:"
  echo "  ./pub_tools.sh bootstrap"
  echo "  ./pub_tools.sh test autoverpod"
  echo "  ./pub_tools.sh publish_dry autoverpod"
  echo "  ./pub_tools.sh use_local autoverpod"
  echo "  ./pub_tools.sh local_deps"
}

# Check if a command is provided
if [ $# -eq 0 ]; then
  show_help
  exit 1
fi

COMMAND=$1
PACKAGE=$2

# Execute the appropriate command
case $COMMAND in
  bootstrap)
    echo "Bootstrapping packages..."
    melos bootstrap
    ;;
  deps)
    echo "Updating dependencies..."
    melos update_deps
    ;;
  format)
    echo "Formatting code..."
    melos format
    ;;
  analyze)
    echo "Running analyzer..."
    melos analyze
    ;;
  build)
    echo "Running build_runner..."
    melos build_all
    ;;
  test)
    if [ -z "$PACKAGE" ]; then
      echo "Running tests in all packages..."
      melos test
    else
      echo "Running tests in $PACKAGE..."
      melos test --scope=$PACKAGE
    fi
    ;;
  clean)
    echo "Cleaning packages..."
    melos clean
    ;;
  publish_dry)
    if [ -z "$PACKAGE" ]; then
      echo "Error: Package name is required for publish_dry"
      show_help
      exit 1
    else
      echo "Running publish dry-run for $PACKAGE..."
      melos publish_dry --scope=$PACKAGE
    fi
    ;;
  publish)
    if [ -z "$PACKAGE" ]; then
      echo "Error: Package name is required for publish"
      show_help
      exit 1
    else
      echo "Publishing $PACKAGE..."
      melos publish --scope=$PACKAGE
    fi
    ;;
  use_local)
    if [ -z "$PACKAGE" ]; then
      echo "Using local path dependencies for all packages..."
      dart pubs/package_helper.dart use_local
    else
      echo "Using local path dependencies for $PACKAGE..."
      dart pubs/package_helper.dart use_local $PACKAGE
    fi
    ;;
  use_published)
    if [ -z "$PACKAGE" ]; then
      echo "Using published versions for all packages..."
      dart pubs/package_helper.dart use_published
    else
      echo "Using published versions for $PACKAGE..."
      dart pubs/package_helper.dart use_published $PACKAGE
    fi
    ;;
  local_deps)
    echo "Enabling local dependencies for interdependent packages..."
    ./pubs/setup_local_deps.sh enable
    ;;
  no_local_deps)
    echo "Disabling local dependencies for interdependent packages..."
    ./pubs/setup_local_deps.sh disable
    ;;
  help)
    show_help
    ;;
  *)
    echo "Unknown command: $COMMAND"
    show_help
    exit 1
    ;;
esac

echo "Done!" 