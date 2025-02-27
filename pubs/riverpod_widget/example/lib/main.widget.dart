// dart format width=80
// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// ignore_for_file: type=lint
// coverage:ignore-file

import 'package:example/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class _AnimalInheritedWidget extends InheritedWidget {
  const _AnimalInheritedWidget({
    super.key,
    required this.params,
    required super.child,
  });

  final ({String animalName, int age}) params;

  static _AnimalInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AnimalInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant _AnimalInheritedWidget oldWidget) {
    return params != oldWidget.params;
  }
}

class _AnimalProxyWidgetRef extends WidgetRef {
  _AnimalProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  Animal get notifier => _ref.read(
    animalProvider(animalName: params.animalName, age: params.age).notifier,
  );

  ({String animalName, int age}) get params =>
      _AnimalInheritedWidget.of(context).params;

  @override
  BuildContext get context => _ref.context;

  @override
  bool exists(ProviderBase<Object?> provider) => _ref.exists(provider);

  @override
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);

  @override
  void listen<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
  }) => _ref.listen(provider, listener, onError: onError);

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
    bool fireImmediately = false,
  }) => _ref.listenManual(
    provider,
    listener,
    onError: onError,
    fireImmediately: fireImmediately,
  );

  @override
  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);

  @override
  State refresh<State>(Refreshable<State> provider) => _ref.refresh(provider);

  @override
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
}

class AnimalProviderScope extends ConsumerWidget {
  const AnimalProviderScope({
    super.key,
    required this.animalName,
    this.age = 1,
    this.loading,
    this.error,
    this.data,
    this.builder,
    this.child,
    this.onStateChanged,
  });

  final String animalName;
  final int age;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(AnimalModel data)? data;
  final Widget Function(
    BuildContext context,
    _AnimalProxyWidgetRef ref,
    AsyncValue<AnimalModel> asyncValue,
    Widget? child,
  )?
  builder;
  final Widget? child;
  final void Function(
    AsyncValue<AnimalModel>? previous,
    AsyncValue<AnimalModel> next,
  )?
  onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      ref.listen(
        animalProvider(animalName: animalName, age: age),
        onStateChanged!,
      );
    }

    return _AnimalInheritedWidget(
      params: (animalName: animalName, age: age),
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(
            animalProvider(animalName: animalName, age: age),
          );

          if (builder != null) {
            return builder!(context, _AnimalProxyWidgetRef(ref), state, child);
          }

          final themeExtension =
              Theme.of(context).extension<KimappThemeExtension>();
          return state.when(
            data: (data) {
              final result = this.data?.call(data) ?? child;
              if (result == null) {
                debugPrint(
                  'No child provided for AnimalProviderScope. Empty SizedBox will be returned.',
                );
                return const SizedBox.shrink();
              }
              return result;
            },
            error:
                (error, stack) =>
                    this.error?.call(error, stack) ??
                    themeExtension?.defaultErrorStateWidget?.call(
                      context,
                      ref,
                      error,
                    ) ??
                    const SizedBox.shrink(),
            loading:
                () =>
                    loading?.call() ??
                    themeExtension?.defaultLoadingStateWidget?.call(
                      context,
                      ref,
                    ) ??
                    const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

bool _debugCheckHasAnimalProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! AnimalProviderScope &&
        context.findAncestorWidgetOfExactType<AnimalProviderScope>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No AnimalProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a AnimalProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

class AnimalParamsWidget extends ConsumerWidget {
  const AnimalParamsWidget({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    _AnimalProxyWidgetRef ref,
    ({String animalName, int age}) params,
  )
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasAnimalProviderScope(context);

    final params = _AnimalInheritedWidget.of(context).params;
    return builder(context, _AnimalProxyWidgetRef(ref), params);
  }
}

class _AnimalStateProxyWidgetRef extends _AnimalProxyWidgetRef {
  _AnimalStateProxyWidgetRef(super._ref);

  AnimalModel get state =>
      _ref
          .watch(animalProvider(animalName: params.animalName, age: params.age))
          .requireValue;

  Selected select<Selected>(Selected Function(AnimalModel) selector) =>
      _ref.watch(
        animalProvider(
          animalName: params.animalName,
          age: params.age,
        ).select((value) => selector(value.requireValue)),
      );
}

class AnimalStateWidget extends ConsumerWidget {
  const AnimalStateWidget({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(animalProvider(animalName : params.animalName, age : params.age))
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    _AnimalProxyWidgetRef ref,
    Widget? child,
  )
  builder;
  final Widget? child;
  final void Function(AnimalModel? previous, AnimalModel? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      final params = _AnimalInheritedWidget.of(context).params;
      ref.listen(
        animalProvider(animalName: params.animalName, age: params.age),
        (pre, next) {
          if (pre != next) onStateChanged!(pre?.valueOrNull, next.valueOrNull);
        },
      );
    }
    return AnimalParamsWidget(
      builder: (context, ref, params) => builder(context, ref, child),
    );
  }
}

class AnimalSelectWidget<Selected> extends ConsumerWidget {
  const AnimalSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(AnimalModel state) selector;
  final Widget Function(
    BuildContext context,
    _AnimalStateProxyWidgetRef ref,
    Selected value,
  )
  builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasAnimalProviderScope(context);

    if (onStateChanged != null) {
      final params = _AnimalInheritedWidget.of(context).params;
      ref.listen(
        animalProvider(
          animalName: params.animalName,
          age: params.age,
        ).select((value) => selector(value.requireValue)),
        (pre, next) {
          if (pre != next) onStateChanged!(pre, next);
        },
      );
    }
    final stateRef = _AnimalStateProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}
