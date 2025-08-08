# Kimapp Monorepo

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
[![Flutter](https://img.shields.io/badge/Flutter->=3.27.1-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart->=3.6.0-blue.svg)](https://dart.dev/)

A comprehensive Flutter development toolkit that streamlines application development with Supabase integration, code generation, and architectural patterns. This monorepo contains multiple packages, tools, and utilities that work together to provide a cohesive development experience for building robust Flutter applications with type-safe code generation and consistent architecture patterns.

## 📦 Repository Structure

```
kimapp/
├── packages/               # Core framework packages (unpublished)
│   ├── kimapp/             # Main package with core utilities and base classes
│   ├── kimapp_generator/   # Code generation package for models and repositories
│   ├── kimapp_utils/       # Utility functions and extensions
│   ├── kimapp_supabase_helper/ # Supabase integration helpers and utilities
│   └── bootstraper/        # Bootstrap utilities for app initialization
├── pubs/                   # Published packages on pub.dev
│   ├── autoverpod/         # Auto-generated Riverpod providers with annotations
│   ├── autoverpod_generator/ # Build runner generator for autoverpod
│   └── numpad_input/       # Customizable numeric input widget
├── mason/                  # Mason bricks for code scaffolding
│   ├── kimapp/             # Core Kimapp application template
│   ├── kimapp_feature/     # Complete feature generation with architecture
│   ├── kimapp_simple_feature/ # Simplified feature scaffold
│   ├── kimapp_feature_ui/  # UI components and widgets
│   └── kimapp_package/     # Package template with proper structure
├── tools/                  # Development tools and IDE extensions
│   └── extensions/         # VS Code extensions and snippets
│       └── kimapp-snippets/ # Code snippets for Kimapp development
├── template_generators/    # Custom code generation templates
│   └── kimapp_feature/     # Feature-specific generators
├── .github/                # GitHub workflows and automation
│   ├── workflows/          # CI/CD pipelines
│   └── dependabot.yaml     # Dependency management configuration
└── .vscode/                # VS Code workspace configuration
```

## 🚀 Features

### Core Framework Packages

- **kimapp**: Core utilities, widgets, base classes, and foundational architecture components
- **kimapp_generator**: Advanced code generation for models, repositories, providers, and forms
- **kimapp_utils**: Essential utility functions, extensions, and helper classes
- **kimapp_supabase_helper**: Comprehensive Supabase integration with authentication, storage, and database helpers
- **bootstraper**: Application initialization and bootstrap utilities

### Published Packages

- **autoverpod** ([pub.dev](https://pub.dev/packages/autoverpod)): Annotations for Riverpod widgets to simplify code generation and automate widget creation
- **autoverpod_generator** ([pub.dev](https://pub.dev/packages/autoverpod_generator)): Build runner generator for autoverpod annotations
- **numpad_input** ([pub.dev](https://pub.dev/packages/numpad_input)): A customizable Flutter widget for numeric input, featuring calculator-style numpad, amount formatting, and easy integration for financial or data entry apps

### Code Generation & Architecture

- **Schema-First Approach**: Define database tables as Dart schemas with type-safe code generation
- **Type-Safe Models**: Generate Freezed models with immutable data structures from schemas
- **Repository Pattern**: Consistent repository implementation with CRUD operations
- **Form Generation**: Automated form handling with validation and state management
- **Provider Generation**: Riverpod providers with proper dependency injection

### Mason Bricks & Scaffolding

- **Application Templates**: Complete app structure with best practices
- **Feature Generation**: Quickly scaffold new features with proper architecture layers
- **UI Components**: Generate consistent UI components and widgets
- **Package Templates**: Create new packages with standardized structure
- **Simple Features**: Lightweight feature scaffolding for rapid development

### Development Tools & Extensions

- **VS Code Extensions**: Code snippets and development helpers for Kimapp
- **Template Generators**: Custom code generators for specific use cases
- **Melos Integration**: Monorepo management with automated scripts
- **CI/CD Workflows**: Automated testing, building, and publishing pipelines

## 🛠️ Getting Started

### Prerequisites

Before you begin, ensure you have the following installed on your development machine:

- **Flutter SDK** (>=3.27.1) - [Installation Guide](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (>=3.6.0) - Included with Flutter
- **Git** - For version control
- **[Melos](https://melos.invertase.dev/)** - For monorepo management
- **[Mason CLI](https://pub.dev/packages/mason_cli)** - For code generation and scaffolding
- **VS Code** or **Android Studio** - Recommended IDEs

### Quick Start

1. **Clone the repository:**

```bash
git clone https://github.com/pckimlong/kimapp.git
cd kimapp
```

2. **Install Melos globally:**

```bash
dart pub global activate melos
```

3. **Install Mason CLI globally:**

```bash
dart pub global activate mason_cli
```

4. **Bootstrap the monorepo:**

```bash
melos bootstrap
```

This command will:
- Install all dependencies across packages
- Link local packages together
- Set up the development environment

5. **Verify installation:**

```bash
melos run analyze
```

### Setting Up Mason Bricks

1. **Navigate to the mason directory:**

```bash
cd mason
```

2. **Get all Mason bricks:**

```bash
mason get
```

3. **Verify bricks are available:**

```bash
mason list
```

### Creating Your First Feature

Generate a new feature using the Kimapp feature brick:

```bash
# Navigate back to project root
cd ..

# Generate a complete feature
mason make kimapp_feature --name user_profile --table users

# Or generate a simple feature
mason make kimapp_simple_feature --name settings
```

## 📋 Development Workflow

### Project Management with Melos

Melos provides powerful commands for managing this monorepo:

```bash
# Set up the project
melos bootstrap

# Update all dependencies
melos run update_deps

# Code quality and analysis
melos run analyze           # Run static analysis
melos run format           # Format all Dart code
melos run format-check     # Check formatting without changes
melos run fix_all          # Apply automated fixes

# Building and code generation
melos run build_kimapp     # Build core kimapp packages
melos run build_all        # Run build_runner in all packages

# Testing
melos run test             # Run tests in all packages

# Maintenance
melos run clean            # Clean all packages
melos run upgrade          # Upgrade Flutter dependencies

# Publishing (for maintainers)
melos run publish_dry      # Dry run package publishing
melos run publish          # Publish packages to pub.dev
```

### Adding a New Feature

1. **Define your database schema** (if applicable):

```dart
@TableStructure(
  'products',
  classPrefixName: 'Product',
  idColumn: 'ProductId:string',
  columns: [
    'name',
    'price:double',
    'description?',        // Optional field
    'category_id>Category', // Foreign key
  ],
)
class ProductTable {}
```

2. **Generate the feature using Mason:**

```bash
mason make kimapp_feature \
  --name product_management \
  --table products \
  --description "Product catalog management"
```

3. **Implement repository methods** in the generated repository files

4. **Create Riverpod providers** for state management

5. **Build UI components** using the generated models and providers

6. **Run code generation:**

```bash
melos run build_all
```

### Working with Packages

#### Creating a New Package

```bash
# Generate a new package structure
mason make kimapp_package --name my_new_package

# Add it to pubspec.yaml workspace configuration
```

#### Adding Dependencies

1. Add dependencies to the specific package's `pubspec.yaml`
2. Run `melos bootstrap` to update the workspace
3. Import and use the dependency in your code

### VS Code Development

Install the Kimapp VS Code extension for enhanced development experience:

1. Open VS Code in the project root
2. The extension provides:
   - Code snippets for common Kimapp patterns
   - Syntax highlighting for schema definitions
   - Quick actions for code generation

## 🧩 Available Melos Commands

### Core Development Commands

| Command | Description |
|---------|-------------|
| `melos bootstrap` | Set up the project and install dependencies |
| `melos run update_deps` | Update dependencies in all packages |
| `melos run upgrade` | Upgrade Flutter dependencies |

### Code Quality Commands

| Command | Description |
|---------|-------------|
| `melos run analyze` | Run static analysis on all packages |
| `melos run format` | Format Dart code in all packages |
| `melos run format-check` | Check code formatting without applying changes |
| `melos run fix_all` | Apply automated fixes across all packages |
| `melos run lint:all` | Run comprehensive analysis (analyze + format) |

### Build Commands

| Command | Description |
|---------|-------------|
| `melos run build_kimapp` | Run build_runner in kimapp core packages |
| `melos run build_all` | Run build_runner in all packages (with dependency order) |

### Testing Commands

| Command | Description |
|---------|-------------|
| `melos run test` | Run tests in all packages that have test folders |

### Maintenance Commands

| Command | Description |
|---------|-------------|
| `melos run clean` | Clean all packages |
| `melos run verify` | Complete verification pipeline (build + analyze + test + format-check) |

### Publishing Commands (Maintainers)

| Command | Description |
|---------|-------------|
| `melos run publish_dry` | Dry run of publishing all packages |
| `melos run publish` | Publish packages to pub.dev |
| `melos run version_kimapp` | Version kimapp packages only |
| `melos run version_autoverpod` | Version autoverpod packages only |
| `melos run prerelease` | Create prerelease versions |
| `melos run changelog` | Generate changelog for all packages |

## 📚 Core Concepts & Architecture

### Schema-First Development

Kimapp uses a schema-first methodology where database tables are defined as Dart schemas. These schemas serve as the single source of truth and generate:

- **Type-safe models** with Freezed
- **Repository interfaces** with CRUD operations
- **Riverpod providers** for state management
- **Form handlers** with validation
- **API endpoints** (when using Supabase)

**Example Schema Definition:**

```dart
@TableStructure(
  'products',
  classPrefixName: 'Product',
  idColumn: 'ProductId:string',
  columns: [
    'name',                    // String field
    'price:double',           // Double field with type annotation
    'description?',           // Optional field (nullable)
    'category_id>Category',   // Foreign key relationship
    'created_at:DateTime',    // DateTime field
    'is_active:bool=true',    // Boolean with default value
  ],
)
class ProductTable {}
```

This generates:
- `Product` model with Freezed
- `ProductId` type-safe ID class
- `ProductRepository` interface
- `ProductProvider` for state management
- `ProductForm` for form handling

### Type Safety & ID Management

- **Type-Safe IDs**: Each entity uses strongly-typed ID classes (`ProductId`, `UserId`, etc.)
- **Foreign Key Safety**: Foreign keys must reference appropriate ID types
- **Immutable Data**: Leverage Freezed and `fast_immutable_collections` for immutable structures
- **Null Safety**: Full null safety support with optional field handling

### Architectural Patterns

#### Repository Pattern
```dart
abstract class IProductRepository {
  Future<Either<Failure, IList<Product>>> getProducts();
  Future<Either<Failure, Product>> getProduct(ProductId id);
  Future<Either<Failure, Product>> createProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(ProductId id);
}
```

#### Provider Pattern with Riverpod
```dart
@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<IList<Product>> build() async {
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.getProducts();
    return result.fold(
      (failure) => throw failure,
      (products) => products,
    );
  }
}
```

#### Feature Structure
Each generated feature follows a consistent structure:
```
feature_name/
├── core/           # Domain models and entities
├── providers/      # Riverpod state management
├── repositories/   # Data access layer
├── params/         # Request/response parameters
└── forms/          # Form handling and validation
```

## 💡 Examples & Usage

### Quick Start Example

Here's how to quickly create a blog post management feature:

1. **Generate the feature:**
```bash
mason make kimapp_feature --name blog_post --table blog_posts
```

2. **Define your schema:**
```dart
@TableStructure(
  'blog_posts',
  classPrefixName: 'BlogPost',
  idColumn: 'BlogPostId:string',
  columns: [
    'title',
    'content',
    'author_id>User',
    'published_at:DateTime?',
    'is_published:bool=false',
    'tags:List<String>=[]',
  ],
)
class BlogPostTable {}
```

3. **Use the generated components:**
```dart
// In your widget
class BlogPostsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blogPostsAsync = ref.watch(blogPostsProvider);
    
    return blogPostsAsync.when(
      data: (posts) => BlogPostsList(posts: posts),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

### Using Published Packages

#### NumPad Input Widget
```dart
import 'package:numpad_input/numpad_input.dart';

class PriceInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NumpadInput(
      onValueChanged: (value) {
        print('Price entered: \$${value.toStringAsFixed(2)}');
      },
      initialValue: 0.0,
      maxValue: 9999.99,
      decimalPlaces: 2,
    );
  }
}
```

#### AutoVerPod Annotations
```dart
import 'package:autoverpod/autoverpod.dart';

@AutoVerPod()
class CounterWidget extends StatelessWidget {
  final int counter;
  
  const CounterWidget({Key? key, required this.counter}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text('Counter: $counter');
  }
}

// Generates CounterWidgetProvider automatically
```

### Example Projects

Check out these example implementations:

- **Basic Feature Example**: `packages/kimapp_generator/example/`
- **AutoVerPod Usage**: `pubs/autoverpod_generator/example/`
- **NumPad Implementation**: `pubs/numpad_input/example/`

## 🔧 Troubleshooting

### Common Issues

#### Build Runner Conflicts
```bash
# If you encounter build conflicts
melos run clean
melos bootstrap
melos run build_all
```

#### Dependency Resolution Issues
```bash
# Reset dependencies
rm -rf ~/.pub-cache
melos clean
melos bootstrap
```

#### Mason Brick Not Found
```bash
# Refresh Mason bricks
cd mason
mason get
mason list  # Verify bricks are available
```

#### Code Generation Not Working
```bash
# Ensure build_runner dependencies are up to date
melos run build_kimapp
# If issues persist, try individual package builds
cd packages/kimapp_generator
dart run build_runner build --delete-conflicting-outputs
```

### Getting Help

1. **Check the Issues**: [GitHub Issues](https://github.com/pckimlong/kimapp/issues)
2. **Review Examples**: Look at the example projects in each package
3. **Check Dependencies**: Ensure you're using compatible versions
4. **Melos Debugging**: Use `melos list` to see package status

## 🤝 Contributing

We welcome contributions! Here's how to get started:

### Development Setup

1. **Fork and clone the repository**
2. **Set up the development environment:**
```bash
melos bootstrap
melos run analyze  # Ensure everything is working
```

3. **Install VS Code extensions** for better development experience

### Contribution Guidelines

1. **Create a feature branch** from `master`
2. **Follow the existing code style** and patterns
3. **Write tests** for new functionality
4. **Update documentation** when needed
5. **Run the verification pipeline:**
```bash
melos run verify  # Runs build + analyze + test + format-check
```

### Package Development

#### Adding a New Package
1. Use the package template: `mason make kimapp_package --name new_package`
2. Add it to `pubspec.yaml` workspace configuration
3. Update the main README with package information

#### Publishing Packages
Only maintainers can publish packages:
```bash
melos run publish_dry  # Test the publish process
melos run publish      # Actual publish (maintainers only)
```

### Code Standards

- **Follow Dart conventions** and linting rules
- **Use schema-first approach** for new features
- **Maintain type safety** throughout the codebase
- **Write comprehensive tests** with good coverage
- **Document public APIs** with clear examples

### Pull Request Process

1. Ensure your code passes all checks: `melos run verify`
2. Update documentation if you've changed APIs
3. Add or update tests as appropriate
4. Create a clear PR description with examples
5. Link any related issues

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

This project builds upon excellent open-source packages and tools:

- **[Riverpod](https://riverpod.dev/)** - Powerful state management for Flutter
- **[Freezed](https://pub.dev/packages/freezed)** - Code generation for immutable classes
- **[Supabase](https://supabase.io/)** - Open-source Firebase alternative
- **[Mason](https://pub.dev/packages/mason)** - Template-based code generation
- **[Melos](https://melos.invertase.dev/)** - Tool for managing Dart monorepos
- **[Fast Immutable Collections](https://pub.dev/packages/fast_immutable_collections)** - Efficient immutable collections
- **[FpDart](https://pub.dev/packages/fpdart)** - Functional programming in Dart

## 🔗 Links

- **Repository**: [https://github.com/pckimlong/kimapp](https://github.com/pckimlong/kimapp)
- **Issues**: [https://github.com/pckimlong/kimapp/issues](https://github.com/pckimlong/kimapp/issues)
- **Published Packages**:
  - [autoverpod](https://pub.dev/packages/autoverpod)
  - [autoverpod_generator](https://pub.dev/packages/autoverpod_generator) 
  - [numpad_input](https://pub.dev/packages/numpad_input)
- **License**: [MIT License](LICENSE)

---

**Made with ❤️ by [Poch Kimlong](https://github.com/pckimlong)**

*Building the future of Flutter development, one package at a time.*
