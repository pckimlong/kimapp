# Kimapp

Kimapp is a comprehensive Dart/Flutter package designed to streamline Flutter application development. It provides a set of utilities, generators, and abstractions to reduce boilerplate code and establish consistent patterns for common development tasks such as state management, form handling, and database operations.

## Features

- **Riverpod Helpers**: Extended functionality for Riverpod, including utilities for pagination and state management.
- **Table Structure and Model Generators**: Automated creation of Dart classes for database tables and models, with Supabase integration.
- **Form Generator**: Automated generation of form-related widgets and state management code.
- **Cache Manager**: Abstract class for implementing various caching strategies.
- **Failure Handling**: Comprehensive system for managing and representing errors and failures.
- **Extensions**: Utility extensions for Either and Option types from the fpdart package.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  kimapp: ^1.0.0  # Replace with the latest version
  freezed_annotation: ^2.2.0
  fast_immutable_collections: ^9.1.5
  fpdart: ^1.1.0
  flutter_hooks: ^0.20.1
  hooks_riverpod: ^2.3.10
  supabase_flutter: ^1.0.0  # If using Supabase

dev_dependencies:
  build_runner: ^2.3.0
  freezed: ^2.3.0
  kimapp_generator: ^1.0.0  # Replace with the latest version
```

Then run:

```bash
flutter pub get
```

## Getting Started

Before using Kimapp, you need to initialize it. This is typically done in your `main.dart` file:

```dart
import 'package:kimapp/kimapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Kimapp.initialize(
    debugMode: context.env.isDevelop,
    customFailureMessage: CustomFailureMessage(),
    logger: (type, message, [title, stackTrace, errorObject]) {
      switch (type) {
        case LoggerType.debug:
          log.d(message);
        case LoggerType.info:
          log.i(message);
        case LoggerType.warning:
          log.w(message);
        case LoggerType.error:
          log.e(message, error: errorObject, stackTrace: stackTrace);
      }
    },
  );

  runApp(MyApp());
}
```

This initialization is necessary to use Kimapp's failure handling and logging features.

## Usage

### Table Structure Generator

The Table Structure Generator creates Dart classes representing database tables. It also generates an Identity class for the table's ID column.

```dart
import 'package:kimapp/kimapp.dart';

@TableStructure(
  'audits',
  classPrefixName: 'Audit',
  idColumn: 'AuditId:int',
  columns: [
    'id',
    'created_at',
    'edited_at',
    'product_id',
    'warehouse_id',
    'status',
    'note',
    'stock_qty',
    'actual_qty',
    'warehouse_stocks',
  ],
)
class AuditTable {}

// Usage:
import 'audit_objects.table.dart';

// Access table name
print(AuditTable.table);  // 'audits'

// Access column names
print(AuditTable.id);  // 'id'
print(AuditTable.createdAt);  // 'created_at'

// Use the generated ID class
final auditId = AuditId.fromValue(1);
print(auditId.value);  // 1
```

### Table Model Generator

The Table Model Generator is particularly useful when working with Supabase. It generates a `table` constant that can be used with Supabase's query builder.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  @TableModel("products")
  factory ProductModel({
    @JsonKey(name: ProductTable.id) required String id,
    @JsonKey(name: ProductTable.name) required String name,
    @JsonKey(name: ProductTable.price) required double price,
    @JsonKey(name: ProductTable.categoryId) required String categoryId,
    @JoinedColumn(foreignKey: 'category_id')
    CategoryModel? category,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  static const TableBuilder table = _tableProductModel;
}

// Usage with Supabase:
final supabase = Supabase.instance.client;

final response = await supabase
    .from(ProductModel.table.tableName)
    .select(ProductModel.table.selectStatement)
    .execute();

final products = response.data
    .map((json) => ProductModel.fromJson(json))
    .toList();
```

### Form Generator

The Form Generator automates the creation of form-related widgets and state management code.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'form_example.freezed.dart';

@freezed
class FormExampleState with _$FormExampleState, ProviderStatusClassMixin<FormExampleState, Result> {
  const FormExampleState._();

  const factory FormExampleState({
    @Default('') String text,
    @Default(0) int number,
    @Default(ProviderStatus.initial()) ProviderStatus<Result> status,
  }) = _FormExampleState;

