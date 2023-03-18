// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:hr_ad_app/exports.dart' as _i6;
import 'package:hr_ad_app/src/presentation/modules/auth/sign_in_page.dart'
    as _i2;
import 'package:hr_ad_app/src/presentation/modules/root_page.dart' as _i3;
import 'package:hr_ad_app/src/presentation/modules/splash/splash_page.dart'
    as _i1;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.SplashPage(
          key: args.key,
          onInitialized: args.onInitialized,
        ),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.SignInPage(
          key: args.key,
          onSuccess: args.onSuccess,
        ),
      );
    },
    RootRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RootPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i6.Key? key,
    void Function()? onInitialized,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            key: key,
            onInitialized: onInitialized,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i4.PageInfo<SplashRouteArgs> page =
      _i4.PageInfo<SplashRouteArgs>(name);
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.key,
    this.onInitialized,
  });

  final _i6.Key? key;

  final void Function()? onInitialized;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, onInitialized: $onInitialized}';
  }
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i4.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i6.Key? key,
    void Function()? onSuccess,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(
            key: key,
            onSuccess: onSuccess,
          ),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i4.PageInfo<SignInRouteArgs> page =
      _i4.PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({
    this.key,
    this.onSuccess,
  });

  final _i6.Key? key;

  final void Function()? onSuccess;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, onSuccess: $onSuccess}';
  }
}

/// generated route for
/// [_i3.RootPage]
class RootRoute extends _i4.PageRouteInfo<void> {
  const RootRoute({List<_i4.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
