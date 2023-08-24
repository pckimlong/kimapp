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
    logger: (type, message, [title, stackTrace, errorObject]) {
      if (type == LoggerType.error) {
        _prettyLogger.e(message, error: errorObject, stackTrace: stackTrace);
      }
    },
  );

  runApp(
      EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [Locale("en"), Locale("km")],
        fallbackLocale: const Locale('km'),
        child: ProviderScope(
          observers: [RiverpodLogger()],
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
  } else {
    FlutterError.dumpErrorToConsole(details);
  }
}

final _prettyLogger = Logger(
  printer: PrettyPrinter(colors: true, printEmojis: true, printTime: true, methodCount: 0),
);
