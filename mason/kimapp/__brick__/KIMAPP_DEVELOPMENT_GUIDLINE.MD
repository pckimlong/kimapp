# Kimapp Development Guide for Flutter with Supabase

## Overview
This guide provides a comprehensive reference for developing Flutter applications using the Kimapp architecture with a Supabase backend. Kimapp emphasizes a schema-first, type-safe approach to generate models, repositories, and providers, ensuring consistency and maintainability. This document covers project setup, feature generation, schema design, repository implementation, and best practices.

The current date is March 01, 2025, and all examples are up-to-date with the latest Kimapp conventions.

---

## Core Concepts

### Schema-First Approach
Kimapp uses a schema-first methodology where database tables are defined as Dart schemas. These schemas generate type-safe models, repositories, and providers, ensuring alignment between the database and application code.

### Type Safety
- Use type-safe ID classes (e.g., `UserId`, `BookId`) for all ID fields instead of primitive types like `int` or `String`.
- Foreign keys must reference the appropriate ID type (e.g., `Field<UserId>('owner_id')`).
- Leverage Freezed and `fast_immutable_collections` for immutable, strongly-typed data structures.

### Feature Structure
Each feature includes:
- **Schema**: Defines the database table and generates models.
- **Repository**: Manages CRUD operations and data access.
- **Providers**: Handles state management with Riverpod.
- **Params**: Specifies request parameters for operations.

---

## Project Setup and Scaffolding

### Project Initialization
To create a new Kimapp Flutter project:
```bash
mason make kimapp
```
- Prompts:
  - `project_name`: Snake_case name (used in imports and `pubspec.yaml`).
  - `sentry_dsn`: Optional Sentry DSN for error tracking.
- This generates a scaffold project pre-integrated with Supabase.

### Project Structure
```
lib/
├── gen/                    # Generated assets
│   ├── assets.gen.dart
│   └── gen.dart
├── src/
│   ├── core/               # Utilities and core functionality
│   │   ├── account/        # Account management
│   │   ├── app/            # App configuration
│   │   ├── cache_manager/  # Caching
│   │   ├── device/         # Device info
│   │   ├── errors/         # Error handling
│   │   ├── file/           # File operations
│   │   └── helpers/        # Utility functions
│   ├── features/           # Feature modules
│   │   ├── auth/           # Authentication feature
│   │   │   ├── core/
│   │   │   ├── params/
│   │   │   ├── providers/
│   │   │   ├── repositories/
│   │   │   └── auth.dart
│   │   └── [feature_name]/ # Other features
│   │       ├── params/     # Request parameters
│   │       ├── providers/  # State management
│   │       ├── i_[feature]_repo.dart # Repository interface
│   │       └── [feature]_schema.dart # Schema definition
│   └── presentation/       # Centralized UI layer
│       ├── app/            # App-wide UI config
│       ├── modules/        # Feature-specific UI
│       │   ├── auth/
│       │   ├── splash/
│       │   └── [feature]/
│       ├── router/         # App routing
│       ├── startup/        # Initialization
│       │   └── tasks/      # Startup tasks
│       └── widgets/        # Reusable UI components
├── config.dart             # Configuration
├── main.dart               # Main entry point
├── main_dev.dart           # Dev entry point
└── main_stage.dart         # Staging entry point
```

### Feature Generation
Generate new features using Mason CLI:
```bash
mason make kimapp_simple_feature --name feature_name --id_data_type int --generate_ui false
```
- Prompts:
  - `name`: Singular feature name (e.g., `book`).
  - `id_data_type`: ID type (`int` or `String`).
  - `generate_ui`: Include UI components (default: `false`).
- **Important**: Never create feature files manually to ensure consistency and proper integration.

---

## Schema System

### Core Setup
- Use the `kimapp_generator` package:
  ```dart
  import 'package:kimapp/kimapp.dart';
  ```
- Annotate schema classes with `@Schema()` and extend `KimappSchema`.
- Define fields and models within the schema.

### Schema Definition Example
```dart
@Schema(tableName: 'books', className: 'Book', baseModelName: 'BookModel')
class BookSchema extends KimappSchema {
  final id = Field.id<int>('id').generateAs('BookId');
  final ownerId = Field<UserId>('owner_id');
  final title = Field<String>('title');
  final createdAt = Field<DateTime>('created_at');

  @override
  List<Model> get models => [
    Model('BookLiteModel')
      ..table()
      ..addFields({'id': id, 'title': title}),
    Model('BookDetailModel')
      ..table()
      ..inheritAllFromBase(),
    Model('BookCreateParam')
      ..addFields({'ownerId': ownerId, 'title': title}),
    Model('BookUpdateParam')
      ..addFields({'title': Field<String?>('title')}),
  ];
}
```

