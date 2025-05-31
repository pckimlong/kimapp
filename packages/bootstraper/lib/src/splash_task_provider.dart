part of 'bootstrap.dart';

final _statelessSplashTaskProvider = FutureProvider<bool>((ref) async {
  if (ref.state.valueOrNull != true) {
    final splashConfig = ref.watch(_splashConfigProvider);
    final tasks = (splashConfig?.tasks ?? []).whereType<StatelessSplashTask>();
    if (tasks.isEmpty) return true;
    final context = SplashContext(ref);

    final start = DateTime.now();
    await Future.wait(tasks.map((e) => e.execute(context)));
    final elapsed = DateTime.now().difference(start);
    if (elapsed < (splashConfig?.minimumDuration ?? Duration.zero)) {
      await Future.delayed(splashConfig!.minimumDuration - elapsed);
    }
  }

  await ref.watch(_statefulSplashTaskProvider.future);
  return true;
});

/// A provider that manages the splash screen tasks and their execution.
/// This is a keep alive provider which will only run once.
final _statefulSplashTaskProvider = FutureProvider.autoDispose<bool>((ref) async {
  final splashConfig = ref.watch(_splashConfigProvider);
  final tasks = (splashConfig?.tasks ?? []).whereType<StatefulSplashTask>();
  if (tasks.isEmpty) return true;
  final context = SplashContext(ref);

  for (final task in tasks) {
    final disposable = await task.execute(context);
    if (disposable != null) {
      ref.onDispose(disposable);
    }
  }

  return true;
});
