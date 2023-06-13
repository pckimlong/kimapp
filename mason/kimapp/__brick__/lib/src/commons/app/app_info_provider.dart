
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "app_info_provider.g.dart";

@Riverpod(keepAlive: true)
FutureOr<PackageInfo> appInfo(AppInfoRef ref) {
  return PackageInfo.fromPlatform();
}
