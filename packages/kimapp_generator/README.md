# KimappStateWidgetGenerator

[![pub package](https://img.shields.io/pub/v/kimapp_generator.svg)](https://pub.dev/packages/kimapp_generator)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A powerful code generator for Flutter that creates a suite of widgets for state management when used with Riverpod providers. Part of the Kimapp toolkit, this generator automatically creates boilerplate code for managing state, handling async operations, and optimizing widget rebuilds.

## Installation 📦

Add to your `pubspec.yaml`:

```yaml
dependencies:
  kimapp: ^1.0.0
  riverpod_annotation: ^2.0.0
  flutter_riverpod: ^2.0.0

dev_dependencies:
  build_runner: ^2.0.0
  kimapp_generator: ^1.0.0
  riverpod_generator: ^2.0.0
```

## Quick Start 🚀

1. Add the `@stateWidget` annotation to your Riverpod provider:

```dart
@stateWidget
@riverpod
class UserProfile extends _$UserProfile {
  @override
  Future<UserData> build() {
    return fetchUserData();
  }
}
```

2. Run the generator:

```bash
dart run build_runner build
```

3. Use the generated widgets:

```dart
UserProfileProviderScope(
  child: const UserProfileView(),
  loading: () => const LoadingSpinner(),
  error: (error, stack) => ErrorDisplay(error),
  data: (userData) => UserDataDisplay(userData),
)
```

## Generated Widgets 🎯

### 1. Provider Scope Widget (`[Name]ProviderScope`)

The root widget that manages state and provides context for child widgets.

```dart
ProductDetailProviderScope(
  productId: 123,  // Family parameter if applicable
  child: const ProductView(),
  loading: () => const LoadingSpinner(),
  error: (error, stack) => ErrorDisplay(error),
  data: (product) => ProductDisplay(product),
)
```

### 2. State Widget (`[Name]StateWidget`)

Direct state access with automatic updates.

```dart
ProductDetailStateWidget(
  builder: (context, ref, params, state, child) {
    return Text(state.toString());
  },
)
```

### 3. Select Widget (`[Name]SelectWidget`)

Optimized rebuilds with state selection.

```dart
ProductDetailSelectWidget<String>(
  selector: (state) => state.name,
  builder: (context, ref, params, name, child) {
    return Text(name);
  },
)
```

### 4. Parameter Widget (`[Name]ParamWidget`)

Access to family parameters (generated for parameterized providers).

```dart
ProductDetailParamWidget(
  builder: (context, ref, params) {
    return Text('Product ID: ${params.productId}');
  },
)
```

## Advanced Features 🔧

### AsyncValue Handling

Comprehensive async state management:

```dart
ProductDetailProviderScope(
  productId: 123,
  builder: (context, ref, asyncValue, child) {
    return asyncValue.when(
      data: (data) => Text(data),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  },
)
```

### Theme Integration

Integrate with `KimappThemeExtension` for consistent states:

```dart
Theme(
  data: ThemeData(
    extensions: [
      KimappThemeExtension(
        defaultLoadingStateWidget: (context, ref) => const LoadingSpinner(),
        defaultErrorStateWidget: (context, ref, error) => ErrorDisplay(error),
      ),
    ],
  ),
  child: YourApp(),
)
```

## Best Practices 💡

### Widget Hierarchy
- Place `ProviderScope` widgets high in the widget tree
- Use `StateWidget` for direct state access
- Use `SelectWidget` for optimized rebuilds

### State Selection
- Keep selectors simple and focused
- Use for frequently changing state
- Consider caching complex selections

### Error Handling
- Provide custom error widgets when needed
- Use theme-based error widgets for consistency
- Handle errors appropriately for your use case

### Performance
- Use `SelectWidget` for large state objects
- Avoid unnecessary widget rebuilds
- Keep builder functions efficient

## Examples 📚

### Basic Provider

```dart
@stateWidget
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}
```

### Family Provider

```dart
@stateWidget
@riverpod
class ProductDetail extends _$ProductDetail {
  @override
  Future<Product> build(String productId) {
    return repository.fetchProduct(productId);
  }
}
```

### Using Generated Widgets

```dart
class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductDetailProviderScope(
      productId: "123",
      child: Column(
        children: [
          // Direct state access
          ProductDetailStateWidget(
            builder: (context, ref, params, product, _) {
              return Text(product.name);
            },
          ),
          // Optimized rebuild
          ProductDetailSelectWidget<double>(
            selector: (product) => product.price,
            builder: (context, ref, params, price, _) {
              return Text('\$$price');
            },
          ),
        ],
      ),
    );
  }
}
```

## Limitations ⚠️

1. Must be used with Riverpod providers
2. Requires build_runner for code generation
3. Family parameters must be properly typed

## Contributing 🤝

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting pull requests.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## See Also 🔗

- [Kimapp Package](https://pub.dev/packages/kimapp)
- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter Widgets Documentation](https://api.flutter.dev/flutter/widgets/widgets-library.html)
