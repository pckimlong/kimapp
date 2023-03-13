import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';
import 'app_unauthenticated_router.gr.dart';

part "app_unauthenticated_router.g.dart";

@Riverpod(keepAlive: true)
AppUnauthenticatedRouter appUnauthenticatedRouter(AppUnauthenticatedRouterRef ref) =>
    AppUnauthenticatedRouter();

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppUnauthenticatedRouter extends $AppUnauthenticatedRouter {
  @override
  List<AutoRoute> get routes {
    return [
      RedirectRoute(path: '/', redirectTo: '/login'),
      AutoRoute(page: SignInRoute.page, path: '/login'),
    ];
  }
}
