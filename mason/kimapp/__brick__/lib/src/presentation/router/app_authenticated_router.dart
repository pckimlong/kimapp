import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';
import 'app_authenticated_router.gr.dart';

part "app_authenticated_router.g.dart";

@Riverpod(keepAlive: true)
AppAuthenticatedRouter appAuthenticatedRouter(AppAuthenticatedRouterRef ref) =>
    AppAuthenticatedRouter(ref);

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppAuthenticatedRouter extends $AppAuthenticatedRouter {
  final Ref _ref;

  AppAuthenticatedRouter(this._ref);

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: RootRoute.page, path: '/'),
    ];
  }
}
