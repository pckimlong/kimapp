// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:sok_chea_sihanouk_clinic/src/presentation/modules/auth/sign_in_page.dart'
    as _i1;
import 'package:sok_chea_sihanouk_clinic/src/presentation/modules/root_page.dart'
    as _i2;

abstract class $AppAuthenticatedRouter extends _i3.RootStackRouter {
  $AppAuthenticatedRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    SignInRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.SignInPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.RootPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.SignInPage]
class SignInRoute extends _i3.PageRouteInfo<void> {
  const SignInRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.RootPage]
class RootRoute extends _i3.PageRouteInfo<void> {
  const RootRoute({List<_i3.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
