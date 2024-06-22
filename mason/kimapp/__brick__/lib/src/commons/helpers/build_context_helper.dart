import '../../../exports.dart';

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

  Future<dynamic> pushTo(Widget Function(BuildContext context) page) async =>
      await nav.push(MaterialPageRoute(builder: (_) => page(_)));

  Future<dynamic> replaceTo(Widget Function(BuildContext context) page) async =>
      await nav.pushReplacement(MaterialPageRoute(builder: (_) => page(_)));

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.black,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
