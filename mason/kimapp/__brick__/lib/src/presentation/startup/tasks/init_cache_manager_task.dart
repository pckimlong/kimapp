import '../../../core/cache_manager/cache_manager.dart';
import '../startup.dart';

/// This task is used to initialize the location storage.
/// This should be called first before any other task
/// because other tasks may need to use this
class InitCacheManagerTask extends StartUpTask {
  const InitCacheManagerTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await context.container.read(cacheManagerProvider.future);
  }
}
