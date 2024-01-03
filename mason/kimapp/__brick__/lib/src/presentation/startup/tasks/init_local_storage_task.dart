import '../../../../exports.dart';
import '../startup.dart';

/// This task is used to initialize the location storage.
/// This should be called first before any other task
/// because other tasks may need to use this
class InitLocalStorageTask extends StartUpTask {
  const InitLocalStorageTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await context.container.read(localStorageProvider.future);
  }
}
