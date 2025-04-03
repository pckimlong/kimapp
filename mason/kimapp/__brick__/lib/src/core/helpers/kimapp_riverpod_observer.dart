import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

class KimappTalkerRiverpodObserver extends ProviderObserver {
  KimappTalkerRiverpodObserver({
    Talker? talker,
    this.settings = const TalkerRiverpodLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
  }

  final TalkerRiverpodLoggerSettings settings;

  late Talker _talker;

  @override
  @mustCallSuper
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    super.didAddProvider(provider, value, container);
    if (!settings.enabled || !settings.printProviderAdded) {
      return;
    }
    final accepted = settings.providerFilter?.call(provider) ?? true;
    if (!accepted) {
      return;
    }

    if (value is Iterable || (value is AsyncData && value.value is Iterable)) {
      final iterableValue = value is Iterable ? value : (value as AsyncData<Iterable>).value;
      _printIterable(provider, iterableValue);
      return;
    }

    if (value is Map || value is IMap) {
      _printMap(provider, value is IMap ? value.unlock : value as Map);
      return;
    }

    _talker.logCustom(
      RiverpodAddLog(
        provider: provider,
        value: value,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    super.didDisposeProvider(provider, container);
    if (!settings.enabled || !settings.printProviderDisposed) {
      return;
    }
    final accepted = settings.providerFilter?.call(provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodDisposeLog(
        provider: provider,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    super.didUpdateProvider(provider, previousValue, newValue, container);

    final isProviderStatusFailure = (newValue is ProviderStatus && newValue.isFailure);
    if (isProviderStatusFailure && settings.printFailFullData) {
      _talker.logCustom(
        RiverpodFailLog(
          provider: provider,
          providerError: newValue.failure!.runtimeType.toString() +
              (newValue.failure is Failure
                  ? newValue.failure!.message(false, true)
                  : newValue.failure.toString()),
          providerStackTrace: Trace.from(newValue.failure!.stackTrace).terse,
          settings: settings,
        ),
      );
      return;
    }

    if (newValue is AsyncError) {
      _talker.logCustom(
        RiverpodFailLog(
          provider: provider,
          providerError: newValue.error.runtimeType.toString() +
              (newValue.error is Failure
                  ? (newValue.error as Failure).message(false, true)
                  : newValue.error.toString()),
          providerStackTrace: Trace.from(newValue.stackTrace).terse,
          settings: settings,
        ),
      );
      return;
    }

    /// Ignore print failure, since it does above already, and also ignore if value is same as previous value
    if (newValue is ProviderStatusClassMixin && newValue.status.isFailure ||
        newValue == previousValue) {
      return;
    }

    if (newValue is Iterable || (newValue is AsyncData && newValue.value is Iterable)) {
      if (newValue != null) {
        final iterableValue =
            newValue is Iterable ? newValue : (newValue as AsyncData).valueOrNull as Iterable;
        _printIterable(provider, iterableValue);
        return;
      }
    }

    if (newValue is Map ||
        newValue is IMap ||
        (newValue is AsyncData && (newValue.value is Map || newValue.value is IMap))) {
      if (newValue != null) {
        final mapValue = newValue is Map
            ? newValue
            : newValue is IMap
                ? newValue.unlock
                : newValue is AsyncData<IMap>
                    ? (newValue).value.unlock
                    : (newValue as AsyncData<Map>).value;
        _printMap(provider, mapValue);
        return;
      }
    }

    if (!settings.enabled || !settings.printProviderUpdated) {
      return;
    }
    final accepted = settings.providerFilter?.call(provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodUpdateLog(
        provider: provider,
        previousValue: previousValue,
        newValue: newValue,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    super.providerDidFail(provider, error, stackTrace, container);
    if (!settings.enabled || !settings.printProviderFailed) {
      return;
    }
    final accepted = settings.providerFilter?.call(provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodFailLog(
        provider: provider,
        providerError: error.runtimeType.toString() +
            (error is Failure ? error.message(false, true) : error.toString()),
        providerStackTrace: Trace.from(stackTrace).terse,
        settings: settings,
      ),
    );
  }

  void _printIterable(ProviderBase<Object?> provider, Iterable value) {
    var limit = 5;

    // If the value is less than 3 times the limit, set the limit to the value length
    if (value.length < (limit * 2)) {
      limit = value.length;
    }
    final listString = value.take(limit).map((e) => e.toString()).join(',\n\t');
    final moreItems = value.length - limit;

    final valueString = value.isEmpty
        ? '[]'
        : '''Total length: ${value.length}\nRuntimeType: ${value.runtimeType}\n[
\t$listString,${moreItems > 0 ? '\n\t... \n\t+$moreItems more' : ''}
]''';
    _talker.logCustom(
      RiverpodAddLog(
        provider: provider,
        value: valueString,
        settings: settings,
      ),
    );
  }

  void _printMap(ProviderBase<Object?> provider, Map value) {
    var limit = 5;

    // If the value is less than 3 times the limit, set the limit to the value length
    if (value.length < (limit * 2)) {
      limit = value.length;
    }

    final entries = value.entries.take(limit);
    final mapString = entries.map((e) => '${e.key}: ${e.value}').join(',\n\t');
    final moreItems = value.length - limit;

    final valueString = value.isEmpty
        ? '{}'
        : '''Total entries: ${value.length}\nRuntimeType: ${value.runtimeType}\n{
\t$mapString,${moreItems > 0 ? '\n\t... \n\t+$moreItems more' : ''}
}''';
    _talker.logCustom(
      RiverpodAddLog(
        provider: provider,
        value: valueString,
        settings: settings,
      ),
    );
  }
}
