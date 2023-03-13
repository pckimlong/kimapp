import 'package:flutter_test/flutter_test.dart';
import 'package:sok_chea_sihanouk_clinic/exports.dart';

extension AppSetUp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    ProviderContainer? container,
    List<Override> overrides = const [],
  }) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    WidgetsApp.debugAllowBannerOverride = false;

    await Kimapp.initialize(debugMode: true);

    await pumpWidget(
      ProviderScope(
        parent: container,
        overrides: overrides,
        child: MaterialApp(home: widget),
      ),
    );
  }
}
