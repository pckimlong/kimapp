import 'package:flutter/foundation.dart' show kDebugMode, kReleaseMode;

import 'package:logger/logger.dart';
import 'package:url_strategy/url_strategy.dart';

import 'exports.dart';
import 'src/core/errors/custom_failure_message.dart';
import 'src/presentation/app/app_widget.dart';
import 'src/core/helpers/logger_observers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  // handle with error
  FlutterError.onError = _handleFlutterError;
  if (kReleaseMode) {
    ErrorWidget.builder = (details) => const SizedBox();
  }

  // initial
  await initializeSupabase();
  await Kimapp.initialize(
    debugMode: kDebugMode,
    customFailureMessage: CustomFailureMessage(),
    logger: (type, message, [title, stackTrace, errorObject]) {
      if (type == LoggerType.error) {
        _prettyLogger.e(message, errorObject, stackTrace);
      }
    },
  );

  runZonedGuarded(
    () => runApp(
      ProviderScope(
        observers: [RiverpodLogger()],
        child: const AppWidget(),
      ),
    ),
    (error, stack) => _prettyLogger.e(error.toString(), error, stack),
  );
}

Future<void> _handleFlutterError(FlutterErrorDetails details) async {
  _prettyLogger.d('caught flutter error');
  _prettyLogger.e(details.exceptionAsString(), details.exception, details.stack);

  if (kReleaseMode) {
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  } else {
    FlutterError.dumpErrorToConsole(details);
  }
}

final _prettyLogger = Logger(
  printer: PrettyPrinter(colors: true, printEmojis: true, printTime: true, methodCount: 0),
);
