import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';
import '../../features/auth/auth.dart';
import '../../providers/app/app_info_provider.dart';
import '../core/app_theme.dart';
import '../router/app_authenticated_router.dart';
import '../router/app_unauthenticated_router.dart';
import 'app_error_page.dart';
import 'base_app_widget.dart';
import 'splash_page.dart';

part 'app_widget.g.dart';

// Provider use to load initial async provider.
// This allow to show splash screen
@Riverpod(keepAlive: true)
FutureOr<bool> initialLoader(InitialLoaderRef ref) async {
  await Future.wait<bool>([
    // List of provider to load
    ref.watch(localStorageProvider.selectAsync((data) => true)),
    ref.watch(authStateProvider.selectAsync((data) => true)),
    ref.watch(appInfoProvider.selectAsync((data) => true)),
    ref.watch(themeModeProvider.selectAsync((data) => true))
  ]);
  return true;
}

class AppWidget extends HookConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStateKey = useMemoized(() => GlobalKey());
    final initialLoader = ref.watch(initialLoaderProvider);
    print(initialLoader);
    return initialLoader.when(
      data: (_) => AuthGateWidget(key: dataStateKey),
      error: (error, stackTrace) => AppErrorPage(
        error: error,
        stackTrace: stackTrace,
        onRetry: () => ref.invalidate(initialLoaderProvider),
      ),
      loading: () => const SplashPage(),
    );
  }
}

class AuthGateWidget extends HookConsumerWidget {
  const AuthGateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider).valueOrNull;

    if (authState == null) return const SplashPage();

    return authState.when(
      authenticated: (_) => const AuthenticatedAppWidget(),
      unauthenticated: () => const UnauthenticatedAppWidget(),
    );
  }
}

class AuthenticatedAppWidget extends HookConsumerWidget {
  const AuthenticatedAppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appKey = useMemoized(() => GlobalKey());
    final router = ref.watch(appAuthenticatedRouterProvider);

    return BaseAppWidget(
      key: appKey,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(navigatorObservers: () => [NavigatorObserver()]),
    );
  }
}

class UnauthenticatedAppWidget extends HookConsumerWidget {
  const UnauthenticatedAppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appUnauthenticatedRouterProvider);

    return BaseAppWidget(
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(navigatorObservers: () => [NavigatorObserver()]),
    );
  }
}