  @override
  FormExampleState updateStatus(ProviderStatus<Result> newStatus) {
    return copyWith(status: newStatus);
  }

  DatabaseParam toParam() {
    // Perform validation before converting to param
    return const DatabaseParam();
  }
}

@kimappForm
@riverpod
class FormExample extends _$FormExample with _$FormExampleForm {
  @override
  FormExampleState build() => const FormExampleState();

  Future<ProviderStatus<Result>> call() async {
    return await perform<Result>(
      (state) async {
        final param = state.toParam();
        final result = await ref.read(someRepositoryProvider).someMethod(param);
        return result.getOrThrow();
      },
      onSuccess: (success) {
        // Called when successful
        // This usually refreshes provider list
      },
    );
  }

  void updateState(FormExampleState Function(FormExampleState oldState) newState) {
    state = newState(state).copyWith(status: state.status);
  }
}
```

### Pagination

Kimapp provides utilities to easily implement pagination:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'book_list_pagination_provider.g.dart';

const _pageBooksLimit = 20;

@riverpod
FutureOr<IList<BookModel>> bookListPagination(
  BookListPaginationRef ref, {
  required int page,
  required BookListPaginationParam param,
}) async {
  ref.cacheTime(const Duration(minutes: 5));
  const limit = _pageBooksLimit;
  final offset = page * limit;
  
  return ref
    .watch(bookRepositoryProvider)
    .fetchBooks(limit: limit, offset: offset, param: param)
    .then((value) => value.getOrThrow());
}

@riverpod
PaginatedItem<BookModel>? bookPaginatedAtIndex(
  BookPaginatedAtIndexRef ref,
  int index, {
  required BookListPaginationParam param,
}) {
  const limit = _pageBooksLimit;
  final page = index ~/ limit;
  final pageItems = ref.watch(bookListPaginationProvider(page: page, param: param));
  final hasNextPage = ref.exists(bookListPaginationProvider(page: page + 1, param: param));
  
  return PaginatedItem.build(
    pageItems: pageItems,
    limit: limit,
    index: index,
    showLoadingInAllItem: hasNextPage,
  );
}
```

### Riverpod Helpers

Kimapp provides several extensions and utilities to enhance Riverpod's functionality:

#### Cache Time

```dart
@riverpod
Future<List<Product>> fetchProducts(FetchProductsRef ref) async {
  ref.cacheTime(const Duration(minutes: 5));
  return await apiClient.getProducts();
}
```

#### Debouncing

```dart
@riverpod
Future<List<SearchResult>> search(SearchRef ref, String query) async {
  return ref.debounceObject(
    () => apiClient.search(query),
    duration: const Duration(milliseconds: 300),
  );
}
```

#### Auto Invalidation

```dart
@riverpod
Future<UserProfile> userProfile(UserProfileRef ref, String userId) async {
  ref.autoInvalidateSelf(const Duration(hours: 1));
  return await apiClient.getUserProfile(userId);
}
```

#### Provider Status Listeners

```dart
ref.listenProviderStatus<Result>(someProvider, (previous, next) {
  if (next.isSuccess) {
    // Handle success
  } else if (next.isFailure) {
    // Handle failure
  }
});

ref.listenProviderStatusClass<SomeState, Result>(someStateProvider, (previous, next) {
  if (next.status.isSuccess) {
    // Handle success
  } else if (next.status.isFailure) {
    // Handle failure
  }
});
```

## Best Practices

1. **Consistent Table Structures**: Always use `@TableStructure` for defining database schemas.
2. **Leverage Supabase Integration**: Use `@TableModel` for Supabase database operations.
3. **Efficient Pagination**: Implement pagination using the `PaginatedItem` class.
4. **State Management with ProviderStatus**: Wrap your state in `ProviderStatus` for consistent async operation handling.
5. **Streamlined Form Handling**: Use `@kimappForm` annotation with `ProviderStatusClassMixin` for automated form state management.
6. **Optimize Provider Performance**: Utilize Kimapp's Riverpod helpers (`cacheTime`, `debounceObject`, `autoInvalidateSelf`) to optimize provider performance.
7. **Consistent Error Handling**: Use the `Failure` class for consistent error handling across your application.