### Field Types
- **Basic Fields**: `Field<String>('name')`, `Field<int?>('age')`.
- **ID Fields**: `Field.id<int>('id').generateAs('BookId')` (define only in the owning schema; reference elsewhere with `Field<BookId>('book_id')`).
- **Join Fields**:
  ```dart
  final author = Field.join<UserModel?>()
    .withForeignKey('author_id')
    .withCandidateKey('id');
  ```
- **List Fields**: Use `Field<IList<T>>('tags')` for immutable collections.

### Generated Files
For a schema file (e.g., `book_schema.dart`), the generator creates:
- `book_schema.schema.dart`: Freezed-annotated classes.
- `book_schema.schema.freezed.dart`: Immutable implementation.
- `book_schema.schema.g.dart`: Serialization logic.

### Code Generation
```bash
dart run build_runner build  # One-time build
dart run build_runner watch  # Watch mode
```

---

## Feature Development Workflow

### Step 1: Generate Feature Scaffold
```bash
mason make kimapp_simple_feature --name book --id_data_type int --generate_ui false
```

### Step 2: Define Schema
Edit `lib/src/features/book/book_schema.dart` to specify fields, relationships, and models (see example above).

### Step 3: Define List Parameters
Update `lib/src/features/book/params/book_list_param.dart`:
```dart
@freezed
class BookListParam with _$BookListParam {
  const factory BookListParam({
    UserId? ownerId,
    String? titleSearch,
  }) = _BookListParam;
}
```

### Step 4: Customize Repository
Enhance `lib/src/features/book/repositories/book_repository.dart`:
```dart
@override
Future<Either<Failure, IList<BookModel>>> findPagination({
  required int limit,
  required int offset,
  required BookListParam param,
}) async {
  return await errorHandler(() async {
    var query = _ref.supabaseClient
        .from(BookModel.table.tableName)
        .select(BookModel.table.selectStatement);

    if (param.ownerId != null) {
      query = query.eq(BookTable.ownerId, param.ownerId!.value);
    }
    if (param.titleSearch != null && param.titleSearch!.isNotEmpty) {
      query = query.ilike(BookTable.title, '%${param.titleSearch}%');
    }

    return await query
        .limit(limit)
        .range(offset, offset + limit)
        .withConverter((data) => right(IList.fromJson(
              data,
              (json) => BookModel.fromJson(json as Map<String, dynamic>),
            )));
  });
}
```

### Step 5: Adjust Providers
Customize `lib/src/features/book/providers/book_provider.dart` as needed for state management.

### Step 6: Generate Code
```bash
dart run build_runner build
```

### Step 7: Build UI (Optional)
If `generate_ui` was `true`, customize generated UI in `lib/src/presentation/modules/book/`. Otherwise, create UI manually and update the router in `lib/src/presentation/router/`.

---

## Best Practices

### Schema Design
- **Naming**: Use snake_case for database fields, camelCase for Dart properties.
- **Models**:
  - `LiteModel`: Essential fields for list views.
  - `DetailModel`: All fields for detailed views.
  - `CreateParam`: Required fields for creation.
  - `UpdateParam`: Optional fields for updates.
- **Relationships**: Use join fields for one-to-one or one-to-many relationships; create join table schemas for many-to-many.

### Repository Implementation
- Use `errorHandler` for consistent error handling.
- Build queries dynamically based on parameters.
- Leverage generated table constants (e.g., `BookModel.table.tableName`).

### Provider Design
- Use Riverpod for dependency injection and state management.
- Implement caching for frequently accessed data.

### Immutability
- Use `IList`, `IMap`, and `ISet` from `fast_immutable_collections` for models and state.
- Use mutable `List` only for widget constructors or performance-critical sections.

---

## Troubleshooting

### Code Generation Issues
- Check schema syntax and imports.
- Run `dart run build_runner clean` then rebuild.

### Type Safety Errors
- Verify ID fields use correct type-safe classes.
- Ensure nullable fields are marked with `?`.

### Supabase Integration
- Use generated table constants and model methods (e.g., `fromJson`) for seamless integration.

---

## Advanced Features

### Many-to-Many Relationships
Create a join table schema:
```dart
@Schema(tableName: 'book_genres')
class BookGenreSchema extends KimappSchema {
  final bookId = Field<BookId>('book_id');
  final genreId = Field<GenreId>('genre_id');
}
```

### Pagination
Leverage repository pagination support:
```dart
query.limit(limit).range(offset, offset + limit);
```

---

This unified guide provides everything needed to develop features in a Kimapp Flutter project with Supabase. Always start with Mason for consistency, define schemas carefully, and follow type safety and immutability principles for a robust application.