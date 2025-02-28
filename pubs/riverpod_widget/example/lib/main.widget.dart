// **************************************************************************
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// coverage:ignore-file

import 'dart:core';

import 'package:example/main.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

class _AgeProxyWidgetRef extends WidgetRef {
  _AgeProxyWidgetRef(this._ref);

  final WidgetRef _ref;

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
  }) =>
      _ref.listen(provider, listener, onError: onError);

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
    bool fireImmediately = false,
  }) =>
      _ref.listenManual(
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

class AgeProviderScope extends ConsumerWidget {
  const AgeProviderScope({
    super.key,
    this.loading,
    this.error,
    this.data,
    this.builder,
    this.child,
    this.onStateChanged,
  });

  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget Function(IList<int> data)? data;
  final Widget Function(
    BuildContext context,
    _AgeProxyWidgetRef ref,
    AsyncValue<IList<int>> asyncValue,
    Widget? child,
  )? builder;
  final Widget? child;
  final void Function(
    AsyncValue<IList<int>>? previous,
    AsyncValue<IList<int>> next,
  )? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onStateChanged != null) {
      ref.listen(ageProvider, onStateChanged!);
    }

    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(ageProvider);

        if (builder != null) {
          return builder!(context, _AgeProxyWidgetRef(ref), state, child);
        }

        final themeExtension = Theme.of(context).extension<KimappThemeExtension>();
        return state.when(
          data: (data) {
            final result = this.data?.call(data) ?? child;
            if (result == null) {
              debugPrint(
                'No child provided for AgeProviderScope. Empty SizedBox will be returned.',
              );
              return const SizedBox.shrink();
            }
            return result;
          },
          error: (error, stack) =>
              this.error?.call(error, stack) ??
              themeExtension?.defaultErrorStateWidget?.call(
                context,
                ref,
                error,
              ) ??
              const SizedBox.shrink(),
          loading: () =>
              loading?.call() ??
              themeExtension?.defaultLoadingStateWidget?.call(
                context,
                ref,
              ) ??
              const SizedBox.shrink(),
        );
      },
    );
  }
}

bool _debugCheckHasAgeProviderScope(BuildContext context) {
  assert(() {
    if (context.widget is! AgeProviderScope &&
        context.findAncestorWidgetOfExactType<AgeProviderScope>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No AgeProviderScope found'),
        ErrorDescription(
          '${context.widget.runtimeType} widgets require a AgeProviderScope widget ancestor.',
        ),
      ]);
    }
    return true;
  }());
  return true;
}

class _AgeStateProxyWidgetRef extends _AgeProxyWidgetRef {
  _AgeStateProxyWidgetRef(super._ref);

  IList<int> get state => _ref.watch(ageProvider).requireValue;

  Selected select<Selected>(Selected Function(IList<int>) selector) =>
      _ref.watch(ageProvider.select((value) => selector(value.requireValue)));
}

class AgeStateWidget extends ConsumerWidget {
  const AgeStateWidget({
    super.key,
    required this.builder,
    this.child,
    this.onStateChanged,
  });

  /// The builder function that constructs the widget tree.
  /// Access the state directly via ref.state, which is equivalent to ref.watch(ageProvider)
  ///
  /// For selecting specific fields, use ref.select() - e.g. ref.select((value) => value.someField)
  /// The ref parameter provides type-safe access to the provider state and notifier
  final Widget Function(
    BuildContext context,
    _AgeProxyWidgetRef ref,
    Widget? child,
  ) builder;
  final Widget? child;
  final void Function(IList<int>? previous, IList<int>? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasAgeProviderScope(context);

    if (onStateChanged != null) {
      ref.listen(ageProvider, (pre, next) {
        if (pre != next) onStateChanged!(pre?.valueOrNull, next.valueOrNull);
      });
    }
    return builder(context, _AgeStateProxyWidgetRef(ref), child);
  }
}

class AgeSelectWidget<Selected> extends ConsumerWidget {
  const AgeSelectWidget({
    super.key,
    required this.selector,
    required this.builder,
    this.onStateChanged,
  });

  final Selected Function(IList<int> state) selector;
  final Widget Function(
    BuildContext context,
    _AgeStateProxyWidgetRef ref,
    Selected value,
  ) builder;
  final void Function(Selected? previous, Selected? next)? onStateChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _debugCheckHasAgeProviderScope(context);

    if (onStateChanged != null) {
      ref.listen(ageProvider.select((value) => selector(value.requireValue)), (
        pre,
        next,
      ) {
        if (pre != next) onStateChanged!(pre, next);
      });
    }
    final stateRef = _AgeStateProxyWidgetRef(ref);
    return builder(context, stateRef, stateRef.select(selector));
  }
}
