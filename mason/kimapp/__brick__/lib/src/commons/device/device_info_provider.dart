import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';

part "device_info_provider.g.dart";

@Riverpod(keepAlive: true)
FutureOr<DeviceInfoModel> deviceInfo(DeviceInfoRef ref) {
  return getDeviceInfo();
}

Future<DeviceInfoModel> getDeviceInfo() async {
  String deviceIdentifier = "unknown";
  String deviceName = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (kIsWeb) {
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    deviceName = webInfo.browserName.name;
    deviceIdentifier =
        webInfo.vendor! + webInfo.userAgent! + webInfo.hardwareConcurrency.toString();
  } else {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
      deviceName = [
        if (androidInfo.brand.isNotNullOrBlank) androidInfo.brand,
        if (androidInfo.device.isNotNullOrBlank) androidInfo.model,
      ].join(' ');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor ?? '';
      deviceName = iosInfo.name ?? "IOS";
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
      deviceIdentifier = windowsDeviceInfo.deviceId;
      deviceIdentifier = windowsDeviceInfo.computerName;
    } else if (Platform.isMacOS) {
      final macInfo = await deviceInfo.macOsInfo;
      deviceIdentifier = macInfo.systemGUID ?? "MacOS";
      deviceName = macInfo.computerName;
    }
  }

  final info = await PackageInfo.fromPlatform();

  return DeviceInfoModel(
    id: deviceIdentifier,
    name: deviceName,
    version: info.version,
  );
}
