import '../../app/app_theme_provider.dart';
import '../startup.dart';

class InitAppSettingTask extends StartUpTask {
  const InitAppSettingTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    await context.container.read(appThemeModeProvider.future);
  }
}
