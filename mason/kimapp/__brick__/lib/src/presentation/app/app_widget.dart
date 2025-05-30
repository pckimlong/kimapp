import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../config.dart';
import '../../core/helpers/build_context_helper.dart';
import '../../core/helpers/flutter_talker.dart';
import '../../features/auth/auth.dart';
import '../router/app_router_provider.dart';
import '../widgets/components/app_error_widget.dart';
import 'app_state_provider.dart';
import 'app_style.dart';
import 'app_theme_provider.dart';

// Response for initialize app, and other global state
class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize app state
    ref.watch(appStateProvider);

    return child;
  }
}

class AppWidget extends StatefulHookConsumerWidget {
  const AppWidget({super.key});

  @override
  ConsumerState<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends ConsumerState<AppWidget> {
  late final ValueNotifier<Option<AuthenticationState>> _authListenable;

  @override
  void initState() {
    super.initState();
    _authListenable = ValueNotifier(none());
    ref.listenManual(authStateProvider, (pre, next) {
      if (pre != next) {
        _authListenable.value = some(next);
      }
    });
  }

  @override
  void dispose() {
    _authListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return _EagerInitialization(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(
          reevaluateListenable: _authListenable,
          navigatorObservers: () => [TalkerRouteObserver(ref.watch(talkerProvider))],
        ),
        restorationScopeId: Config.appName,
        key: ValueKey(Config.appName),
        title: Config.appName,
        theme: ref.watch(lightThemeProvider),
        darkTheme: ref.watch(darkThemeProvider),
        themeMode: ref.watch(appThemeModeProvider).valueOrNull,
        localizationsDelegates: [...context.localizationDelegates],
        supportedLocales: [...context.supportedLocales],
        locale: context.locale,
        builder: (context, child) {
          child = BotToastInit()(context, child);
          child = KeyboardDismiss(child: child);
          child = _LifecycleWatcher(child: child);
          child = ResponsiveBreakpoints.builder(
            child: child,
            breakpoints: [
              const Breakpoint(start: 0, end: AS.mobileBreakpoint, name: MOBILE),
              const Breakpoint(start: AS.mobileBreakpoint, end: AS.tabletBreakpoint, name: TABLET),
              const Breakpoint(start: AS.tabletBreakpoint, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );

          return _ThemeOverride(child: child);
        },
      ),
    );
  }
}

class _ThemeOverride extends ConsumerWidget {
  const _ThemeOverride({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightTokens = MoonTokens.light.copyWith(
      colors: MoonColors.light.copyWith(
        piccolo: context.primaryColor,
        hit: context.colors.secondary,
      ),
    );
    // Get the current theme extensions
    final currentExtensions = context.theme.extensions.values.toList();

    return Theme(
      data: context.theme.copyWith(
        extensions: [
          // Include existing extensions
          ...currentExtensions,
          // Add the KimappThemeExtension
          KimappThemeExtension(
            defaultLoadingStateWidget: (context, ref) {
              return const Center(child: CircularProgressIndicator());
            },
            defaultErrorStateWidget: (_, __, error) => Center(child: AppErrorWidget(error: error)),
          ),

          MoonTheme(tokens: lightTokens),
        ],

        // Other theme settings here ...
      ),
      child: child,
    );
  }
}

class _LifecycleWatcher extends ConsumerStatefulWidget {
  const _LifecycleWatcher({required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __LifecycleWatcherState();
}

class __LifecycleWatcherState extends ConsumerState<_LifecycleWatcher> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // Refresh critical data
        ref.invalidate(appStateProvider);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
