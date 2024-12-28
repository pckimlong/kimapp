import 'package:logger/logger.dart';

final _logger = Logger(
  level: Level.all,
  filter: DevelopmentFilter(),
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    printTime: true,
    methodCount: 0,
    errorMethodCount: 0,
  ),
);

mixin LoggerMixin {
  Logger get log => _logger;
  static Logger get logger => _logger;
}
