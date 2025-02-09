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

  static const int minSplashDurationInMs = 800;
}
