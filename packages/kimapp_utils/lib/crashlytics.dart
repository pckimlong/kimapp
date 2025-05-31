abstract class Crashlytics {
  Future<void> report(String? message, Object? error, StackTrace? stackTrace);
}
