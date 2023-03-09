import '../../../exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router.gr.dart';

part "app_router.g.dart";

@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) => AppRouter(ref);

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends $AppRouter {
  final Ref _ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          title: (_, __) => 'Splash',
          page: SplashRoute.page,
        ),
      ];

  AppRouter(this._ref);
}
