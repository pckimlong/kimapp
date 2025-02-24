// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_widget_example.dart';

// **************************************************************************
// KimappStateWidgetGenerator
// **************************************************************************

/// A widget that provides a scoped access point for ProductDetailProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed
///
/// Async State Handlers (only used when [builder] is not provided):
/// * [loading] - Custom widget for loading states
/// * [error] - Custom widget for error states with error details
/// * [data] - Custom widget for when data is available
///
/// Default State Handling:
/// Uses [KimappThemeExtension] for consistent loading/error states:
/// ```dart
/// Theme(
///   data: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const LoadingSpinner(),
///         defaultErrorStateWidget: (context, ref, error) => ErrorDisplay(error),
///       ),
///     ],
///   ),
///   child: YourApp(),
/// )
/// ```
///
/// Simple Usage:
/// ```dart
/// ProductDetailProviderScope(
///   productId: intValue,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// ProductDetailProviderScope(
///   productId: intValue,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// ProductDetailProviderScope(
///   productId: intValue,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [ProductDetailStateWidget] - For direct state access
/// * [ProductDetailSelectWidget] - For optimized state selection
/// * [ProductDetailParamWidget] - For family parameter access
class ProductDetailProviderScope extends StatelessWidget {
  const ProductDetailProviderScope({
    super.key,
    required this.productId,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  }) : assert(
          builder == null || (loading == null && error == null && data == null),
          'When builder is provided, loading, error, and data callbacks are ignored. '
          'Remove these callbacks or remove the builder to avoid confusion.',
        );

  final int productId;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(String data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<String> asyncValue,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _ProductDetailParamsProvider(
        productId: productId,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(productDetailProvider(productId));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            final themeExtension =
                Theme.of(context).extension<KimappThemeExtension>();
            return state.when(
              data: (data) {
                final result = this.data?.call(data) ?? child;
                if (result == null) {
                  Kimapp.instance.log(LoggerType.warning,
                      message:
                          'No child provided for ProductDetailProviderScope. Empty SizedBox will be returned.');
                  return const SizedBox.shrink();
                }
                return result;
              },
              error: (error, stack) =>
                  this.error?.call(error, stack) ??
                  themeExtension?.defaultErrorStateWidget
                      ?.call(context, ref, error) ??
                  const SizedBox.shrink(),
              loading: () =>
                  loading?.call() ??
                  themeExtension?.defaultLoadingStateWidget
                      ?.call(context, ref) ??
                  const SizedBox.shrink(),
            );
          },
        ));
  }
}

bool _debugCheckHasProductDetailProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! ProductDetailProviderScope &&
        context.findAncestorWidgetOfExactType<ProductDetailProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No ProductDetailProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a ProductDetailProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for ProductDetail widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _ProductDetailParamsProvider extends InheritedWidget {
  const _ProductDetailParamsProvider({
    required this.productId,
    required super.child,
  });

  final int productId;

  static _ProductDetailParamsProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ProductDetailParamsProvider>();
  }

  @override
  bool updateShouldNotify(_ProductDetailParamsProvider oldWidget) {
    return productId != oldWidget.productId;
  }
}

/// A widget that provides access to the family parameters of ProductDetailProvider.
///
/// This widget requires a [ProductDetailProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [ProductDetailProviderScope] - The required provider wrapper widget
/// * [ProductDetailStateWidget] - For state access
class ProductDetailParamWidget extends ConsumerWidget {
  const ProductDetailParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(
      BuildContext context, WidgetRef ref, ({int productId}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasProductDetailProviderScope(context);

    final params = _ProductDetailParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (productId: params.productId),
    );
  }
}

/// A widget that provides direct access to the ProductDetailProvider state.
///
/// This widget requires a [ProductDetailProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// ProductDetailStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class ProductDetailStateWidget extends ConsumerWidget {
  const ProductDetailStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int productId}) params, String state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasProductDetailProviderScope(context);

    final params = _ProductDetailParamsProvider.of(context);
    final state =
        ref.watch(productDetailProvider(params!.productId)).requireValue;
    return builder(
      context,
      ref,
      (productId: params.productId),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from ProductDetailProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// ProductDetailSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [ProductDetailProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// ProductDetailSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [ProductDetailProviderScope] - The required provider wrapper widget
/// * [ProductDetailStateWidget] - For direct state access
class ProductDetailSelectWidget<Selected> extends ConsumerWidget {
  const ProductDetailSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(String state) selector;
  final Widget Function(BuildContext context, WidgetRef ref,
      ({int productId}) params, Selected value, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasProductDetailProviderScope(context);

    final params = _ProductDetailParamsProvider.of(context);
    final selected = ref.watch(
      productDetailProvider(params!.productId)
          .select((value) => selector(value.requireValue)),
    );

    return builder(
      context,
      ref,
      (productId: params.productId),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for PrimativeClassProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed

///
/// Simple Usage:
/// ```dart
/// PrimativeClassProviderScope(
///
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeClassProviderScope(
///
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeClassProviderScope(
///
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeClassStateWidget] - For direct state access
/// * [PrimativeClassSelectWidget] - For optimized state selection
/// * [PrimativeClassParamWidget] - For family parameter access
class PrimativeClassProviderScope extends StatelessWidget {
  const PrimativeClassProviderScope({
    super.key,
    this.child,
    this.builder,
  });

  final Widget? child;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int state,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final state = ref.watch(primativeClassProvider);

        if (builder != null) {
          return builder!(context, ref, state, child);
        }

        return child ?? const SizedBox.shrink();
      },
    );
  }
}

/// A widget that provides direct access to the PrimativeClassProvider state.
///
/// This widget requires a [PrimativeClassProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling

///
/// Example usage:
/// ```dart
/// PrimativeClassStateWidget(
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeClassStateWidget extends ConsumerWidget {
  const PrimativeClassStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
      BuildContext context, WidgetRef ref, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(primativeClassProvider);
    return builder(context, ref, state, child);
  }
}

/// A widget that provides optimized access to selected state data from PrimativeClassProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeClassSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeClassProviderScope] ancestor.

///
/// Example usage:
/// ```dart
/// PrimativeClassSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeClassProviderScope] - The required provider wrapper widget
/// * [PrimativeClassStateWidget] - For direct state access
class PrimativeClassSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeClassSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(
          BuildContext context, WidgetRef ref, Selected value, Widget? child)
      builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      primativeClassProvider.select((value) => selector(value)),
    );

    return builder(context, ref, selected, child);
  }
}

/// A widget that provides a scoped access point for StringFutureProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed
///
/// Async State Handlers (only used when [builder] is not provided):
/// * [loading] - Custom widget for loading states
/// * [error] - Custom widget for error states with error details
/// * [data] - Custom widget for when data is available
///
/// Default State Handling:
/// Uses [KimappThemeExtension] for consistent loading/error states:
/// ```dart
/// Theme(
///   data: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const LoadingSpinner(),
///         defaultErrorStateWidget: (context, ref, error) => ErrorDisplay(error),
///       ),
///     ],
///   ),
///   child: YourApp(),
/// )
/// ```
///
/// Simple Usage:
/// ```dart
/// StringFutureProviderScope(
///   family: stringValue,
/// second: stringValue,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// StringFutureProviderScope(
///   family: stringValue,
/// second: stringValue,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// StringFutureProviderScope(
///   family: stringValue,
/// second: stringValue,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [StringFutureStateWidget] - For direct state access
/// * [StringFutureSelectWidget] - For optimized state selection
/// * [StringFutureParamWidget] - For family parameter access
class StringFutureProviderScope extends StatelessWidget {
  const StringFutureProviderScope({
    super.key,
    required this.family,
    required this.second,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  }) : assert(
          builder == null || (loading == null && error == null && data == null),
          'When builder is provided, loading, error, and data callbacks are ignored. '
          'Remove these callbacks or remove the builder to avoid confusion.',
        );

  final String family;
  final String second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(String data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<String> asyncValue,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _StringFutureParamsProvider(
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state =
                ref.watch(stringFutureProvider(family: family, second: second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            final themeExtension =
                Theme.of(context).extension<KimappThemeExtension>();
            return state.when(
              data: (data) {
                final result = this.data?.call(data) ?? child;
                if (result == null) {
                  Kimapp.instance.log(LoggerType.warning,
                      message:
                          'No child provided for StringFutureProviderScope. Empty SizedBox will be returned.');
                  return const SizedBox.shrink();
                }
                return result;
              },
              error: (error, stack) =>
                  this.error?.call(error, stack) ??
                  themeExtension?.defaultErrorStateWidget
                      ?.call(context, ref, error) ??
                  const SizedBox.shrink(),
              loading: () =>
                  loading?.call() ??
                  themeExtension?.defaultLoadingStateWidget
                      ?.call(context, ref) ??
                  const SizedBox.shrink(),
            );
          },
        ));
  }
}

bool _debugCheckHasStringFutureProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! StringFutureProviderScope &&
        context.findAncestorWidgetOfExactType<StringFutureProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No StringFutureProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a StringFutureProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for StringFuture widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _StringFutureParamsProvider extends InheritedWidget {
  const _StringFutureParamsProvider({
    required this.family,
    required this.second,
    required super.child,
  });

  final String family;
  final String second;

  static _StringFutureParamsProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_StringFutureParamsProvider>();
  }

  @override
  bool updateShouldNotify(_StringFutureParamsProvider oldWidget) {
    return family != oldWidget.family || second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of StringFutureProvider.
///
/// This widget requires a [StringFutureProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [StringFutureProviderScope] - The required provider wrapper widget
/// * [StringFutureStateWidget] - For state access
class StringFutureParamWidget extends ConsumerWidget {
  const StringFutureParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({String family, String second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasStringFutureProviderScope(context);

    final params = _StringFutureParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the StringFutureProvider state.
///
/// This widget requires a [StringFutureProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// StringFutureStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class StringFutureStateWidget extends ConsumerWidget {
  const StringFutureStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
      BuildContext context,
      WidgetRef ref,
      ({String family, String second}) params,
      String state,
      Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasStringFutureProviderScope(context);

    final params = _StringFutureParamsProvider.of(context);
    final state = ref
        .watch(stringFutureProvider(
            family: params!.family, second: params!.second))
        .requireValue;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from StringFutureProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// StringFutureSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [StringFutureProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// StringFutureSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [StringFutureProviderScope] - The required provider wrapper widget
/// * [StringFutureStateWidget] - For direct state access
class StringFutureSelectWidget<Selected> extends ConsumerWidget {
  const StringFutureSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(String state) selector;
  final Widget Function(
      BuildContext context,
      WidgetRef ref,
      ({String family, String second}) params,
      Selected value,
      Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasStringFutureProviderScope(context);

    final params = _StringFutureParamsProvider.of(context);
    final selected = ref.watch(
      stringFutureProvider(family: params!.family, second: params!.second)
          .select((value) => selector(value.requireValue)),
    );

    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for StringFutureOptionalProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed
///
/// Async State Handlers (only used when [builder] is not provided):
/// * [loading] - Custom widget for loading states
/// * [error] - Custom widget for error states with error details
/// * [data] - Custom widget for when data is available
///
/// Default State Handling:
/// Uses [KimappThemeExtension] for consistent loading/error states:
/// ```dart
/// Theme(
///   data: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const LoadingSpinner(),
///         defaultErrorStateWidget: (context, ref, error) => ErrorDisplay(error),
///       ),
///     ],
///   ),
///   child: YourApp(),
/// )
/// ```
///
/// Simple Usage:
/// ```dart
/// StringFutureOptionalProviderScope(
///   a: intValue,
/// family: stringValue,
/// second: string?Value,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// StringFutureOptionalProviderScope(
///   a: intValue,
/// family: stringValue,
/// second: string?Value,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// StringFutureOptionalProviderScope(
///   a: intValue,
/// family: stringValue,
/// second: string?Value,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [StringFutureOptionalStateWidget] - For direct state access
/// * [StringFutureOptionalSelectWidget] - For optimized state selection
/// * [StringFutureOptionalParamWidget] - For family parameter access
class StringFutureOptionalProviderScope extends StatelessWidget {
  const StringFutureOptionalProviderScope({
    super.key,
    required this.a,
    required this.family,
    this.second,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  }) : assert(
          builder == null || (loading == null && error == null && data == null),
          'When builder is provided, loading, error, and data callbacks are ignored. '
          'Remove these callbacks or remove the builder to avoid confusion.',
        );

  final int a;
  final String family;
  final String? second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(String data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<String> asyncValue,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _StringFutureOptionalParamsProvider(
        a: a,
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(stringFutureOptionalProvider(a,
                family: family, second: second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            final themeExtension =
                Theme.of(context).extension<KimappThemeExtension>();
            return state.when(
              data: (data) {
                final result = this.data?.call(data) ?? child;
                if (result == null) {
                  Kimapp.instance.log(LoggerType.warning,
                      message:
                          'No child provided for StringFutureOptionalProviderScope. Empty SizedBox will be returned.');
                  return const SizedBox.shrink();
                }
                return result;
              },
              error: (error, stack) =>
                  this.error?.call(error, stack) ??
                  themeExtension?.defaultErrorStateWidget
                      ?.call(context, ref, error) ??
                  const SizedBox.shrink(),
              loading: () =>
                  loading?.call() ??
                  themeExtension?.defaultLoadingStateWidget
                      ?.call(context, ref) ??
                  const SizedBox.shrink(),
            );
          },
        ));
  }
}

bool _debugCheckHasStringFutureOptionalProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! StringFutureOptionalProviderScope &&
        context.findAncestorWidgetOfExactType<
                StringFutureOptionalProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No StringFutureOptionalProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a StringFutureOptionalProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for StringFutureOptional widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _StringFutureOptionalParamsProvider extends InheritedWidget {
  const _StringFutureOptionalParamsProvider({
    required this.a,
    required this.family,
    required this.second,
    required super.child,
  });

  final int a;
  final String family;
  final String? second;

  static _StringFutureOptionalParamsProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        _StringFutureOptionalParamsProvider>();
  }

  @override
  bool updateShouldNotify(_StringFutureOptionalParamsProvider oldWidget) {
    return a != oldWidget.a ||
        family != oldWidget.family ||
        second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of StringFutureOptionalProvider.
///
/// This widget requires a [StringFutureOptionalProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [StringFutureOptionalProviderScope] - The required provider wrapper widget
/// * [StringFutureOptionalStateWidget] - For state access
class StringFutureOptionalParamWidget extends ConsumerWidget {
  const StringFutureOptionalParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int a, String family, String? second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasStringFutureOptionalProviderScope(context);

    final params = _StringFutureOptionalParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (a: params.a, family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the StringFutureOptionalProvider state.
///
/// This widget requires a [StringFutureOptionalProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// StringFutureOptionalStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class StringFutureOptionalStateWidget extends ConsumerWidget {
  const StringFutureOptionalStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
      BuildContext context,
      WidgetRef ref,
      ({int a, String family, String? second}) params,
      String state,
      Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasStringFutureOptionalProviderScope(context);

    final params = _StringFutureOptionalParamsProvider.of(context);
    final state = ref
        .watch(stringFutureOptionalProvider(params!.a,
            family: params!.family, second: params!.second))
        .requireValue;
    return builder(
      context,
      ref,
      (a: params.a, family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from StringFutureOptionalProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// StringFutureOptionalSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [StringFutureOptionalProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// StringFutureOptionalSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [StringFutureOptionalProviderScope] - The required provider wrapper widget
/// * [StringFutureOptionalStateWidget] - For direct state access
class StringFutureOptionalSelectWidget<Selected> extends ConsumerWidget {
  const StringFutureOptionalSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(String state) selector;
  final Widget Function(
      BuildContext context,
      WidgetRef ref,
      ({int a, String family, String? second}) params,
      Selected value,
      Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasStringFutureOptionalProviderScope(context);

    final params = _StringFutureOptionalParamsProvider.of(context);
    final selected = ref.watch(
      stringFutureOptionalProvider(params!.a,
              family: params!.family, second: params!.second)
          .select((value) => selector(value.requireValue)),
    );

    return builder(
      context,
      ref,
      (a: params.a, family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for primativeProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed

///
/// Simple Usage:
/// ```dart
/// PrimativeProviderScope(
///
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeProviderScope(
///
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeProviderScope(
///
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeStateWidget] - For direct state access
/// * [PrimativeSelectWidget] - For optimized state selection
/// * [PrimativeParamWidget] - For family parameter access
class PrimativeProviderScope extends StatelessWidget {
  const PrimativeProviderScope({
    super.key,
    this.child,
    this.builder,
  });

  final Widget? child;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int state,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final state = ref.watch(primativeProvider);

        if (builder != null) {
          return builder!(context, ref, state, child);
        }

        return child ?? const SizedBox.shrink();
      },
    );
  }
}

/// A widget that provides direct access to the primativeProvider state.
///
/// This widget requires a [PrimativeProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling

///
/// Example usage:
/// ```dart
/// PrimativeStateWidget(
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeStateWidget extends ConsumerWidget {
  const PrimativeStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(
      BuildContext context, WidgetRef ref, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(primativeProvider);
    return builder(context, ref, state, child);
  }
}

/// A widget that provides optimized access to selected state data from primativeProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeProviderScope] ancestor.

///
/// Example usage:
/// ```dart
/// PrimativeSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeProviderScope] - The required provider wrapper widget
/// * [PrimativeStateWidget] - For direct state access
class PrimativeSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(
          BuildContext context, WidgetRef ref, Selected value, Widget? child)
      builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      primativeProvider.select((value) => selector(value)),
    );

    return builder(context, ref, selected, child);
  }
}

/// A widget that provides a scoped access point for primativeFaimilyProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed

///
/// Simple Usage:
/// ```dart
/// PrimativeFaimilyProviderScope(
///   family: intValue,
/// second: intValue,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeFaimilyProviderScope(
///   family: intValue,
/// second: intValue,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeFaimilyProviderScope(
///   family: intValue,
/// second: intValue,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyStateWidget] - For direct state access
/// * [PrimativeFaimilySelectWidget] - For optimized state selection
/// * [PrimativeFaimilyParamWidget] - For family parameter access
class PrimativeFaimilyProviderScope extends StatelessWidget {
  const PrimativeFaimilyProviderScope({
    super.key,
    required this.family,
    required this.second,
    this.child,
    this.builder,
  });

  final int family;
  final int second;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int state,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _PrimativeFaimilyParamsProvider(
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(primativeFaimilyProvider(family, second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            return child ?? const SizedBox.shrink();
          },
        ));
  }
}

bool _debugCheckHasPrimativeFaimilyProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyProviderScope &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for primativeFaimily widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _PrimativeFaimilyParamsProvider extends InheritedWidget {
  const _PrimativeFaimilyParamsProvider({
    required this.family,
    required this.second,
    required super.child,
  });

  final int family;
  final int second;

  static _PrimativeFaimilyParamsProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_PrimativeFaimilyParamsProvider>();
  }

  @override
  bool updateShouldNotify(_PrimativeFaimilyParamsProvider oldWidget) {
    return family != oldWidget.family || second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of primativeFaimilyProvider.
///
/// This widget requires a [PrimativeFaimilyProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [PrimativeFaimilyProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyStateWidget] - For state access
class PrimativeFaimilyParamWidget extends ConsumerWidget {
  const PrimativeFaimilyParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyProviderScope(context);

    final params = _PrimativeFaimilyParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the primativeFaimilyProvider state.
///
/// This widget requires a [PrimativeFaimilyProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeFaimilyStateWidget extends ConsumerWidget {
  const PrimativeFaimilyStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyProviderScope(context);

    final params = _PrimativeFaimilyParamsProvider.of(context);
    final state =
        ref.watch(primativeFaimilyProvider(params!.family, params!.second));
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from primativeFaimilyProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeFaimilySelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeFaimilyProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilySelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyStateWidget] - For direct state access
class PrimativeFaimilySelectWidget<Selected> extends ConsumerWidget {
  const PrimativeFaimilySelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params, Selected value, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyProviderScope(context);

    final params = _PrimativeFaimilyParamsProvider.of(context);
    final selected = ref.watch(
      primativeFaimilyProvider(params!.family, params!.second)
          .select((value) => selector(value)),
    );

    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for primativeFaimilyRequiredProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed

///
/// Simple Usage:
/// ```dart
/// PrimativeFaimilyRequiredProviderScope(
///   family: intValue,
/// second: int?Value,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeFaimilyRequiredProviderScope(
///   family: intValue,
/// second: int?Value,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeFaimilyRequiredProviderScope(
///   family: intValue,
/// second: int?Value,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyRequiredStateWidget] - For direct state access
/// * [PrimativeFaimilyRequiredSelectWidget] - For optimized state selection
/// * [PrimativeFaimilyRequiredParamWidget] - For family parameter access
class PrimativeFaimilyRequiredProviderScope extends StatelessWidget {
  const PrimativeFaimilyRequiredProviderScope({
    super.key,
    required this.family,
    this.second,
    this.child,
    this.builder,
  });

  final int family;
  final int? second;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int state,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _PrimativeFaimilyRequiredParamsProvider(
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(primativeFaimilyRequiredProvider(
                family: family, second: second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            return child ?? const SizedBox.shrink();
          },
        ));
  }
}

bool _debugCheckHasPrimativeFaimilyRequiredProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyRequiredProviderScope &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyRequiredProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyRequiredProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyRequiredProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for primativeFaimilyRequired widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _PrimativeFaimilyRequiredParamsProvider extends InheritedWidget {
  const _PrimativeFaimilyRequiredParamsProvider({
    required this.family,
    required this.second,
    required super.child,
  });

  final int family;
  final int? second;

  static _PrimativeFaimilyRequiredParamsProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        _PrimativeFaimilyRequiredParamsProvider>();
  }

  @override
  bool updateShouldNotify(_PrimativeFaimilyRequiredParamsProvider oldWidget) {
    return family != oldWidget.family || second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of primativeFaimilyRequiredProvider.
///
/// This widget requires a [PrimativeFaimilyRequiredProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [PrimativeFaimilyRequiredProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyRequiredStateWidget] - For state access
class PrimativeFaimilyRequiredParamWidget extends ConsumerWidget {
  const PrimativeFaimilyRequiredParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int? second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyRequiredProviderScope(context);

    final params = _PrimativeFaimilyRequiredParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the primativeFaimilyRequiredProvider state.
///
/// This widget requires a [PrimativeFaimilyRequiredProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyRequiredStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeFaimilyRequiredStateWidget extends ConsumerWidget {
  const PrimativeFaimilyRequiredStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int? second}) params, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyRequiredProviderScope(context);

    final params = _PrimativeFaimilyRequiredParamsProvider.of(context);
    final state = ref.watch(primativeFaimilyRequiredProvider(
        family: params!.family, second: params!.second));
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from primativeFaimilyRequiredProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeFaimilyRequiredSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeFaimilyRequiredProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyRequiredSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyRequiredProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyRequiredStateWidget] - For direct state access
class PrimativeFaimilyRequiredSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeFaimilyRequiredSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(
      BuildContext context,
      WidgetRef ref,
      ({int family, int? second}) params,
      Selected value,
      Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyRequiredProviderScope(context);

    final params = _PrimativeFaimilyRequiredParamsProvider.of(context);
    final selected = ref.watch(
      primativeFaimilyRequiredProvider(
              family: params!.family, second: params!.second)
          .select((value) => selector(value)),
    );

    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for primativeFaimilyWithDefaultProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed

///
/// Simple Usage:
/// ```dart
/// PrimativeFaimilyWithDefaultProviderScope(
///   family: intValue,
/// second: intValue,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeFaimilyWithDefaultProviderScope(
///   family: intValue,
/// second: intValue,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeFaimilyWithDefaultProviderScope(
///   family: intValue,
/// second: intValue,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultStateWidget] - For direct state access
/// * [PrimativeFaimilyWithDefaultSelectWidget] - For optimized state selection
/// * [PrimativeFaimilyWithDefaultParamWidget] - For family parameter access
class PrimativeFaimilyWithDefaultProviderScope extends StatelessWidget {
  const PrimativeFaimilyWithDefaultProviderScope({
    super.key,
    required this.family,
    this.second = 1,
    this.child,
    this.builder,
  });

  final int family;
  final int second;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int state,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _PrimativeFaimilyWithDefaultParamsProvider(
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(primativeFaimilyWithDefaultProvider(
                family: family, second: second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            return child ?? const SizedBox.shrink();
          },
        ));
  }
}

bool _debugCheckHasPrimativeFaimilyWithDefaultProviderScope(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyWithDefaultProviderScope &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyWithDefaultProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyWithDefaultProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyWithDefaultProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for primativeFaimilyWithDefault widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _PrimativeFaimilyWithDefaultParamsProvider extends InheritedWidget {
  const _PrimativeFaimilyWithDefaultParamsProvider({
    required this.family,
    required this.second,
    required super.child,
  });

  final int family;
  final int second;

  static _PrimativeFaimilyWithDefaultParamsProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        _PrimativeFaimilyWithDefaultParamsProvider>();
  }

  @override
  bool updateShouldNotify(
      _PrimativeFaimilyWithDefaultParamsProvider oldWidget) {
    return family != oldWidget.family || second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of primativeFaimilyWithDefaultProvider.
///
/// This widget requires a [PrimativeFaimilyWithDefaultProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [PrimativeFaimilyWithDefaultProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyWithDefaultStateWidget] - For state access
class PrimativeFaimilyWithDefaultParamWidget extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the primativeFaimilyWithDefaultProvider state.
///
/// This widget requires a [PrimativeFaimilyWithDefaultProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeFaimilyWithDefaultStateWidget extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultParamsProvider.of(context);
    final state = ref.watch(primativeFaimilyWithDefaultProvider(
        family: params!.family, second: params!.second));
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from primativeFaimilyWithDefaultProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeFaimilyWithDefaultSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeFaimilyWithDefaultProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyWithDefaultStateWidget] - For direct state access
class PrimativeFaimilyWithDefaultSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params, Selected value, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultParamsProvider.of(context);
    final selected = ref.watch(
      primativeFaimilyWithDefaultProvider(
              family: params!.family, second: params!.second)
          .select((value) => selector(value)),
    );

    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for primativeFaimilyWithDefaultAsyncProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed
///
/// Async State Handlers (only used when [builder] is not provided):
/// * [loading] - Custom widget for loading states
/// * [error] - Custom widget for error states with error details
/// * [data] - Custom widget for when data is available
///
/// Default State Handling:
/// Uses [KimappThemeExtension] for consistent loading/error states:
/// ```dart
/// Theme(
///   data: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const LoadingSpinner(),
///         defaultErrorStateWidget: (context, ref, error) => ErrorDisplay(error),
///       ),
///     ],
///   ),
///   child: YourApp(),
/// )
/// ```
///
/// Simple Usage:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncProviderScope(
///   family: intValue,
/// second: int?Value,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncProviderScope(
///   family: intValue,
/// second: int?Value,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncProviderScope(
///   family: intValue,
/// second: int?Value,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultAsyncStateWidget] - For direct state access
/// * [PrimativeFaimilyWithDefaultAsyncSelectWidget] - For optimized state selection
/// * [PrimativeFaimilyWithDefaultAsyncParamWidget] - For family parameter access
class PrimativeFaimilyWithDefaultAsyncProviderScope extends StatelessWidget {
  const PrimativeFaimilyWithDefaultAsyncProviderScope({
    super.key,
    required this.family,
    this.second,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  }) : assert(
          builder == null || (loading == null && error == null && data == null),
          'When builder is provided, loading, error, and data callbacks are ignored. '
          'Remove these callbacks or remove the builder to avoid confusion.',
        );

  final int family;
  final int? second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(int data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> asyncValue,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _PrimativeFaimilyWithDefaultAsyncParamsProvider(
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(primativeFaimilyWithDefaultAsyncProvider(
                family: family, second: second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            final themeExtension =
                Theme.of(context).extension<KimappThemeExtension>();
            return state.when(
              data: (data) {
                final result = this.data?.call(data) ?? child;
                if (result == null) {
                  Kimapp.instance.log(LoggerType.warning,
                      message:
                          'No child provided for primativeFaimilyWithDefaultAsyncProviderScope. Empty SizedBox will be returned.');
                  return const SizedBox.shrink();
                }
                return result;
              },
              error: (error, stack) =>
                  this.error?.call(error, stack) ??
                  themeExtension?.defaultErrorStateWidget
                      ?.call(context, ref, error) ??
                  const SizedBox.shrink(),
              loading: () =>
                  loading?.call() ??
                  themeExtension?.defaultLoadingStateWidget
                      ?.call(context, ref) ??
                  const SizedBox.shrink(),
            );
          },
        ));
  }
}

bool _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderScope(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyWithDefaultAsyncProviderScope &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyWithDefaultAsyncProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyWithDefaultAsyncProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyWithDefaultAsyncProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for primativeFaimilyWithDefaultAsync widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _PrimativeFaimilyWithDefaultAsyncParamsProvider extends InheritedWidget {
  const _PrimativeFaimilyWithDefaultAsyncParamsProvider({
    required this.family,
    required this.second,
    required super.child,
  });

  final int family;
  final int? second;

  static _PrimativeFaimilyWithDefaultAsyncParamsProvider? of(
      BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        _PrimativeFaimilyWithDefaultAsyncParamsProvider>();
  }

  @override
  bool updateShouldNotify(
      _PrimativeFaimilyWithDefaultAsyncParamsProvider oldWidget) {
    return family != oldWidget.family || second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of primativeFaimilyWithDefaultAsyncProvider.
///
/// This widget requires a [PrimativeFaimilyWithDefaultAsyncProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [PrimativeFaimilyWithDefaultAsyncProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyWithDefaultAsyncStateWidget] - For state access
class PrimativeFaimilyWithDefaultAsyncParamWidget extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultAsyncParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int? second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultAsyncParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the primativeFaimilyWithDefaultAsyncProvider state.
///
/// This widget requires a [PrimativeFaimilyWithDefaultAsyncProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeFaimilyWithDefaultAsyncStateWidget extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultAsyncStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int? second}) params, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultAsyncParamsProvider.of(context);
    final state = ref
        .watch(primativeFaimilyWithDefaultAsyncProvider(
            family: params!.family, second: params!.second))
        .requireValue;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from primativeFaimilyWithDefaultAsyncProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeFaimilyWithDefaultAsyncSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeFaimilyWithDefaultAsyncProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultAsyncProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyWithDefaultAsyncStateWidget] - For direct state access
class PrimativeFaimilyWithDefaultAsyncSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultAsyncSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(
      BuildContext context,
      WidgetRef ref,
      ({int family, int? second}) params,
      Selected value,
      Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultAsyncParamsProvider.of(context);
    final selected = ref.watch(
      primativeFaimilyWithDefaultAsyncProvider(
              family: params!.family, second: params!.second)
          .select((value) => selector(value.requireValue)),
    );

    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for primativeFaimilyWithDefaultStreamProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed
///
/// Async State Handlers (only used when [builder] is not provided):
/// * [loading] - Custom widget for loading states
/// * [error] - Custom widget for error states with error details
/// * [data] - Custom widget for when data is available
///
/// Default State Handling:
/// Uses [KimappThemeExtension] for consistent loading/error states:
/// ```dart
/// Theme(
///   data: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const LoadingSpinner(),
///         defaultErrorStateWidget: (context, ref, error) => ErrorDisplay(error),
///       ),
///     ],
///   ),
///   child: YourApp(),
/// )
/// ```
///
/// Simple Usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamProviderScope(
///   family: intValue,
/// second: intValue,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamProviderScope(
///   family: intValue,
/// second: intValue,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamProviderScope(
///   family: intValue,
/// second: intValue,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultStreamStateWidget] - For direct state access
/// * [PrimativeFaimilyWithDefaultStreamSelectWidget] - For optimized state selection
/// * [PrimativeFaimilyWithDefaultStreamParamWidget] - For family parameter access
class PrimativeFaimilyWithDefaultStreamProviderScope extends StatelessWidget {
  const PrimativeFaimilyWithDefaultStreamProviderScope({
    super.key,
    required this.family,
    this.second = 1,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  }) : assert(
          builder == null || (loading == null && error == null && data == null),
          'When builder is provided, loading, error, and data callbacks are ignored. '
          'Remove these callbacks or remove the builder to avoid confusion.',
        );

  final int family;
  final int second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(int data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> asyncValue,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _PrimativeFaimilyWithDefaultStreamParamsProvider(
        family: family,
        second: second,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state = ref.watch(primativeFaimilyWithDefaultStreamProvider(
                family: family, second: second));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            final themeExtension =
                Theme.of(context).extension<KimappThemeExtension>();
            return state.when(
              data: (data) {
                final result = this.data?.call(data) ?? child;
                if (result == null) {
                  Kimapp.instance.log(LoggerType.warning,
                      message:
                          'No child provided for primativeFaimilyWithDefaultStreamProviderScope. Empty SizedBox will be returned.');
                  return const SizedBox.shrink();
                }
                return result;
              },
              error: (error, stack) =>
                  this.error?.call(error, stack) ??
                  themeExtension?.defaultErrorStateWidget
                      ?.call(context, ref, error) ??
                  const SizedBox.shrink(),
              loading: () =>
                  loading?.call() ??
                  themeExtension?.defaultLoadingStateWidget
                      ?.call(context, ref) ??
                  const SizedBox.shrink(),
            );
          },
        ));
  }
}

bool _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderScope(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyWithDefaultStreamProviderScope &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyWithDefaultStreamProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyWithDefaultStreamProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyWithDefaultStreamProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for primativeFaimilyWithDefaultStream widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _PrimativeFaimilyWithDefaultStreamParamsProvider extends InheritedWidget {
  const _PrimativeFaimilyWithDefaultStreamParamsProvider({
    required this.family,
    required this.second,
    required super.child,
  });

  final int family;
  final int second;

  static _PrimativeFaimilyWithDefaultStreamParamsProvider? of(
      BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        _PrimativeFaimilyWithDefaultStreamParamsProvider>();
  }

  @override
  bool updateShouldNotify(
      _PrimativeFaimilyWithDefaultStreamParamsProvider oldWidget) {
    return family != oldWidget.family || second != oldWidget.second;
  }
}

/// A widget that provides access to the family parameters of primativeFaimilyWithDefaultStreamProvider.
///
/// This widget requires a [PrimativeFaimilyWithDefaultStreamProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [PrimativeFaimilyWithDefaultStreamProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyWithDefaultStreamStateWidget] - For state access
class PrimativeFaimilyWithDefaultStreamParamWidget extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultStreamParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderScope(context);

    final params =
        _PrimativeFaimilyWithDefaultStreamParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
    );
  }
}

/// A widget that provides direct access to the primativeFaimilyWithDefaultStreamProvider state.
///
/// This widget requires a [PrimativeFaimilyWithDefaultStreamProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeFaimilyWithDefaultStreamStateWidget extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultStreamStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultStreamParamsProvider.of(context);
    final state = ref
        .watch(primativeFaimilyWithDefaultStreamProvider(
            family: params!.family, second: params!.second))
        .requireValue;
    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from primativeFaimilyWithDefaultStreamProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeFaimilyWithDefaultStreamSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeFaimilyWithDefaultStreamProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultStreamProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyWithDefaultStreamStateWidget] - For direct state access
class PrimativeFaimilyWithDefaultStreamSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultStreamSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(BuildContext context, WidgetRef ref,
      ({int family, int second}) params, Selected value, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderScope(context);

    final params = _PrimativeFaimilyWithDefaultStreamParamsProvider.of(context);
    final selected = ref.watch(
      primativeFaimilyWithDefaultStreamProvider(
              family: params!.family, second: params!.second)
          .select((value) => selector(value.requireValue)),
    );

    return builder(
      context,
      ref,
      (family: params.family, second: params.second),
      selected,
      child,
    );
  }
}

/// A widget that provides a scoped access point for primativeFaimilyOptionalProvider state management.
///
/// This widget must be placed above any widgets that need to access the state. It provides
/// multiple ways to handle state rendering through various callback options.
///
/// Key Features:
/// * Centralized state management and dependency injection
/// * Multiple rendering options through different callbacks
/// * Automatic error and loading state handling for async providers
/// * Theme-aware default loading and error states
///
/// Available Callbacks:
/// * [builder] - Full control over rendering with access to context, ref, AsyncValue<T>, and child.
///   When provided, other callbacks ([loading], [error], [data]) are ignored and you must
///   manually handle the async states using asyncValue.when()
/// * [child] - Simple widget to display when no complex building logic is needed

///
/// Simple Usage:
/// ```dart
/// PrimativeFaimilyOptionalProviderScope(
///   family: int?Value,
///   child: const YourWidget(),
/// )
/// ```
///
/// Advanced Usage with Builder:
/// ```dart
/// PrimativeFaimilyOptionalProviderScope(
///   family: int?Value,
///   builder: (context, ref, asyncValue, child) {
///     // Manual handling of async states
///     return asyncValue.when(
///       data: (data) => Text(data),
///       loading: () => const CircularProgressIndicator(),
///       error: (error, stack) => Text('Error: $error'),
///     );
///   },
/// )
/// ```
///
/// Advanced Usage with State Handlers:
/// ```dart
/// PrimativeFaimilyOptionalProviderScope(
///   family: int?Value,
///   loading: () => const CustomLoadingIndicator(),
///   error: (error, stack) => CustomErrorWidget(error: error),
///   data: (data) => DataDisplay(data: data),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyOptionalStateWidget] - For direct state access
/// * [PrimativeFaimilyOptionalSelectWidget] - For optimized state selection
/// * [PrimativeFaimilyOptionalParamWidget] - For family parameter access
class PrimativeFaimilyOptionalProviderScope extends StatelessWidget {
  const PrimativeFaimilyOptionalProviderScope({
    super.key,
    this.family,
    this.child,
    this.builder,
  });

  final int? family;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    int state,
    Widget? child,
  )? builder;

  @override
  Widget build(BuildContext context) {
    return _PrimativeFaimilyOptionalParamsProvider(
        family: family,
        child: Consumer(
          child: child,
          builder: (context, ref, child) {
            final state =
                ref.watch(primativeFaimilyOptionalProvider(family: family));

            if (builder != null) {
              return builder!(context, ref, state, child);
            }

            return child ?? const SizedBox.shrink();
          },
        ));
  }
}

bool _debugCheckHasPrimativeFaimilyOptionalProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyOptionalProviderScope &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyOptionalProviderScope>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyOptionalProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyOptionalProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

/// An internal InheritedWidget that manages family parameters for primativeFaimilyOptional widgets.
///
/// This widget is used internally by the generated widgets to propagate family parameters
/// down the widget tree. It should not be used directly in application code.
class _PrimativeFaimilyOptionalParamsProvider extends InheritedWidget {
  const _PrimativeFaimilyOptionalParamsProvider({
    required this.family,
    required super.child,
  });

  final int? family;

  static _PrimativeFaimilyOptionalParamsProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        _PrimativeFaimilyOptionalParamsProvider>();
  }

  @override
  bool updateShouldNotify(_PrimativeFaimilyOptionalParamsProvider oldWidget) {
    return family != oldWidget.family;
  }
}

/// A widget that provides access to the family parameters of primativeFaimilyOptionalProvider.
///
/// This widget requires a [PrimativeFaimilyOptionalProviderScope] ancestor
/// and provides access to the family parameters through a builder callback.
///
/// Key features:
/// * Access to all family parameters through a single record
/// * Type-safe parameter handling
/// * Automatic parameter updates when the provider changes
/// See also:
/// * [PrimativeFaimilyOptionalProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyOptionalStateWidget] - For state access
class PrimativeFaimilyOptionalParamWidget extends ConsumerWidget {
  const PrimativeFaimilyOptionalParamWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(
      BuildContext context, WidgetRef ref, ({int? family}) params) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyOptionalProviderScope(context);

    final params = _PrimativeFaimilyOptionalParamsProvider.of(context)!;
    return builder(
      context,
      ref,
      (family: params.family),
    );
  }
}

/// A widget that provides direct access to the primativeFaimilyOptionalProvider state.
///
/// This widget requires a [PrimativeFaimilyOptionalProviderScope] ancestor
/// and provides a more streamlined way to build UI based on the current state.
/// Unlike the provider widget, this widget assumes the state is available and
/// ready to use.
///
/// Key features:
/// * Direct state access through the [builder] callback
/// * Automatic state updates when the underlying data changes
/// * Type-safe state handling
///
/// This widget automatically inherits family parameters from its provider ancestor,
/// making it convenient to use in nested widget structures.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyOptionalStateWidget(
///   builder: (context, ref, params, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Optional child widget'),
/// )
/// ```
class PrimativeFaimilyOptionalStateWidget extends ConsumerWidget {
  const PrimativeFaimilyOptionalStateWidget({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext context, WidgetRef ref,
      ({int? family}) params, int state, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyOptionalProviderScope(context);

    final params = _PrimativeFaimilyOptionalParamsProvider.of(context);
    final state =
        ref.watch(primativeFaimilyOptionalProvider(family: params!.family));
    return builder(
      context,
      ref,
      (family: params.family),
      state,
      child,
    );
  }
}

/// A widget that provides optimized access to selected state data from primativeFaimilyOptionalProvider.
///
/// This widget helps improve performance by:
/// * Only rebuilding when the selected data changes
/// * Allowing fine-grained control over what parts of the state to watch
/// * Providing type-safe access to selected state portions
///
/// Example:
/// ```dart
/// // Select and watch only the user's name from a larger user state
/// PrimativeFaimilyOptionalSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// Performance Benefits:
/// * Minimizes unnecessary rebuilds
/// * Reduces memory usage by watching only needed data
/// * Improves app responsiveness
///
/// Best Practices:
/// * Keep selectors simple and focused
/// * Use for frequently changing state
/// * Consider caching complex selections
///
/// Note: Requires [PrimativeFaimilyOptionalProviderScope] ancestor.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyOptionalSelectWidget<String>(
///   selector: (state) => state.userName,
///   builder: (context, ref, params, userName, child) {
///     return Text(userName);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyOptionalProviderScope] - The required provider wrapper widget
/// * [PrimativeFaimilyOptionalStateWidget] - For direct state access
class PrimativeFaimilyOptionalSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeFaimilyOptionalSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.child,
  });

  final Selected Function(int state) selector;
  final Widget Function(BuildContext context, WidgetRef ref,
      ({int? family}) params, Selected value, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasPrimativeFaimilyOptionalProviderScope(context);

    final params = _PrimativeFaimilyOptionalParamsProvider.of(context);
    final selected = ref.watch(
      primativeFaimilyOptionalProvider(family: params!.family)
          .select((value) => selector(value)),
    );

    return builder(
      context,
      ref,
      (family: params.family),
      selected,
      child,
    );
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$primativeHash() => r'e65df9f7187b7373860956c12243376a92d032c0';

/// See also [primative].
@ProviderFor(primative)
final primativeProvider = AutoDisposeProvider<int>.internal(
  primative,
  name: r'primativeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$primativeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrimativeRef = AutoDisposeProviderRef<int>;
String _$primativeFaimilyHash() => r'46d53bb8c6fd336a1b6bcaad46c228a67195a984';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [primativeFaimily].
@ProviderFor(primativeFaimily)
const primativeFaimilyProvider = PrimativeFaimilyFamily();

/// See also [primativeFaimily].
class PrimativeFaimilyFamily extends Family<int> {
  /// See also [primativeFaimily].
  const PrimativeFaimilyFamily();

  /// See also [primativeFaimily].
  PrimativeFaimilyProvider call(
    int family,
    int second,
  ) {
    return PrimativeFaimilyProvider(
      family,
      second,
    );
  }

  @override
  PrimativeFaimilyProvider getProviderOverride(
    covariant PrimativeFaimilyProvider provider,
  ) {
    return call(
      provider.family,
      provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'primativeFaimilyProvider';
}

/// See also [primativeFaimily].
class PrimativeFaimilyProvider extends AutoDisposeProvider<int> {
  /// See also [primativeFaimily].
  PrimativeFaimilyProvider(
    int family,
    int second,
  ) : this._internal(
          (ref) => primativeFaimily(
            ref as PrimativeFaimilyRef,
            family,
            second,
          ),
          from: primativeFaimilyProvider,
          name: r'primativeFaimilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$primativeFaimilyHash,
          dependencies: PrimativeFaimilyFamily._dependencies,
          allTransitiveDependencies:
              PrimativeFaimilyFamily._allTransitiveDependencies,
          family: family,
          second: second,
        );

  PrimativeFaimilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
    required this.second,
  }) : super.internal();

  final int family;
  final int second;

  @override
  Override overrideWith(
    int Function(PrimativeFaimilyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrimativeFaimilyProvider._internal(
        (ref) => create(ref as PrimativeFaimilyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _PrimativeFaimilyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimativeFaimilyProvider &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrimativeFaimilyRef on AutoDisposeProviderRef<int> {
  /// The parameter `family` of this provider.
  int get family;

  /// The parameter `second` of this provider.
  int get second;
}

class _PrimativeFaimilyProviderElement extends AutoDisposeProviderElement<int>
    with PrimativeFaimilyRef {
  _PrimativeFaimilyProviderElement(super.provider);

  @override
  int get family => (origin as PrimativeFaimilyProvider).family;
  @override
  int get second => (origin as PrimativeFaimilyProvider).second;
}

String _$primativeFaimilyRequiredHash() =>
    r'ec6d9c12baead1fcd2854e2d82f8938e91006dfc';

/// See also [primativeFaimilyRequired].
@ProviderFor(primativeFaimilyRequired)
const primativeFaimilyRequiredProvider = PrimativeFaimilyRequiredFamily();

/// See also [primativeFaimilyRequired].
class PrimativeFaimilyRequiredFamily extends Family<int> {
  /// See also [primativeFaimilyRequired].
  const PrimativeFaimilyRequiredFamily();

  /// See also [primativeFaimilyRequired].
  PrimativeFaimilyRequiredProvider call({
    required int family,
    int? second,
  }) {
    return PrimativeFaimilyRequiredProvider(
      family: family,
      second: second,
    );
  }

  @override
  PrimativeFaimilyRequiredProvider getProviderOverride(
    covariant PrimativeFaimilyRequiredProvider provider,
  ) {
    return call(
      family: provider.family,
      second: provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'primativeFaimilyRequiredProvider';
}

/// See also [primativeFaimilyRequired].
class PrimativeFaimilyRequiredProvider extends AutoDisposeProvider<int> {
  /// See also [primativeFaimilyRequired].
  PrimativeFaimilyRequiredProvider({
    required int family,
    int? second,
  }) : this._internal(
          (ref) => primativeFaimilyRequired(
            ref as PrimativeFaimilyRequiredRef,
            family: family,
            second: second,
          ),
          from: primativeFaimilyRequiredProvider,
          name: r'primativeFaimilyRequiredProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$primativeFaimilyRequiredHash,
          dependencies: PrimativeFaimilyRequiredFamily._dependencies,
          allTransitiveDependencies:
              PrimativeFaimilyRequiredFamily._allTransitiveDependencies,
          family: family,
          second: second,
        );

  PrimativeFaimilyRequiredProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
    required this.second,
  }) : super.internal();

  final int family;
  final int? second;

  @override
  Override overrideWith(
    int Function(PrimativeFaimilyRequiredRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrimativeFaimilyRequiredProvider._internal(
        (ref) => create(ref as PrimativeFaimilyRequiredRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _PrimativeFaimilyRequiredProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimativeFaimilyRequiredProvider &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrimativeFaimilyRequiredRef on AutoDisposeProviderRef<int> {
  /// The parameter `family` of this provider.
  int get family;

  /// The parameter `second` of this provider.
  int? get second;
}

class _PrimativeFaimilyRequiredProviderElement
    extends AutoDisposeProviderElement<int> with PrimativeFaimilyRequiredRef {
  _PrimativeFaimilyRequiredProviderElement(super.provider);

  @override
  int get family => (origin as PrimativeFaimilyRequiredProvider).family;
  @override
  int? get second => (origin as PrimativeFaimilyRequiredProvider).second;
}

String _$primativeFaimilyWithDefaultHash() =>
    r'4c7061ce6bc33d736e17e147aacd016cafe92243';

/// See also [primativeFaimilyWithDefault].
@ProviderFor(primativeFaimilyWithDefault)
const primativeFaimilyWithDefaultProvider = PrimativeFaimilyWithDefaultFamily();

/// See also [primativeFaimilyWithDefault].
class PrimativeFaimilyWithDefaultFamily extends Family<int> {
  /// See also [primativeFaimilyWithDefault].
  const PrimativeFaimilyWithDefaultFamily();

  /// See also [primativeFaimilyWithDefault].
  PrimativeFaimilyWithDefaultProvider call({
    required int family,
    int second = 1,
  }) {
    return PrimativeFaimilyWithDefaultProvider(
      family: family,
      second: second,
    );
  }

  @override
  PrimativeFaimilyWithDefaultProvider getProviderOverride(
    covariant PrimativeFaimilyWithDefaultProvider provider,
  ) {
    return call(
      family: provider.family,
      second: provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'primativeFaimilyWithDefaultProvider';
}

/// See also [primativeFaimilyWithDefault].
class PrimativeFaimilyWithDefaultProvider extends AutoDisposeProvider<int> {
  /// See also [primativeFaimilyWithDefault].
  PrimativeFaimilyWithDefaultProvider({
    required int family,
    int second = 1,
  }) : this._internal(
          (ref) => primativeFaimilyWithDefault(
            ref as PrimativeFaimilyWithDefaultRef,
            family: family,
            second: second,
          ),
          from: primativeFaimilyWithDefaultProvider,
          name: r'primativeFaimilyWithDefaultProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$primativeFaimilyWithDefaultHash,
          dependencies: PrimativeFaimilyWithDefaultFamily._dependencies,
          allTransitiveDependencies:
              PrimativeFaimilyWithDefaultFamily._allTransitiveDependencies,
          family: family,
          second: second,
        );

  PrimativeFaimilyWithDefaultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
    required this.second,
  }) : super.internal();

  final int family;
  final int second;

  @override
  Override overrideWith(
    int Function(PrimativeFaimilyWithDefaultRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrimativeFaimilyWithDefaultProvider._internal(
        (ref) => create(ref as PrimativeFaimilyWithDefaultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _PrimativeFaimilyWithDefaultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimativeFaimilyWithDefaultProvider &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrimativeFaimilyWithDefaultRef on AutoDisposeProviderRef<int> {
  /// The parameter `family` of this provider.
  int get family;

  /// The parameter `second` of this provider.
  int get second;
}

class _PrimativeFaimilyWithDefaultProviderElement
    extends AutoDisposeProviderElement<int>
    with PrimativeFaimilyWithDefaultRef {
  _PrimativeFaimilyWithDefaultProviderElement(super.provider);

  @override
  int get family => (origin as PrimativeFaimilyWithDefaultProvider).family;
  @override
  int get second => (origin as PrimativeFaimilyWithDefaultProvider).second;
}

String _$primativeFaimilyWithDefaultAsyncHash() =>
    r'28992185b6148e8f56ff7d1e592d28a282cdae32';

/// See also [primativeFaimilyWithDefaultAsync].
@ProviderFor(primativeFaimilyWithDefaultAsync)
const primativeFaimilyWithDefaultAsyncProvider =
    PrimativeFaimilyWithDefaultAsyncFamily();

/// See also [primativeFaimilyWithDefaultAsync].
class PrimativeFaimilyWithDefaultAsyncFamily extends Family<AsyncValue<int>> {
  /// See also [primativeFaimilyWithDefaultAsync].
  const PrimativeFaimilyWithDefaultAsyncFamily();

  /// See also [primativeFaimilyWithDefaultAsync].
  PrimativeFaimilyWithDefaultAsyncProvider call({
    required int family,
    int? second,
  }) {
    return PrimativeFaimilyWithDefaultAsyncProvider(
      family: family,
      second: second,
    );
  }

  @override
  PrimativeFaimilyWithDefaultAsyncProvider getProviderOverride(
    covariant PrimativeFaimilyWithDefaultAsyncProvider provider,
  ) {
    return call(
      family: provider.family,
      second: provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'primativeFaimilyWithDefaultAsyncProvider';
}

/// See also [primativeFaimilyWithDefaultAsync].
class PrimativeFaimilyWithDefaultAsyncProvider
    extends AutoDisposeFutureProvider<int> {
  /// See also [primativeFaimilyWithDefaultAsync].
  PrimativeFaimilyWithDefaultAsyncProvider({
    required int family,
    int? second,
  }) : this._internal(
          (ref) => primativeFaimilyWithDefaultAsync(
            ref as PrimativeFaimilyWithDefaultAsyncRef,
            family: family,
            second: second,
          ),
          from: primativeFaimilyWithDefaultAsyncProvider,
          name: r'primativeFaimilyWithDefaultAsyncProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$primativeFaimilyWithDefaultAsyncHash,
          dependencies: PrimativeFaimilyWithDefaultAsyncFamily._dependencies,
          allTransitiveDependencies:
              PrimativeFaimilyWithDefaultAsyncFamily._allTransitiveDependencies,
          family: family,
          second: second,
        );

  PrimativeFaimilyWithDefaultAsyncProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
    required this.second,
  }) : super.internal();

  final int family;
  final int? second;

  @override
  Override overrideWith(
    FutureOr<int> Function(PrimativeFaimilyWithDefaultAsyncRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrimativeFaimilyWithDefaultAsyncProvider._internal(
        (ref) => create(ref as PrimativeFaimilyWithDefaultAsyncRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _PrimativeFaimilyWithDefaultAsyncProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimativeFaimilyWithDefaultAsyncProvider &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrimativeFaimilyWithDefaultAsyncRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `family` of this provider.
  int get family;

  /// The parameter `second` of this provider.
  int? get second;
}

class _PrimativeFaimilyWithDefaultAsyncProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with PrimativeFaimilyWithDefaultAsyncRef {
  _PrimativeFaimilyWithDefaultAsyncProviderElement(super.provider);

  @override
  int get family => (origin as PrimativeFaimilyWithDefaultAsyncProvider).family;
  @override
  int? get second =>
      (origin as PrimativeFaimilyWithDefaultAsyncProvider).second;
}

String _$primativeFaimilyWithDefaultStreamHash() =>
    r'3bc6c1df2a000145831a37b0b0cfabbb795b6c0e';

/// See also [primativeFaimilyWithDefaultStream].
@ProviderFor(primativeFaimilyWithDefaultStream)
const primativeFaimilyWithDefaultStreamProvider =
    PrimativeFaimilyWithDefaultStreamFamily();

/// See also [primativeFaimilyWithDefaultStream].
class PrimativeFaimilyWithDefaultStreamFamily extends Family<AsyncValue<int>> {
  /// See also [primativeFaimilyWithDefaultStream].
  const PrimativeFaimilyWithDefaultStreamFamily();

  /// See also [primativeFaimilyWithDefaultStream].
  PrimativeFaimilyWithDefaultStreamProvider call({
    required int family,
    int second = 1,
  }) {
    return PrimativeFaimilyWithDefaultStreamProvider(
      family: family,
      second: second,
    );
  }

  @override
  PrimativeFaimilyWithDefaultStreamProvider getProviderOverride(
    covariant PrimativeFaimilyWithDefaultStreamProvider provider,
  ) {
    return call(
      family: provider.family,
      second: provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'primativeFaimilyWithDefaultStreamProvider';
}

/// See also [primativeFaimilyWithDefaultStream].
class PrimativeFaimilyWithDefaultStreamProvider
    extends AutoDisposeStreamProvider<int> {
  /// See also [primativeFaimilyWithDefaultStream].
  PrimativeFaimilyWithDefaultStreamProvider({
    required int family,
    int second = 1,
  }) : this._internal(
          (ref) => primativeFaimilyWithDefaultStream(
            ref as PrimativeFaimilyWithDefaultStreamRef,
            family: family,
            second: second,
          ),
          from: primativeFaimilyWithDefaultStreamProvider,
          name: r'primativeFaimilyWithDefaultStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$primativeFaimilyWithDefaultStreamHash,
          dependencies: PrimativeFaimilyWithDefaultStreamFamily._dependencies,
          allTransitiveDependencies: PrimativeFaimilyWithDefaultStreamFamily
              ._allTransitiveDependencies,
          family: family,
          second: second,
        );

  PrimativeFaimilyWithDefaultStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
    required this.second,
  }) : super.internal();

  final int family;
  final int second;

  @override
  Override overrideWith(
    Stream<int> Function(PrimativeFaimilyWithDefaultStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrimativeFaimilyWithDefaultStreamProvider._internal(
        (ref) => create(ref as PrimativeFaimilyWithDefaultStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _PrimativeFaimilyWithDefaultStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimativeFaimilyWithDefaultStreamProvider &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrimativeFaimilyWithDefaultStreamRef
    on AutoDisposeStreamProviderRef<int> {
  /// The parameter `family` of this provider.
  int get family;

  /// The parameter `second` of this provider.
  int get second;
}

class _PrimativeFaimilyWithDefaultStreamProviderElement
    extends AutoDisposeStreamProviderElement<int>
    with PrimativeFaimilyWithDefaultStreamRef {
  _PrimativeFaimilyWithDefaultStreamProviderElement(super.provider);

  @override
  int get family =>
      (origin as PrimativeFaimilyWithDefaultStreamProvider).family;
  @override
  int get second =>
      (origin as PrimativeFaimilyWithDefaultStreamProvider).second;
}

String _$primativeFaimilyOptionalHash() =>
    r'fae8a2b7e233f3d672f77a5020f1c118037adfb1';

/// See also [primativeFaimilyOptional].
@ProviderFor(primativeFaimilyOptional)
const primativeFaimilyOptionalProvider = PrimativeFaimilyOptionalFamily();

/// See also [primativeFaimilyOptional].
class PrimativeFaimilyOptionalFamily extends Family<int> {
  /// See also [primativeFaimilyOptional].
  const PrimativeFaimilyOptionalFamily();

  /// See also [primativeFaimilyOptional].
  PrimativeFaimilyOptionalProvider call({
    int? family,
  }) {
    return PrimativeFaimilyOptionalProvider(
      family: family,
    );
  }

  @override
  PrimativeFaimilyOptionalProvider getProviderOverride(
    covariant PrimativeFaimilyOptionalProvider provider,
  ) {
    return call(
      family: provider.family,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'primativeFaimilyOptionalProvider';
}

/// See also [primativeFaimilyOptional].
class PrimativeFaimilyOptionalProvider extends AutoDisposeProvider<int> {
  /// See also [primativeFaimilyOptional].
  PrimativeFaimilyOptionalProvider({
    int? family,
  }) : this._internal(
          (ref) => primativeFaimilyOptional(
            ref as PrimativeFaimilyOptionalRef,
            family: family,
          ),
          from: primativeFaimilyOptionalProvider,
          name: r'primativeFaimilyOptionalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$primativeFaimilyOptionalHash,
          dependencies: PrimativeFaimilyOptionalFamily._dependencies,
          allTransitiveDependencies:
              PrimativeFaimilyOptionalFamily._allTransitiveDependencies,
          family: family,
        );

  PrimativeFaimilyOptionalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
  }) : super.internal();

  final int? family;

  @override
  Override overrideWith(
    int Function(PrimativeFaimilyOptionalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrimativeFaimilyOptionalProvider._internal(
        (ref) => create(ref as PrimativeFaimilyOptionalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _PrimativeFaimilyOptionalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrimativeFaimilyOptionalProvider && other.family == family;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrimativeFaimilyOptionalRef on AutoDisposeProviderRef<int> {
  /// The parameter `family` of this provider.
  int? get family;
}

class _PrimativeFaimilyOptionalProviderElement
    extends AutoDisposeProviderElement<int> with PrimativeFaimilyOptionalRef {
  _PrimativeFaimilyOptionalProviderElement(super.provider);

  @override
  int? get family => (origin as PrimativeFaimilyOptionalProvider).family;
}

String _$productDetailHash() => r'fcfe71feb116510cc34a9a7d8c27dd073ec4afc1';

abstract class _$ProductDetail
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final int productId;

  FutureOr<String> build(
    int productId,
  );
}

/// See also [ProductDetail].
@ProviderFor(ProductDetail)
const productDetailProvider = ProductDetailFamily();

/// See also [ProductDetail].
class ProductDetailFamily extends Family<AsyncValue<String>> {
  /// See also [ProductDetail].
  const ProductDetailFamily();

  /// See also [ProductDetail].
  ProductDetailProvider call(
    int productId,
  ) {
    return ProductDetailProvider(
      productId,
    );
  }

  @override
  ProductDetailProvider getProviderOverride(
    covariant ProductDetailProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDetailProvider';
}

/// See also [ProductDetail].
class ProductDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductDetail, String> {
  /// See also [ProductDetail].
  ProductDetailProvider(
    int productId,
  ) : this._internal(
          () => ProductDetail()..productId = productId,
          from: productDetailProvider,
          name: r'productDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productDetailHash,
          dependencies: ProductDetailFamily._dependencies,
          allTransitiveDependencies:
              ProductDetailFamily._allTransitiveDependencies,
          productId: productId,
        );

  ProductDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  FutureOr<String> runNotifierBuild(
    covariant ProductDetail notifier,
  ) {
    return notifier.build(
      productId,
    );
  }

  @override
  Override overrideWith(ProductDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductDetail, String>
      createElement() {
    return _ProductDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDetailRef on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _ProductDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductDetail, String>
    with ProductDetailRef {
  _ProductDetailProviderElement(super.provider);

  @override
  int get productId => (origin as ProductDetailProvider).productId;
}

String _$primativeClassHash() => r'e8b8bdfa63667d03d32d32daac4603361225e35e';

/// See also [PrimativeClass].
@ProviderFor(PrimativeClass)
final primativeClassProvider =
    AutoDisposeNotifierProvider<PrimativeClass, int>.internal(
  PrimativeClass.new,
  name: r'primativeClassProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$primativeClassHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PrimativeClass = AutoDisposeNotifier<int>;
String _$stringFutureHash() => r'd667a28a27010f9923d192213898373e6b56014d';

abstract class _$StringFuture
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final String family;
  late final String second;

  FutureOr<String> build({
    required String family,
    required String second,
  });
}

/// See also [StringFuture].
@ProviderFor(StringFuture)
const stringFutureProvider = StringFutureFamily();

/// See also [StringFuture].
class StringFutureFamily extends Family<AsyncValue<String>> {
  /// See also [StringFuture].
  const StringFutureFamily();

  /// See also [StringFuture].
  StringFutureProvider call({
    required String family,
    required String second,
  }) {
    return StringFutureProvider(
      family: family,
      second: second,
    );
  }

  @override
  StringFutureProvider getProviderOverride(
    covariant StringFutureProvider provider,
  ) {
    return call(
      family: provider.family,
      second: provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stringFutureProvider';
}

/// See also [StringFuture].
class StringFutureProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StringFuture, String> {
  /// See also [StringFuture].
  StringFutureProvider({
    required String family,
    required String second,
  }) : this._internal(
          () => StringFuture()
            ..family = family
            ..second = second,
          from: stringFutureProvider,
          name: r'stringFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stringFutureHash,
          dependencies: StringFutureFamily._dependencies,
          allTransitiveDependencies:
              StringFutureFamily._allTransitiveDependencies,
          family: family,
          second: second,
        );

  StringFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
    required this.second,
  }) : super.internal();

  final String family;
  final String second;

  @override
  FutureOr<String> runNotifierBuild(
    covariant StringFuture notifier,
  ) {
    return notifier.build(
      family: family,
      second: second,
    );
  }

  @override
  Override overrideWith(StringFuture Function() create) {
    return ProviderOverride(
      origin: this,
      override: StringFutureProvider._internal(
        () => create()
          ..family = family
          ..second = second,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StringFuture, String>
      createElement() {
    return _StringFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StringFutureProvider &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StringFutureRef on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `family` of this provider.
  String get family;

  /// The parameter `second` of this provider.
  String get second;
}

class _StringFutureProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StringFuture, String>
    with StringFutureRef {
  _StringFutureProviderElement(super.provider);

  @override
  String get family => (origin as StringFutureProvider).family;
  @override
  String get second => (origin as StringFutureProvider).second;
}

String _$stringFutureOptionalHash() =>
    r'942d1983f5ab7c7ac89259cdd231af0536a9c373';

abstract class _$StringFutureOptional
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final int a;
  late final String family;
  late final String? second;

  FutureOr<String> build(
    int a, {
    required String family,
    String? second,
  });
}

/// See also [StringFutureOptional].
@ProviderFor(StringFutureOptional)
const stringFutureOptionalProvider = StringFutureOptionalFamily();

/// See also [StringFutureOptional].
class StringFutureOptionalFamily extends Family<AsyncValue<String>> {
  /// See also [StringFutureOptional].
  const StringFutureOptionalFamily();

  /// See also [StringFutureOptional].
  StringFutureOptionalProvider call(
    int a, {
    required String family,
    String? second,
  }) {
    return StringFutureOptionalProvider(
      a,
      family: family,
      second: second,
    );
  }

  @override
  StringFutureOptionalProvider getProviderOverride(
    covariant StringFutureOptionalProvider provider,
  ) {
    return call(
      provider.a,
      family: provider.family,
      second: provider.second,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stringFutureOptionalProvider';
}

/// See also [StringFutureOptional].
class StringFutureOptionalProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StringFutureOptional, String> {
  /// See also [StringFutureOptional].
  StringFutureOptionalProvider(
    int a, {
    required String family,
    String? second,
  }) : this._internal(
          () => StringFutureOptional()
            ..a = a
            ..family = family
            ..second = second,
          from: stringFutureOptionalProvider,
          name: r'stringFutureOptionalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stringFutureOptionalHash,
          dependencies: StringFutureOptionalFamily._dependencies,
          allTransitiveDependencies:
              StringFutureOptionalFamily._allTransitiveDependencies,
          a: a,
          family: family,
          second: second,
        );

  StringFutureOptionalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.a,
    required this.family,
    required this.second,
  }) : super.internal();

  final int a;
  final String family;
  final String? second;

  @override
  FutureOr<String> runNotifierBuild(
    covariant StringFutureOptional notifier,
  ) {
    return notifier.build(
      a,
      family: family,
      second: second,
    );
  }

  @override
  Override overrideWith(StringFutureOptional Function() create) {
    return ProviderOverride(
      origin: this,
      override: StringFutureOptionalProvider._internal(
        () => create()
          ..a = a
          ..family = family
          ..second = second,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        a: a,
        family: family,
        second: second,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StringFutureOptional, String>
      createElement() {
    return _StringFutureOptionalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StringFutureOptionalProvider &&
        other.a == a &&
        other.family == family &&
        other.second == second;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);
    hash = _SystemHash.combine(hash, second.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StringFutureOptionalRef on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `a` of this provider.
  int get a;

  /// The parameter `family` of this provider.
  String get family;

  /// The parameter `second` of this provider.
  String? get second;
}

class _StringFutureOptionalProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StringFutureOptional,
        String> with StringFutureOptionalRef {
  _StringFutureOptionalProviderElement(super.provider);

  @override
  int get a => (origin as StringFutureOptionalProvider).a;
  @override
  String get family => (origin as StringFutureOptionalProvider).family;
  @override
  String? get second => (origin as StringFutureOptionalProvider).second;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
