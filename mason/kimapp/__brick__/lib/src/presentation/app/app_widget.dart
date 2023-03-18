// Package imports:
import 'package:responsive_framework/responsive_wrapper.dart';
import '../../../config.dart';
import 'app_theme.dart';
import '../router/app_router.dart';
import '../../../exports.dart';

class AppWidget extends HookConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: Config.appName,
      color: Colors.blue,
      theme: ref.watch(themeProvider),
      themeMode: ref.watch(themeModeProvider).valueOrNull,
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
      localizationsDelegates: const [OverrideFormBuilderLocalizationsEn.delegate],
      supportedLocales: const [...FormBuilderLocalizations.supportedLocales],
      builder: (context, child) {
        child = BotToastInit()(context, child);
        child = _Unfocus(child: child);
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

class _Unfocus extends StatelessWidget {
  const _Unfocus({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: child,
    );
  }
}
