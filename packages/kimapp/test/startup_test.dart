import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kimapp/startup.dart';

void main() {
  group('IntegrationMode Tests', () {
    test('isTest returns true for test modes', () {
      expect(IntegrationMode.unitTest.isTest, isTrue);
      expect(IntegrationMode.integrationTest.isTest, isTrue);
      expect(IntegrationMode.develop.isTest, isFalse);
      expect(IntegrationMode.release.isTest, isFalse);
    });

    test('individual mode checks work correctly', () {
      expect(IntegrationMode.unitTest.isUnitTest, isTrue);
      expect(IntegrationMode.integrationTest.isIntegrationTest, isTrue);
      expect(IntegrationMode.release.isRelease, isTrue);
      expect(IntegrationMode.develop.isDevelop, isTrue);
    });

    test('setMode and getMode work correctly', () {
      IntegrationMode.setMode(IntegrationMode.develop);
      expect(IntegrationMode.getMode(), equals(IntegrationMode.develop));

      IntegrationMode.setMode(IntegrationMode.release);
      expect(IntegrationMode.getMode(), equals(IntegrationMode.release));
    });
  });

  group('PlatformType Tests', () {
    test('platform type getters work correctly', () {
      final webPlatform = PlatformType.web;
      expect(webPlatform.isWeb, isTrue);
      expect(webPlatform.isAndroid, isFalse);
      expect(webPlatform.isIos, isFalse);
      expect(webPlatform.isMacos, isFalse);
      expect(webPlatform.isWindows, isFalse);
      expect(webPlatform.isLinux, isFalse);

      final androidPlatform = PlatformType.android;
      expect(androidPlatform.isAndroid, isTrue);
      expect(androidPlatform.isWeb, isFalse);
    });

    test('getPlatform returns current platform type', () {
      if (kIsWeb) {
        expect(PlatformType.web.getPlatform(), equals(PlatformType.web));
      } else if (Platform.isAndroid) {
        expect(PlatformType.android.getPlatform(), equals(PlatformType.android));
      } else if (Platform.isIOS) {
        expect(PlatformType.ios.getPlatform(), equals(PlatformType.ios));
      } else if (Platform.isMacOS) {
        expect(PlatformType.macos.getPlatform(), equals(PlatformType.macos));
      } else if (Platform.isWindows) {
        expect(PlatformType.windows.getPlatform(), equals(PlatformType.windows));
      } else if (Platform.isLinux) {
        expect(PlatformType.linux.getPlatform(), equals(PlatformType.linux));
      }
    });
  });
}
