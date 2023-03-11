import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:{{project_name.snakeCase()}}/src/core/errors/custom_failure_message.dart';
import 'package:logger/logger.dart';
import 'package:url_strategy/url_strategy.dart';
import 'exports.dart';
import 'src/presentation/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await Kimapp.initialize(
    debugMode: kDebugMode,
    customFailureMessage: CustomFailureMessage(),
    logger: (type, message, [title, stackTrace, errorObject]) {
      if (type == LoggerType.error) {
        _prettyLogger.e(message, errorObject, stackTrace);
      }
    },
  );

  runApp(
    ProviderScope(
      observers: [RiverpodLogger()],
      child: const AppWidget(),
    ),
  );
}

class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      _prettyLogger.i(
        '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''',
      );
    }
  }
}

final _prettyLogger = Logger(
    printer: PrettyPrinter(
  colors: true,
  printEmojis: true,
  printTime: true,
),);
