# Package Development with Melos

This directory contains packages that are part of the Kimapp ecosystem. We use [Melos](https://melos.invertase.dev/) to manage these packages in a monorepo structure.

## Getting Started

1. Install Melos globally:

```bash
dart pub global activate melos
```

2. Install pub_release globally (optional, for automated releases):

```bash
dart pub global activate pub_release
```

3. Bootstrap the project (get all dependencies):

```bash
melos bootstrap
```

## Available Commands

Melos provides several useful commands for managing packages:

```bash
# Update dependencies in all packages
melos update_deps

# Format code in all packages
melos format

# Run analyzer on all packages
melos analyze

# Run build_runner in all packages that need it
melos build_all

# Run tests in all packages
melos test

# Clean all packages
melos clean

# Dry-run publishing all packages
melos publish_dry

# Publish all packages to pub.dev
melos publish
```

## Helper Scripts

### Package Helper Script

The `package_helper.dart` script helps manage dependencies in example projects. It allows you to easily switch between using local path dependencies and published package versions.

```bash
# Use local path dependencies for all packages
dart pubs/package_helper.dart use_local

# Use published versions for all packages
dart pubs/package_helper.dart use_published

# Use local path dependencies for a specific package
dart pubs/package_helper.dart use_local autoverpod

# Use published versions for a specific package
dart pubs/package_helper.dart use_published autoverpod
```

### Shell Script Helper

For convenience, we've also provided a shell script that makes it easier to run common commands:

```bash
# Make the script executable (only needed once)
chmod +x pubs/pub_tools.sh

# Show help
./pubs/pub_tools.sh help

# Bootstrap all packages
./pubs/pub_tools.sh bootstrap

# Run tests for a specific package
./pubs/pub_tools.sh test autoverpod

# Use local path dependencies for a specific package
./pubs/pub_tools.sh use_local autoverpod

# Enable local dependencies for interdependent packages
./pubs/pub_tools.sh local_deps

# Disable local dependencies for interdependent packages
./pubs/pub_tools.sh no_local_deps

# Publish a package
./pubs/pub_tools.sh publish autoverpod
```

### Create Package Script

We've included a script to make it easier to create new packages:

```bash
# Make the script executable (only needed once)
chmod +x pubs/create_package.sh

# Show help
./pubs/create_package.sh --help

# Create a new package
./pubs/create_package.sh my_package --description="My awesome package"

# Create a package without an example project
./pubs/create_package.sh my_package --no-example
```

The script will:
- Create a new package in the `pubs` directory
- Set up the package structure with the specified description
- Create an example project (unless `--no-example` is specified)
- Update the `pubrelease.yaml` file to include the new package

## Automated Releases with pub_release

We've included a configuration file for the [pub_release](https://pub.dev/packages/pub_release) tool, which can help automate the release process.

To use pub_release:

1. Install it globally: `dart pub global activate pub_release`
2. Navigate to your package directory: `cd pubs/autoverpod`
3. Run the release command: `pub_release --config=../pubrelease.yaml`

The tool will:
- Increment the version in pubspec.yaml
- Update the CHANGELOG.md
- Run the configured pre-release commands (format, analyze, test, build)
- Publish the package to pub.dev
- Run the configured post-release commands (git commit, tag, push)

## Package Development Workflow

1. Make changes to your package
2. Run tests: `melos test --scope=your_package_name` or `./pubs/pub_tools.sh test your_package_name`
3. Update the version in the package's `pubspec.yaml`
4. Update the `CHANGELOG.md` file
5. Run a publish dry-run: `./pubs/pub_tools.sh publish_dry your_package_name`
6. Publish the package: `./pubs/pub_tools.sh publish your_package_name`

Alternatively, use the automated release process:
```bash
cd pubs/your_package_name
pub_release --config=../pubrelease.yaml
```

## Using Local Packages in Your App

During development, you can use the local version of a package in your app by adding a path dependency in your app's `pubspec.yaml`:

```yaml
dependencies:
  autoverpod:
    path: /path/to/kimapp/pubs/autoverpod
```

When you're ready to use the published version:

```yaml
dependencies:
  autoverpod: ^1.0.0  # Use the appropriate version
```

## Creating a New Package

You can create a new package using the create_package.sh script:

```bash
./pubs/create_package.sh my_package --description="My awesome package"
```

Or manually:

1. Create a new directory in the `pubs` directory
2. Initialize your package with `flutter create --template=package your_package_name`
3. Update the `pubspec.yaml` file with appropriate information
4. Create an example project in the `example` directory
5. Add your package to the example's dependencies using a path reference
6. Run `melos bootstrap` to update dependencies
7. Add your package to the `pubrelease.yaml` configuration file

### Local Development with Dependencies

When working with packages that have interdependencies (like autoverpod and autoverpod_generator), you can use the `setup_local_deps.sh` script directly or through the pub_tools.sh helper:

```bash
# Using setup_local_deps.sh directly
chmod +x pubs/setup_local_deps.sh
./pubs/setup_local_deps.sh enable
./pubs/setup_local_deps.sh disable

# Using pub_tools.sh
./pubs/pub_tools.sh local_deps     # Enable local dependencies
./pubs/pub_tools.sh no_local_deps  # Disable local dependencies
```

This creates `pubspec_overrides.yaml` files in the appropriate packages to ensure that local versions of packages are used instead of published versions. This is particularly useful when making changes to multiple packages that depend on each other. 