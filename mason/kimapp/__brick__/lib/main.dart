import 'package:flutter/foundation.dart' show kDebugMode, kReleaseMode;
import 'package:logger/logger.dart';

import 'exports.dart';
import 'src/presentation/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    // handle with error
  FlutterError.onError = _handleFlutterError;
  if (kReleaseMode) {
    ErrorWidget.builder = (details) => const SizedBox();
  }

  // initial
  await initializeSupabase();
  await EasyLocalization.ensureInitialized();
  await Kimapp.initialize(
    debugMode: kDebugMode,
    customFailureMessage: CustomFailureMessage(),
    logger: _logger,
  );

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale("en"), Locale("km")],
      fallbackLocale: const Locale('km'),
      child: ProviderScope(
        observers: [ProviderLogger(), ProviderCrashlytics()],
        child: const AppWidget(),
      ),
    ),
  );
}

Future<void> _handleFlutterError(FlutterErrorDetails details) async {
  _prettyLogger.d('caught flutter error');
  _prettyLogger.e(details.exceptionAsString(), error: details.exception, stackTrace: details.stack);

  if (kReleaseMode) {
    Zone.current.handleUncaughtError(details.exception, details.stack!);
    await Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  } else {
    FlutterError.dumpErrorToConsole(details);
  }
}

void _logger(LoggerType type, String message,
    [String? title, StackTrace? stackTrace, Object? errorObject,]) async {
  if (type == LoggerType.error) {
    _prettyLogger.e(message, error: errorObject, stackTrace: stackTrace);
    if (!kDebugMode) {
      await Sentry.captureException(
        errorObject,
        stackTrace: stackTrace,
      );
    }
  }
}

final _prettyLogger = Logger(
  printer: PrettyPrinter(colors: true, printEmojis: true, printTime: true, methodCount: 0),
);
