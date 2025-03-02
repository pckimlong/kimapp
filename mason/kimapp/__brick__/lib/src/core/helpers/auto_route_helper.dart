import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

extension PageRouteInfoBuildContext on PageRouteInfo {
  Future<T?> push<T>(BuildContext context) async => await context.pushRoute(this);
  Future<void> navigate(BuildContext context) async => await context.navigateTo(this);
  Future<T?> replace<T>(BuildContext context) async => await context.replaceRoute(this);
}
