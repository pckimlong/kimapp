import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';

part 'app_theme.g.dart';

const _themeModeCacheKey = "theme-mode";

@Riverpod(keepAlive: true)
FutureOr<ThemeMode> themeMode(ThemeModeRef ref) async {
  final cache = await ref.watch(localStorageProvider.future);

  // Store to local storage whenever theme mode change
  ref.listenSelf((previous, next) {
    if (previous != next && next.hasValue) {
      cache.saveEnum(_themeModeCacheKey, value: next.valueOrNull);
    }
  });

  // Read stored theme mode in the local storage
  final themeMode = await cache.readEnum(
    _themeModeCacheKey,
    parser: ThemeMode.values.byName,
  );

  // If no theme mode store, return ThemeMode.light() as default theme
  return themeMode ?? ThemeMode.light;
}

@Riverpod(keepAlive: true)
ThemeData theme(ThemeRef ref) {
  return ThemeData.light();
}
