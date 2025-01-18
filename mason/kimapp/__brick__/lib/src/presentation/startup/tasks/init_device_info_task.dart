import '../../../core/device/device_info_provider.dart';
import '../startup.dart';

class InitDeviceInfoTask extends StartUpTask {
  const InitDeviceInfoTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await context.container.read(deviceInfoProvider.future);
  }
}
