#!/bin/bash

# setup_local_deps.sh - Helper script for setting up local dependencies

# Function to display help
show_help() {
  echo "Usage: ./setup_local_deps.sh [command]"
  echo ""
  echo "Commands:"
  echo "  enable   - Enable local dependencies (create pubspec_overrides.yaml files)"
  echo "  disable  - Disable local dependencies (remove pubspec_overrides.yaml files)"
  echo "  help     - Show this help message"
  echo ""
  echo "Example:"
  echo "  ./setup_local_deps.sh enable"
}

# Check if a command is provided
if [ $# -eq 0 ] || [ "$1" == "help" ]; then
  show_help
  exit 1
fi

COMMAND=$1

case $COMMAND in
  enable)
    echo "Enabling local dependencies..."
    
    # Create pubspec_overrides.yaml for autoverpod_generator
    cat > "pubs/autoverpod_generator/pubspec_overrides.yaml" << EOF
# This file is used to override dependencies with local paths
# for development purposes.
dependency_overrides:
  autoverpod:
    path: ../autoverpod
EOF
    
    # Create pubspec_overrides.yaml for autoverpod_generator_example
    cat > "pubs/autoverpod_generator/example/pubspec_overrides.yaml" << EOF
# This file is used to override dependencies with local paths
# for development purposes.
dependency_overrides:
  autoverpod:
    path: ../../autoverpod
  autoverpod_generator:
    path: ../
EOF
    
    # Create pubspec_overrides.yaml for autoverpod_example
    cat > "pubs/autoverpod/example/pubspec_overrides.yaml" << EOF
# This file is used to override dependencies with local paths
# for development purposes.
dependency_overrides:
  autoverpod:
    path: ../
EOF

    # Run flutter pub get in each directory
    echo "Running flutter pub get in each directory..."
    (cd pubs/autoverpod && flutter pub get)
    (cd pubs/autoverpod_generator && flutter pub get)
    (cd pubs/autoverpod/example && flutter pub get)
    (cd pubs/autoverpod_generator/example && flutter pub get)
    
    echo "Local dependencies enabled and packages updated."
    ;;
    
  disable)
    echo "Disabling local dependencies..."
    
    # Remove pubspec_overrides.yaml files
    rm -f "pubs/autoverpod_generator/pubspec_overrides.yaml"
    rm -f "pubs/autoverpod_generator/example/pubspec_overrides.yaml"
    rm -f "pubs/autoverpod/example/pubspec_overrides.yaml"
    
    # Run flutter pub get in each directory
    echo "Running flutter pub get in each directory..."
    (cd pubs/autoverpod && flutter pub get)
    (cd pubs/autoverpod_generator && flutter pub get)
    (cd pubs/autoverpod/example && flutter pub get)
    (cd pubs/autoverpod_generator/example && flutter pub get)
    
    echo "Local dependencies disabled and packages updated."
    ;;
    
  *)
    echo "Unknown command: $COMMAND"
    show_help
    exit 1
    ;;
esac

echo "Done!" 