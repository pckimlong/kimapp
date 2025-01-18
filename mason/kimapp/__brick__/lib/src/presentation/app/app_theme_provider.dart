import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/cache_manager/cache_manager.dart';
import 'app_theme.dart';

part 'app_theme_provider.g.dart';

const _themeModeCacheKey = "theme-mode";

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  FutureOr<ThemeMode> build() async {
    final cache = await ref.watch(cacheManagerProvider.future);

    // Store to local storage whenever theme mode change
    listenSelf((previous, next) {
      if (previous != next && next.hasValue) {
        cache.saveEnum(_themeModeCacheKey, next.valueOrNull);
      }
    });

    // Read stored theme mode in the local storage
    final themeMode = await cache.readEnum(
      _themeModeCacheKey,
      ThemeMode.values.byName,
    );

    return themeMode ?? ThemeMode.system;
  }

  void change(ThemeMode themeMode) {
    state = state.whenData((_) => themeMode);
  }
}

@riverpod
ThemeData ligtTheme(Ref ref) => AppTheme.light;

@riverpod
ThemeData darkTheme(Ref ref) => AppTheme.dark;
