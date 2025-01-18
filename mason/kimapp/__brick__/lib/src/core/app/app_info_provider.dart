import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "app_info_provider.g.dart";

@Riverpod(keepAlive: true)
FutureOr<PackageInfo> appInfo(Ref ref) => PackageInfo.fromPlatform();
