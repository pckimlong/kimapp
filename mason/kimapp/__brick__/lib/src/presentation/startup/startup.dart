import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import '../../../config.dart';
import '../app/app_widget.dart';
import '../../../src/core/helpers/flutter_talker.dart';
import '../../../src/core/helpers/kimapp_riverpod_observer.dart';
import 'tasks/init_app_setting_task.dart';
import 'tasks/init_cache_manager_task.dart';
import 'tasks/init_device_info_task.dart';
import 'tasks/init_error_reporter_task.dart';
import 'tasks/init_flutter_error_catcher_task.dart';
import 'tasks/init_kimapp_task.dart';
import 'tasks/init_localization_task.dart';
import 'tasks/init_platform_error_catcher_task.dart';
import 'tasks/init_supabase_task.dart';

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

    final taker = initFlutterTalker(env);
    final container = _createProviderContainer(taker);
    final context = LaunchContext(container, env, platformType, config, taker);

    const tasks = [
      InitKimappTask(),
      InitCacheManagerTask(),
      InitErrorReporterTask(),
      InitPlatformErrorCatcherTask(),
      InitFlutterErrorCatcherTask(),
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

  static ProviderContainer _createProviderContainer(Talker taker) {
    return ProviderContainer(
      overrides: [
        talkerProvider.overrideWithValue(taker),
      ],
      observers: [
        KimappTalkerRiverpodObserver(
          talker: taker,
          settings: Config.riverpodObserverSetting,
        ),
      ],
    );
  }
}

class LaunchConfiguration {
  const LaunchConfiguration();
}

abstract class StartUpTask {
  const StartUpTask();

  Future<void> initialize(LaunchContext context);

  Future<void> _initialize(LaunchContext context) async {
    try {
      await initialize(context);
      context.talker.info('Initialized ${runtimeType.toString()}');
    } catch (e, s) {
      context.talker.error("Error initial startup task: ${runtimeType.toString()}", e, s);
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
    this.talker,
  );

  LaunchConfiguration config;
  ProviderContainer container;
  IntegrationMode env;
  PlatformType platform;
  Talker talker;
}
