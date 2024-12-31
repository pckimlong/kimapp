import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../config.dart';
import '../../../exports.dart';
import '../router/app_router_provider.dart';
import 'app_theme_provider.dart';
import './app_state_provider.dart';

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

class AppWidget extends HookConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // Convert auth state to listenable, and use it to reevaluate router
    final authListenable = useValueNotifier<Option<AuthenticationState>>(none());
    ref.listen(authStateProvider, (_, next) => authListenable.value = some(next));

    return _EagerInitialization(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router.config(
          reevaluateListenable: authListenable,
          navigatorObservers: () => [
            SentryNavigatorObserver(),
          ],
        ),
        title: Config.appName,
        theme: ref.watch(ligtThemeProvider),
        darkTheme: ref.watch(darkThemeProvider),
        themeMode: ref.watch(appThemeModeProvider).valueOrNull,
        localizationsDelegates: [
          ...context.localizationDelegates,
        ],
        supportedLocales: [
          ...context.supportedLocales,
        ],
        locale: context.locale,
        builder: (context, child) {
          child = BotToastInit()(context, child);
          child = _Unfocus(child: child);
          child = _LifecycleWatcher(child: child);
          child = ResponsiveBreakpoints.builder(
            child: child,
            breakpoints: [
              const Breakpoint(start: 0, end: AS.mobileBreakpoint, name: MOBILE),
              const Breakpoint(start: AS.mobileBreakpoint, end: AS.tabletBreakpoint, name: TABLET),
              const Breakpoint(start: AS.desktopBreakpoint, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
          return child;
        },
      ),
    );
  }
}

class _Unfocus extends StatelessWidget {
  const _Unfocus({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
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
    // App is resumed from background
    if (state == AppLifecycleState.resumed) {
      // TODO: Handle app resume
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
