# Kimapp Monorepo

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A comprehensive Flutter development toolkit that streamlines application development with Supabase integration, code generation, and architectural patterns. This monorepo contains multiple packages and tools that work together to provide a cohesive development experience.

## 📦 Repository Structure

```
kimapp/
├── packages/               # Core packages
│   ├── kimapp/             # Main package with core utilities
│   ├── kimapp_generator/   # Code generation package
│   ├── kimapp_utils/       # Utility functions and extensions
│   └── kimapp_supabase_helper/ # Supabase integration helpers
├── pubs/                   # Additional published packages
│   ├── autoverpod/         # Auto-generated Riverpod providers
│   └── autoverpod_generator/ # Generator for autoverpod
├── mason/                  # Mason bricks for code generation
│   ├── kimapp/             # Core Kimapp brick
│   ├── kimapp_feature/     # Feature generation brick
│   ├── kimapp_simple_feature/ # Simplified feature brick
│   ├── kimapp_feature_ui/  # UI components brick
│   └── kimapp_package/     # Package template brick
├── tools/                  # Development tools and scripts
└── template_generators/    # Custom code generators
```

## 🚀 Features

### Core Packages

- **kimapp**: Core utilities, widgets, and base classes
- **kimapp_generator**: Code generation for models, repositories, and more
- **kimapp_utils**: Utility functions and extensions
- **kimapp_supabase_helper**: Helpers for Supabase integration

### Code Generation

- **Schema-First Approach**: Define database tables as Dart schemas
- **Type-Safe Models**: Generate Freezed models from schemas
- **Repository Generation**: Consistent repository pattern implementation
- **Form Generation**: Streamlined form handling with validation

### Mason Bricks

- **Feature Generation**: Quickly scaffold new features with proper architecture
- **UI Components**: Generate consistent UI components
- **Package Templates**: Create new packages with proper structure

### Development Tools

- **Melos Integration**: Monorepo management with scripts for common tasks
- **Template Generators**: Custom code generators for specific use cases

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (>=3.3.0)
- Dart SDK (>=3.3.0)
- [Melos](https://melos.invertase.dev/) for monorepo management
- [Mason CLI](https://pub.dev/packages/mason_cli) for code generation

### Setup

1. Clone the repository:

```bash
git clone https://github.com/pckimlong/kimapp.git
cd kimapp
```

2. Install Melos globally:

```bash
dart pub global activate melos
```

3. Bootstrap the project:

```bash
melos bootstrap
```

This will install all dependencies and link local packages together.

### Using Mason Bricks

1. Install Mason CLI:

```bash
dart pub global activate mason_cli
```

2. Get the bricks:

```bash
cd mason
mason get
```

3. Generate a new feature:

```bash
mason make kimapp_feature --name user_management --table users
```

## 📋 Development Workflow

### Adding a New Feature

1. Define your database schema using the schema-first approach
2. Generate the feature using Mason:

```bash
mason make kimapp_feature --name feature_name --table table_name
```

3. Implement the repository methods
4. Create providers for state management
5. Build the UI components

### Running Code Generation

```bash
melos run build_all
```

This will run build_runner in all packages that depend on it.

### Testing

```bash
melos run test
```

### Formatting and Linting

```bash
melos run format
melos run analyze
```

## 🧩 Melos Commands

Melos provides several useful commands for managing the monorepo:

- `melos bootstrap`: Set up the project
- `melos run update_deps`: Update dependencies in all packages
- `melos run format`: Format Dart code in all packages
- `melos run analyze`: Run static analysis
- `melos run build_all`: Run build_runner in all packages
- `melos run test`: Run tests in all packages
- `melos run clean`: Clean all packages
- `melos run publish_dry`: Run a dry-run of publishing all packages
- `melos run publish`: Publish all packages to pub.dev

## 📚 Core Concepts

### Schema-First Approach

Kimapp uses a schema-first methodology where database tables are defined as Dart schemas. These schemas generate type-safe models, repositories, and providers, ensuring alignment between the database and application code.

```dart
@TableStructure(
  'products',
  classPrefixName: 'Product',
  idColumn: 'ProductId:string',
  columns: [
    'name',
    'price:double',
    'description?',  // Optional field
    'category_id>Category',  // Foreign key
  ],
)
class ProductTable {}
```

### Type Safety

- Use type-safe ID classes for all ID fields
- Foreign keys must reference the appropriate ID type
- Leverage Freezed and `fast_immutable_collections` for immutable data structures

### Feature Structure

Each feature includes:
- **Schema**: Defines the database table and generates models
- **Repository**: Manages CRUD operations and data access
- **Providers**: Handles state management with Riverpod
- **Params**: Specifies request parameters for operations

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- [Riverpod](https://riverpod.dev/) for state management
- [Freezed](https://pub.dev/packages/freezed) for immutable models
- [Supabase](https://supabase.io/) for backend services
- [Mason](https://pub.dev/packages/mason) for code generation
- [Melos](https://melos.invertase.dev/) for monorepo management
