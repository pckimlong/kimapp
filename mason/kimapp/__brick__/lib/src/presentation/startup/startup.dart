import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../exports.dart';
import '../app/app_widget.dart';
import '../modules/splash/splash_widget.dart';
import 'tasks/init_app_setting_task.dart';
import 'tasks/init_device_info_task.dart';
import 'tasks/init_error_reporter_task.dart';
import 'tasks/init_flutter_error_catcher_task.dart';
import 'tasks/init_kimapp_task.dart';
import 'tasks/init_local_storage_task.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MaterialApp(home: SplashWidget(loadedInMain: true)));

    final container = ProviderContainer(observers: [ProviderLogger(), ProviderCrashlytics()]);
    final context = LaunchContext(container, env, platformType, config);

    const tasks = [
      InitLocalStorageTask(),
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
      ProviderScope(
        parent: container,
        child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale("en"), Locale("km")],
          fallbackLocale: const Locale('km'),
          child: app,
        ),
      ),
    );
  }
}

class LaunchConfiguration {
  const LaunchConfiguration();
}

abstract class LaunchTask with LoggerMixin {
  const LaunchTask();

  Future<void> initialize(LaunchContext context);

  Future<void> _initialize(LaunchContext context) async {
    await initialize(context);
    log.i('Initialized ${runtimeType.toString()}');
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

enum IntegrationMode {
  develop,
  release,
  unitTest,
  integrationTest;

  bool get isTest => isUnitTest || isIntegrationTest;
  bool get isUnitTest => this == IntegrationMode.unitTest;
  bool get isIntegrationTest => this == IntegrationMode.integrationTest;
  bool get isRelease => this == IntegrationMode.release;
  bool get isDevelop => this == IntegrationMode.develop;
}

IntegrationMode get integrationMode {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return IntegrationMode.unitTest;
  }

  if (kReleaseMode) {
    return IntegrationMode.release;
  }

  return IntegrationMode.develop;
}

enum PlatformType {
  android,
  ios,
  web,
  macos,
  windows,
  linux;

  bool get isAndroid => this == PlatformType.android;
  bool get isIos => this == PlatformType.ios;
  bool get isWeb => this == PlatformType.web;
  bool get isMacos => this == PlatformType.macos;
  bool get isWindows => this == PlatformType.windows;
  bool get isLinux => this == PlatformType.linux;
}

PlatformType get platformType {
  if (kIsWeb) {
    return PlatformType.web;
  }

  if (Platform.isAndroid) {
    return PlatformType.android;
  }

  if (Platform.isIOS) {
    return PlatformType.ios;
  }

  if (Platform.isMacOS) {
    return PlatformType.macos;
  }

  if (Platform.isWindows) {
    return PlatformType.windows;
  }

  if (Platform.isLinux) {
    return PlatformType.linux;
  }

  throw UnsupportedError('Unsupported platform');
}
