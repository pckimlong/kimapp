import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_router_guard.dart';
import '../../../exports.dart';

part "app_router.g.dart";

@Riverpod(keepAlive: true)
// ignore: unsupported_provider_value
AppRouter appRouter(AppRouterRef ref) => AppRouter(ref);

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends $AppRouter {
  final Ref _ref;

  AppRouter(this._ref);

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: SplashRoute.page,
        path: '/loading',
      ),
      AutoRoute(
        page: SignInRoute.page,
        guards: [LoginGuard(_ref)],
        path: '/login',
      ),
      AutoRoute(
        page: RootRoute.page,
        guards: [AuthGuard(_ref)],
        path: '/',
      ),
    ];
  }
}
