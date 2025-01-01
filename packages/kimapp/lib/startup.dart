import 'dart:io';

import 'package:flutter/foundation.dart';

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

  static void setMode(IntegrationMode mode) {
    _integrationMode = mode;
  }

  static IntegrationMode getMode() => integrationMode;
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

  PlatformType getPlatform() => platformType;
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
