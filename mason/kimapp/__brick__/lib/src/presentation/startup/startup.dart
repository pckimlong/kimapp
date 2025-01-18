import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../config.dart';
import '../../core/helpers/helpers.dart';
import '../app/app_widget.dart';
import 'tasks/tasks.dart';

Future<void> runKimappApp({IntegrationMode? env, LaunchConfiguration? config}) async {
  await KimappRunner.run(
    const AppWidget(),
    env: env ?? integrationMode,
    config: config ?? const LaunchConfiguration(),
  );
}

class KimappRunner {
  static Future<void> run(
    Widget app, {
    required IntegrationMode env,
    LaunchConfiguration config = const LaunchConfiguration(),
  }) async {
    IntegrationMode.setMode(env);
    WidgetsFlutterBinding.ensureInitialized();

    final container = ProviderContainer(
      observers: [
        if (Config.logRiverpod) ProviderLogger(),
        if (Config.logRiverpodError) ProviderCrashlytics(),
      ],
    );
    final context = LaunchContext(container, env, platformType, config);

    const tasks = [
      InitCacheManagerTask(),
      InitErrorReporterTask(),
      InitPlatformErrorCatcherTask(),
      InitFlutterErrorCatcherTask(),
      InitKimappTask(),
      InitSupabaseTask(),
      InitLocalizationTask(),
      InitDeviceInfoTask(),
      InitAppSettingTask(),
    ];

    await Future.wait(tasks.map((task) => task._initialize(context)));

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale("en"), Locale("km")],
          fallbackLocale: const Locale('km'),
          child: DefaultAssetBundle(
            bundle: SentryAssetBundle(),
            child: app,
          ),
        ),
      ),
    );
  }
}

class LaunchConfiguration {
  const LaunchConfiguration();
}

abstract class StartUpTask with LoggerMixin {
  const StartUpTask();

  Future<void> initialize(LaunchContext context);

  Future<void> _initialize(LaunchContext context) async {
    try {
      await initialize(context);
      log.i('Initialized ${runtimeType.toString()}');
    } catch (e, s) {
      log.e("Error initial startup task: ${runtimeType.toString()}", stackTrace: s);
      rethrow;
    }
  }
}

class LaunchContext {
  LaunchContext(
    this.container,
    this.env,
    this.platform,
    this.config,
  );

  LaunchConfiguration config;
  ProviderContainer container;
  IntegrationMode env;
  PlatformType platform;
}
