# Kimapp

[![pub package](https://img.shields.io/pub/v/kimapp.svg)](https://pub.dev/packages/kimapp)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Kimapp is a powerful Flutter toolkit that streamlines application development by providing a comprehensive set of utilities, code generators, and architectural patterns. It integrates seamlessly with popular packages like Riverpod, Supabase, and Freezed to reduce boilerplate and enforce consistent development practices.

## Features

### 🏗️ Code Generation
- **Table Structure Generator**: Type-safe database schema definitions
- **Model Generator**: Automated Freezed models with Supabase integration
- **Form Generator**: Streamlined form handling with state management
- **Repository Generator**: Consistent repository pattern implementation

### 📦 State Management
- **Riverpod Extensions**: Enhanced provider utilities
  - Pagination helpers
  - Offline persistence
  - Automatic cache invalidation
  - Debounce utilities
- **Provider Status**: Standardized async state handling

### 🔧 Core Utilities
- **Cache Manager**: Flexible caching strategies
- **Failure Handling**: Comprehensive error management system
- **Type Extensions**: Utility extensions for Either and Option types
- **Supabase Helpers**: Simplified database operations

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  kimapp: ^1.0.0
  freezed_annotation: ^2.2.0
  fast_immutable_collections: ^9.1.5
  fpdart: ^1.1.0
  flutter_hooks: ^0.20.1
  hooks_riverpod: ^2.3.10
  supabase_flutter: ^1.0.0  # Optional - for Supabase integration

dev_dependencies:
  build_runner: ^2.3.0
  freezed: ^2.3.0
  kimapp_generator: ^1.0.0
```

## Quick Start

### 1. Initialize Kimapp

```dart
void main() async {
  await Kimapp.initialize(
    debugMode: true,
    customFailureMessage: CustomFailureMessage(),
    logger: KimappLogger(),
  );
  
  runApp(ProviderScope(child: MyApp()));
}
```

### 2. Define Database Schema

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

### 3. Create Data Model

```dart
@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  @TableModel("products")
  factory ProductModel({
    @JsonKey(name: ProductTable.id) required String id,
    @JsonKey(name: ProductTable.name) required String name,
    @JsonKey(name: ProductTable.price) required double price,
    @JsonKey(name: ProductTable.categoryId) required String categoryId,
    CategoryModel? category,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => 
      _$ProductModelFromJson(json);
}
```

### 4. Implement Repository

```dart
@riverpod
class ProductRepository extends _$ProductRepository {
  @override
  Future<List<ProductModel>> build() async {
    return supabase
        .from(ProductModel.table.tableName)
        .select(ProductModel.table.selectStatement)
        .execute()
        .then((response) => response.data
            .map((json) => ProductModel.fromJson(json))
            .toList());
  }
}
```

## Advanced Usage

### Pagination

```dart
@riverpod
class PaginatedProducts extends _$PaginatedProducts 
    with PaginatedMixin<ProductModel> {
  
  @override
  Future<PaginatedItem<ProductModel>> build({int limit = 20}) async {
    return fetchPage(
      offset: 0,
      limit: limit,
      fetcher: (offset, limit) => // Fetch implementation
    );
  }
}
```

### Form Handling

```dart
@kimappForm
class ProductForm with _$ProductForm {
  factory ProductForm({
    @FormField() required String name,
    @FormField(validator: validatePrice) required double price,
  }) = _ProductForm;
}
```

## Best Practices

1. **Schema Definition**
   - Use `@TableStructure` for all database tables
   - Define clear column types and relationships
   - Generate models using `@TableModel`

2. **State Management**
   - Leverage Riverpod providers for state
   - Use `PaginatedMixin` for list pagination
   - Implement proper error handling with `Failure` class

3. **Form Handling**
   - Use `@kimappForm` for consistent form management
   - Implement validation in form classes
   - Leverage generated form widgets

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
