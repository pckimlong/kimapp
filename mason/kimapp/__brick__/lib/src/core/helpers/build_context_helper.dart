import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension BuildContextHelper on BuildContext {
  ResponsiveBreakpointsData get responsive => ResponsiveBreakpoints.of(this);

  bool get isMobile => responsive.isMobile || responsive.smallerThan(MOBILE);

  bool get isTable =>
      (responsive.largerThan(MOBILE) && responsive.smallerThan(DESKTOP)) || responsive.isTablet;

  bool get isDesktop => responsive.largerThan(TABLET) || responsive.isDesktop;
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  Color get primaryColor => theme.primaryColor;
  Color get onPrimaryColor => theme.colorScheme.onPrimary;

  NavigatorState get nav => Navigator.of(this);

  pop([dynamic data]) => Navigator.of(this, rootNavigator: true).pop(data);

  Future<dynamic> pushTo(
    Widget Function(BuildContext context) page, {
    PageTransitionType? pageTransitionType,
  }) async {
    if (pageTransitionType != null) {
      return await nav.push(PageTransition(child: page(this), type: pageTransitionType));
    }
    return await nav.push(MaterialPageRoute(builder: (context) => page(context)));
  }

  Future<dynamic> replaceTo(Widget Function(BuildContext context) page) async =>
      await nav.pushReplacement(MaterialPageRoute(builder: (_) => page(_)));

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showSnackBar({required String message, Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: backgroundColor));
  }

  Future<T?> showAppDialog<T>({
    required Widget Function(BuildContext context) builder,
    bool barrierDismissible = true,
  }) async {
    return await showDialog<T>(
      context: this,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  Future<T?> showAppModalBottomSheet<T>({
    required Widget Function(BuildContext context) builder,
    bool isDismissible = true,
    bool enableDrag = true,
  }) async {
    return await showModalBottomSheet<T>(
      context: this,
      builder: builder,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// Function to wrap a function with a loading indicator
  /// This can help later use to change other loading mechanism with less effort
  Future<T?> loadingWrapper<T>(Future<T> Function() function) async {
    final closeLoading = BotToast.showLoading();
    try {
      return await function();
    } finally {
      closeLoading();
    }
  }
}
