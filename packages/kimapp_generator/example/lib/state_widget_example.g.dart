// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_widget_example.dart';

// **************************************************************************
// KimappStateWidgetGenerator
// **************************************************************************

/// A widget that provides access to the state of PrimativeClass.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed

///
/// Example usage:
/// ```dart
/// PrimativeClassProviderWidget(
///
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeClassStateWidget] - For direct state access
/// * [PrimativeClassStateSelectWidget] - For optimized state selection
class PrimativeClassProviderWidget extends StatelessWidget {
  const PrimativeClassProviderWidget({
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

/// A widget that provides direct access to the PrimativeClass state.
///
/// This widget requires a [PrimativeClassProviderWidget] ancestor
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

/// A widget that provides optimized access to a selected portion of the PrimativeClass state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeClassProviderWidget] ancestor to function.

///
/// Example usage:
/// ```dart
/// PrimativeClassStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeClassProviderWidget] - The required provider widget
/// * [PrimativeClassStateWidget] - For direct state access
class PrimativeClassStateSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeClassStateSelectWidget({
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

/// A widget that provides access to the state of StringFuture.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed
///
/// For asynchronous states, additional callbacks are available:
/// * [loading] - Custom widget for loading state
/// * [error] - Custom widget for error state
/// * [data] - Custom widget for data state
///
/// This widget integrates with [KimappThemeExtension] to provide default loading
/// and error widgets. To use this functionality:
///
/// 1. Add kimapp_utils to your pubspec.yaml:
/// ```yaml
/// dependencies:
///   kimapp_utils: ^latest_version
/// ```
///
/// 2. Configure KimappThemeExtension in your app theme:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const CircularProgressIndicator(),
///         defaultErrorStateWidget: (context, ref, error) => Text(error.toString()),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// Example usage:
/// ```dart
/// StringFutureProviderWidget(
///   family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },    ///   loading: () => const CircularProgressIndicator(),
///   error: (error, stack) => Text('Error: $error'),
///   data: (data) => Text(data.toString()),
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [StringFutureStateWidget] - For direct state access
/// * [StringFutureStateSelectWidget] - For optimized state selection
class StringFutureProviderWidget extends StatelessWidget {
  const StringFutureProviderWidget({
    super.key,
    required this.family,
    required this.second,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  });

  final String family;
  final String second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(String data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<String> state,
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
                          'No child provided for StringFutureProviderWidget. Empty SizedBox will be returned.');
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

bool _debugCheckHasStringFutureProviderWidget(BuildContext context) {
  assert(() {
    if (context.widget is! StringFutureProviderWidget &&
        context.findAncestorWidgetOfExactType<StringFutureProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No StringFutureProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a StringFutureProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the StringFuture state.
///
/// This widget requires a [StringFutureProviderWidget] ancestor
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
    _debugCheckHasStringFutureProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the StringFuture state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [StringFutureProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// StringFutureStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [StringFutureProviderWidget] - The required provider widget
/// * [StringFutureStateWidget] - For direct state access
class StringFutureStateSelectWidget<Selected> extends ConsumerWidget {
  const StringFutureStateSelectWidget({
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
    _debugCheckHasStringFutureProviderWidget(context);

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

/// A widget that provides access to the state of StringFutureOptional.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed
///
/// For asynchronous states, additional callbacks are available:
/// * [loading] - Custom widget for loading state
/// * [error] - Custom widget for error state
/// * [data] - Custom widget for data state
///
/// This widget integrates with [KimappThemeExtension] to provide default loading
/// and error widgets. To use this functionality:
///
/// 1. Add kimapp_utils to your pubspec.yaml:
/// ```yaml
/// dependencies:
///   kimapp_utils: ^latest_version
/// ```
///
/// 2. Configure KimappThemeExtension in your app theme:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const CircularProgressIndicator(),
///         defaultErrorStateWidget: (context, ref, error) => Text(error.toString()),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// Example usage:
/// ```dart
/// StringFutureOptionalProviderWidget(
///   a: a,
/// family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },    ///   loading: () => const CircularProgressIndicator(),
///   error: (error, stack) => Text('Error: $error'),
///   data: (data) => Text(data.toString()),
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [StringFutureOptionalStateWidget] - For direct state access
/// * [StringFutureOptionalStateSelectWidget] - For optimized state selection
class StringFutureOptionalProviderWidget extends StatelessWidget {
  const StringFutureOptionalProviderWidget({
    super.key,
    required this.a,
    required this.family,
    this.second,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  });

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
    AsyncValue<String> state,
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
                          'No child provided for StringFutureOptionalProviderWidget. Empty SizedBox will be returned.');
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

bool _debugCheckHasStringFutureOptionalProviderWidget(BuildContext context) {
  assert(() {
    if (context.widget is! StringFutureOptionalProviderWidget &&
        context.findAncestorWidgetOfExactType<
                StringFutureOptionalProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No StringFutureOptionalProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a StringFutureOptionalProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the StringFutureOptional state.
///
/// This widget requires a [StringFutureOptionalProviderWidget] ancestor
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
    _debugCheckHasStringFutureOptionalProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the StringFutureOptional state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [StringFutureOptionalProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// StringFutureOptionalStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [StringFutureOptionalProviderWidget] - The required provider widget
/// * [StringFutureOptionalStateWidget] - For direct state access
class StringFutureOptionalStateSelectWidget<Selected> extends ConsumerWidget {
  const StringFutureOptionalStateSelectWidget({
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
    _debugCheckHasStringFutureOptionalProviderWidget(context);

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

/// A widget that provides access to the state of primative.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed

///
/// Example usage:
/// ```dart
/// PrimativeProviderWidget(
///
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeStateWidget] - For direct state access
/// * [PrimativeStateSelectWidget] - For optimized state selection
class PrimativeProviderWidget extends StatelessWidget {
  const PrimativeProviderWidget({
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

/// A widget that provides direct access to the primative state.
///
/// This widget requires a [PrimativeProviderWidget] ancestor
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

/// A widget that provides optimized access to a selected portion of the primative state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeProviderWidget] ancestor to function.

///
/// Example usage:
/// ```dart
/// PrimativeStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeProviderWidget] - The required provider widget
/// * [PrimativeStateWidget] - For direct state access
class PrimativeStateSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeStateSelectWidget({
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

/// A widget that provides access to the state of primativeFaimily.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed

///
/// Example usage:
/// ```dart
/// PrimativeFaimilyProviderWidget(
///   family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyStateWidget] - For direct state access
/// * [PrimativeFaimilyStateSelectWidget] - For optimized state selection
class PrimativeFaimilyProviderWidget extends StatelessWidget {
  const PrimativeFaimilyProviderWidget({
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

bool _debugCheckHasPrimativeFaimilyProviderWidget(BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyProviderWidget &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the primativeFaimily state.
///
/// This widget requires a [PrimativeFaimilyProviderWidget] ancestor
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
    _debugCheckHasPrimativeFaimilyProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the primativeFaimily state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeFaimilyProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyProviderWidget] - The required provider widget
/// * [PrimativeFaimilyStateWidget] - For direct state access
class PrimativeFaimilyStateSelectWidget<Selected> extends ConsumerWidget {
  const PrimativeFaimilyStateSelectWidget({
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
    _debugCheckHasPrimativeFaimilyProviderWidget(context);

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

/// A widget that provides access to the state of primativeFaimilyRequired.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed

///
/// Example usage:
/// ```dart
/// PrimativeFaimilyRequiredProviderWidget(
///   family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyRequiredStateWidget] - For direct state access
/// * [PrimativeFaimilyRequiredStateSelectWidget] - For optimized state selection
class PrimativeFaimilyRequiredProviderWidget extends StatelessWidget {
  const PrimativeFaimilyRequiredProviderWidget({
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

bool _debugCheckHasPrimativeFaimilyRequiredProviderWidget(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyRequiredProviderWidget &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyRequiredProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyRequiredProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyRequiredProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the primativeFaimilyRequired state.
///
/// This widget requires a [PrimativeFaimilyRequiredProviderWidget] ancestor
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
    _debugCheckHasPrimativeFaimilyRequiredProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the primativeFaimilyRequired state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeFaimilyRequiredProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyRequiredStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyRequiredProviderWidget] - The required provider widget
/// * [PrimativeFaimilyRequiredStateWidget] - For direct state access
class PrimativeFaimilyRequiredStateSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyRequiredStateSelectWidget({
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
    _debugCheckHasPrimativeFaimilyRequiredProviderWidget(context);

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

/// A widget that provides access to the state of primativeFaimilyWithDefault.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed

///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultProviderWidget(
///   family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultStateWidget] - For direct state access
/// * [PrimativeFaimilyWithDefaultStateSelectWidget] - For optimized state selection
class PrimativeFaimilyWithDefaultProviderWidget extends StatelessWidget {
  const PrimativeFaimilyWithDefaultProviderWidget({
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

bool _debugCheckHasPrimativeFaimilyWithDefaultProviderWidget(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyWithDefaultProviderWidget &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyWithDefaultProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyWithDefaultProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyWithDefaultProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the primativeFaimilyWithDefault state.
///
/// This widget requires a [PrimativeFaimilyWithDefaultProviderWidget] ancestor
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
    _debugCheckHasPrimativeFaimilyWithDefaultProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the primativeFaimilyWithDefault state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeFaimilyWithDefaultProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultProviderWidget] - The required provider widget
/// * [PrimativeFaimilyWithDefaultStateWidget] - For direct state access
class PrimativeFaimilyWithDefaultStateSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultStateSelectWidget({
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
    _debugCheckHasPrimativeFaimilyWithDefaultProviderWidget(context);

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

/// A widget that provides access to the state of primativeFaimilyWithDefaultAsync.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed
///
/// For asynchronous states, additional callbacks are available:
/// * [loading] - Custom widget for loading state
/// * [error] - Custom widget for error state
/// * [data] - Custom widget for data state
///
/// This widget integrates with [KimappThemeExtension] to provide default loading
/// and error widgets. To use this functionality:
///
/// 1. Add kimapp_utils to your pubspec.yaml:
/// ```yaml
/// dependencies:
///   kimapp_utils: ^latest_version
/// ```
///
/// 2. Configure KimappThemeExtension in your app theme:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const CircularProgressIndicator(),
///         defaultErrorStateWidget: (context, ref, error) => Text(error.toString()),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncProviderWidget(
///   family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },    ///   loading: () => const CircularProgressIndicator(),
///   error: (error, stack) => Text('Error: $error'),
///   data: (data) => Text(data.toString()),
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultAsyncStateWidget] - For direct state access
/// * [PrimativeFaimilyWithDefaultAsyncStateSelectWidget] - For optimized state selection
class PrimativeFaimilyWithDefaultAsyncProviderWidget extends StatelessWidget {
  const PrimativeFaimilyWithDefaultAsyncProviderWidget({
    super.key,
    required this.family,
    this.second,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  });

  final int family;
  final int? second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(int data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> state,
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
                          'No child provided for primativeFaimilyWithDefaultAsyncProviderWidget. Empty SizedBox will be returned.');
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

bool _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderWidget(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyWithDefaultAsyncProviderWidget &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyWithDefaultAsyncProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyWithDefaultAsyncProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyWithDefaultAsyncProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the primativeFaimilyWithDefaultAsync state.
///
/// This widget requires a [PrimativeFaimilyWithDefaultAsyncProviderWidget] ancestor
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
    _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the primativeFaimilyWithDefaultAsync state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeFaimilyWithDefaultAsyncProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultAsyncStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultAsyncProviderWidget] - The required provider widget
/// * [PrimativeFaimilyWithDefaultAsyncStateWidget] - For direct state access
class PrimativeFaimilyWithDefaultAsyncStateSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultAsyncStateSelectWidget({
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
    _debugCheckHasPrimativeFaimilyWithDefaultAsyncProviderWidget(context);

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

/// A widget that provides access to the state of primativeFaimilyWithDefaultStream.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed
///
/// For asynchronous states, additional callbacks are available:
/// * [loading] - Custom widget for loading state
/// * [error] - Custom widget for error state
/// * [data] - Custom widget for data state
///
/// This widget integrates with [KimappThemeExtension] to provide default loading
/// and error widgets. To use this functionality:
///
/// 1. Add kimapp_utils to your pubspec.yaml:
/// ```yaml
/// dependencies:
///   kimapp_utils: ^latest_version
/// ```
///
/// 2. Configure KimappThemeExtension in your app theme:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       KimappThemeExtension(
///         defaultLoadingStateWidget: (context, ref) => const CircularProgressIndicator(),
///         defaultErrorStateWidget: (context, ref, error) => Text(error.toString()),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamProviderWidget(
///   family: family,
/// second: second,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },    ///   loading: () => const CircularProgressIndicator(),
///   error: (error, stack) => Text('Error: $error'),
///   data: (data) => Text(data.toString()),
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultStreamStateWidget] - For direct state access
/// * [PrimativeFaimilyWithDefaultStreamStateSelectWidget] - For optimized state selection
class PrimativeFaimilyWithDefaultStreamProviderWidget extends StatelessWidget {
  const PrimativeFaimilyWithDefaultStreamProviderWidget({
    super.key,
    required this.family,
    this.second = 1,
    this.child,
    this.loading,
    this.error,
    this.data,
    this.builder,
  });

  final int family;
  final int second;
  final Widget? child;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(int data)? data;
  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> state,
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
                          'No child provided for primativeFaimilyWithDefaultStreamProviderWidget. Empty SizedBox will be returned.');
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

bool _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderWidget(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyWithDefaultStreamProviderWidget &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyWithDefaultStreamProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            'No PrimativeFaimilyWithDefaultStreamProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyWithDefaultStreamProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the primativeFaimilyWithDefaultStream state.
///
/// This widget requires a [PrimativeFaimilyWithDefaultStreamProviderWidget] ancestor
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
    _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the primativeFaimilyWithDefaultStream state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeFaimilyWithDefaultStreamProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyWithDefaultStreamStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyWithDefaultStreamProviderWidget] - The required provider widget
/// * [PrimativeFaimilyWithDefaultStreamStateWidget] - For direct state access
class PrimativeFaimilyWithDefaultStreamStateSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyWithDefaultStreamStateSelectWidget({
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
    _debugCheckHasPrimativeFaimilyWithDefaultStreamProviderWidget(context);

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

/// A widget that provides access to the state of primativeFaimilyOptional.
///
/// This widget serves as a provider for state management and must be an ancestor
/// of any widgets that need to access the state. It offers flexible state handling
/// through various callback options:
///
/// * [builder] - A callback that provides complete control over widget building
/// * [child] - A default widget to display when no specific builder logic is needed

///
/// Example usage:
/// ```dart
/// PrimativeFaimilyOptionalProviderWidget(
///   family: family,
///   builder: (context, ref, state, child) {
///     return Text(state.toString());
///   },
///   child: const Text('Default Content'),
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyOptionalStateWidget] - For direct state access
/// * [PrimativeFaimilyOptionalStateSelectWidget] - For optimized state selection
class PrimativeFaimilyOptionalProviderWidget extends StatelessWidget {
  const PrimativeFaimilyOptionalProviderWidget({
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

bool _debugCheckHasPrimativeFaimilyOptionalProviderWidget(
    BuildContext context) {
  assert(() {
    if (context.widget is! PrimativeFaimilyOptionalProviderWidget &&
        context.findAncestorWidgetOfExactType<
                PrimativeFaimilyOptionalProviderWidget>() ==
            null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No PrimativeFaimilyOptionalProviderWidget found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a PrimativeFaimilyOptionalProviderWidget widget ancestor.',
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

/// A widget that provides direct access to the primativeFaimilyOptional state.
///
/// This widget requires a [PrimativeFaimilyOptionalProviderWidget] ancestor
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
    _debugCheckHasPrimativeFaimilyOptionalProviderWidget(context);

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

/// A widget that provides optimized access to a selected portion of the primativeFaimilyOptional state.
///
/// This widget enables efficient state management by:
/// * Selecting and watching specific parts of the state using [selector]
/// * Rebuilding only when the selected value changes
/// * Providing type-safe access to the selected state portion
///
/// Key benefits:
/// * Improved performance through selective rebuilds
/// * Clean separation of state selection and UI logic
/// * Type-safe state handling with generics support
///
/// Note: Requires a [PrimativeFaimilyOptionalProviderWidget] ancestor to function.
///
/// Family parameters are automatically inherited from the provider ancestor.
///
/// Example usage:
/// ```dart
/// PrimativeFaimilyOptionalStateSelectWidget<String>(
///   selector: (state) => state.specificField,
///   builder: (context, ref, params, selected, child) {
///     return Text(selected);
///   },
/// )
/// ```
///
/// See also:
/// * [PrimativeFaimilyOptionalProviderWidget] - The required provider widget
/// * [PrimativeFaimilyOptionalStateWidget] - For direct state access
class PrimativeFaimilyOptionalStateSelectWidget<Selected>
    extends ConsumerWidget {
  const PrimativeFaimilyOptionalStateSelectWidget({
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
    _debugCheckHasPrimativeFaimilyOptionalProviderWidget(context);

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
