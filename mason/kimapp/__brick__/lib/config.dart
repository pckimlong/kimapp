import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

class Config {
  const Config._();

  static const appName = "{{project_name.sentenceCase()}}";

  static final riverpodObserverSetting = TalkerRiverpodLoggerSettings(
    printStateFullData: false,
    printProviderFailed: true,
    printFailFullData: true,
    printProviderAdded: true,
    printProviderDisposed: true,
    printProviderUpdated: true,
  );

  /// Weather to print only fews item of [Iterable] in [Riverpod] logs.
  static const bool printShortRiverpodLogIterable = true;

  static const int minSplashDurationInMs = 800;
}
