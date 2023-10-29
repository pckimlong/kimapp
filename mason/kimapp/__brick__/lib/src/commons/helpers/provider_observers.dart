import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:logger/logger.dart';

final _traceLogger = Logger(
  level: Level.trace,
  filter: DevelopmentFilter(),
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    printTime: true,
    methodCount: 0,
  ),
);

final _errorLogger = Logger(
  level: Level.error,
  filter: DevelopmentFilter(),
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    printTime: true,
    methodCount: 0,
    errorMethodCount: 0,
  ),
);

class ProviderLogger extends ProviderObserver {
  ProviderLogger();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (value is AsyncError) return;
    if (value is ProviderStatus && value.isFailure) return;

    _traceLogger.t(
      '🟩 DidAddProvider: ${provider.providerName}\n'
      '=> value: $value',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) return;
    if (newValue is ProviderStatus && newValue.isFailure) return;

    _traceLogger.t(
      '🔄 DidUpdateProvider: ${provider.providerName}\n'
      '=> oldValue: $previousValue\n'
      '=> newValue: $newValue',
    );
  }

  @override
  void didDisposeProvider(ProviderBase<dynamic> provider, ProviderContainer container) {
    _traceLogger.t('🗑️ DidDisposeProvider: ${provider.providerName}');
  }
}

class ProviderCrashlytics extends ProviderObserver {
  ProviderCrashlytics();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    final isAsyncError = value is AsyncError;
    final isProviderStatusFailure = value is ProviderStatus && value.isFailure;
    if (!isAsyncError && !isProviderStatusFailure) return;

    Object? error;
    if (value is AsyncError) {
      error = value.error;
    } else if (value is ProviderStatus) {
      error = value.failure?.logMessage();
    }

    StackTrace? stackTrace;
    if (value is AsyncError) {
      stackTrace = value.stackTrace;
    } else if (value is ProviderStatus) {
      stackTrace = value.failure?.stackTrace;
    }

    _errorLogger.e(
      'DidAddProvider: ${provider.providerName}\n'
      '=> error: $error\n'
      '=> stackTrace: $stackTrace',
      error: error,
    );
  }

  //This is temporary until https://github.com/rrousselGit/riverpod/issues/1580 is fixed.
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final isAsyncError = newValue is AsyncError;
    final isProviderStatusFailure = newValue is ProviderStatus && newValue.isFailure;
    if (!isAsyncError && !isProviderStatusFailure) return;

    Object? error;
    if (newValue is AsyncError) {
      error = newValue.error;
    } else if (newValue is ProviderStatus) {
      error = newValue.failure?.logMessage();
    }

    StackTrace? stackTrace;
    if (newValue is AsyncError) {
      stackTrace = newValue.stackTrace;
    } else if (newValue is ProviderStatus) {
      stackTrace = newValue.failure?.stackTrace;
    }

    _errorLogger.e(
      'ProviderDidFail: ${provider.providerName}\n'
      '=> oldValue: $previousValue\n'
      '=> error: $error\n'
      '=> stackTrace: $stackTrace',
      error: error,
    );
  }

  @override
  void providerDidFail(
    ProviderBase<dynamic> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    Object? errorObject;
    if (error is AsyncError) {
      errorObject = error.error;
    } else if (error is ProviderStatus) {
      errorObject = error.failure?.logMessage();
    }

    StackTrace? stackTraceObject;
    if (error is AsyncError) {
      stackTraceObject = error.stackTrace;
    } else if (error is ProviderStatus) {
      stackTraceObject = error.failure?.stackTrace;
    }

    _errorLogger.e(
      '⛔️ ProviderDidFail: ${provider.providerName}\n'
      '=> error: $errorObject\n'
      '=> stackTrace: $stackTraceObject',
      error: errorObject,
    );
  }
}

extension _ProviderBaseX on ProviderBase<dynamic> {
  String get providerName => (name ?? runtimeType).toString();
}
