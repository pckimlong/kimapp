import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../exports.dart';
import '../app/app_widget.dart';
import '../modules/splash/splash_widget.dart';
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
    _setIntegrationMode(env);
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

void _setIntegrationMode(IntegrationMode mode) {
  _integrationMode = mode;
}

// User defined integration mode, if not set, it will be determined by the platform
IntegrationMode? _integrationMode;
IntegrationMode get integrationMode {
  if (_integrationMode != null) {
    return _integrationMode!;
  }

  if (platformType.isWeb) {
    if (kDebugMode) {
      return IntegrationMode.develop;
    }

    return IntegrationMode.release;
  } else {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return IntegrationMode.unitTest;
    }

    if (kReleaseMode) {
      return IntegrationMode.release;
    }

    return IntegrationMode.develop;
  }
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
  } else {
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
  }

  throw UnsupportedError('Unsupported platform');
}
