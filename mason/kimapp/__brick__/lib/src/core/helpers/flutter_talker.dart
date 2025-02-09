import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:talker_flutter/talker_flutter.dart';

Talker initFlutterTalker(IntegrationMode env) {
  return TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: !env.isRelease,
      useHistory: true,
      useConsoleLogs: true,
    ),
  );
}

final talkerProvider = Provider<Talker>((ref) => throw UnimplementedError());
