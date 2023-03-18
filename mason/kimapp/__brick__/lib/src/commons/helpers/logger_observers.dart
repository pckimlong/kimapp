import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../../exports.dart';

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

mixin LoggerMixin {
  Logger get log => _prettyLogger;
  void logErrorHandler(Object error, [StackTrace? stackTrace]) {
    _prettyLogger.i('silently ignoring error', error, stackTrace);
  }
}

final _prettyLogger = Logger(
  printer: PrettyPrinter(colors: true, printEmojis: true, printTime: true, methodCount: 0),
);
