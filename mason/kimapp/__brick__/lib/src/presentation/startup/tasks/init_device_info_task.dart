import '../../../../exports.dart';
import '../startup.dart';

class InitDeviceInfoTask extends StartUpTask {
  const InitDeviceInfoTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await context.container.read(deviceInfoProvider.future);
  }
}
