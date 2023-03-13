// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:sok_chea_sihanouk_clinic/src/presentation/core/app_theme.dart';

import '../../../exports.dart';
import '../../../main.dart';

class BaseAppWidget extends ConsumerWidget {
  const BaseAppWidget({
    Key? key,
    required this.routeInformationParser,
    required this.routerDelegate,
  }) : super(key: key);

  final RouteInformationParser<Object> routeInformationParser;
  final RouterDelegate<Object> routerDelegate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeMode = ref.watch(themeModeProvider).valueOrNull;

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      supportedLocales: const [...FormBuilderLocalizations.supportedLocales],
      theme: theme,
      themeMode: themeMode,
      builder: (context, child) {
        child = BotToastInit()(context, child);
        child = ResponsiveWrapper.builder(
          child,
          breakpoints: [
            const ResponsiveBreakpoint.resize(AS.mobileBreakpoint, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(AS.tabletBreakpoint, name: TABLET),
            const ResponsiveBreakpoint.resize(AS.desktopBreakpoint, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
        );
        return child;
      },
    );
  }
}
