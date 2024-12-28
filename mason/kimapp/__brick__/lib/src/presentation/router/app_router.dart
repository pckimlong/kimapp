import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router_guard.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends RootStackRouter {
  final Ref _ref;

  AppRouter(this._ref);

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: SplashRoute.page,
        path: '/loading',
        keepHistory: false,
      ),
      AutoRoute(
        page: SignInRoute.page,
        guards: [LoginGuard(_ref)],
        path: '/login',
        keepHistory: false,
      ),
      AutoRoute(
        page: RootRoute.page,
        guards: [AuthGuard(_ref)],
        path: '/',
      ),
    ];
  }
}
