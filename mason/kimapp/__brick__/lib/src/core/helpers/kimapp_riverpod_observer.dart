import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

class KimappTalkerRiverpodObserver extends ProviderObserver {
  KimappTalkerRiverpodObserver({
    Talker? talker,
    this.settings = const TalkerRiverpodLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;
  final TalkerRiverpodLoggerSettings settings;

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
          providerError: newValue.failure!.message(),
          providerStackTrace: newValue.failure!.stackTrace,
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
        providerError: error is Failure ? error.message() : error.toString(),
        providerStackTrace: stackTrace,
        settings: settings,
      ),
    );
  }
}
