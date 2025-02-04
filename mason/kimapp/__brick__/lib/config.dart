class Config {
  const Config._();

  static const appName = "{{project_name.sentenceCase()}}";

  /// Enable riverpod observers
  static const bool logRiverpod = true;

  /// Enable riverpod observers on error state
  static const bool logRiverpodError = true;

  static const int minSplashDurationInMs = 800;
}
