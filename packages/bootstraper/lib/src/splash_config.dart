part of 'bootstrap.dart';

final _splashConfigProvider = Provider<SplashConfig?>((ref) => null);

class SplashConfig {
  final Widget Function(Object? error, VoidCallback? retry) pageBuilder;

  final Duration minimumDuration;

  final List<SplashTaskBase> tasks;

  final bool showSplashWhenDependencyChanged;

  const SplashConfig({
    required this.pageBuilder,
    this.tasks = const [],
    this.minimumDuration = Duration.zero,
    this.showSplashWhenDependencyChanged = false,
  });
}
