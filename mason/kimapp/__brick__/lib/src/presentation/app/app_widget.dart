import '../../../config.dart';
import 'app_theme_provider.dart';
import '../router/app_router_provider.dart';
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
       localizationsDelegates: [
        ...context.localizationDelegates,
        OverrideFormBuilderLocalizationsEn.delegate
      ],
      supportedLocales: [
        ...context.supportedLocales,
        ...FormBuilderLocalizations.supportedLocales,
      ],
      locale: context.locale,
      builder: (context, child) {
        child = BotToastInit()(context, child);
        child = _Unfocus(child: child);
        child = ResponsiveBreakpoints.builder(
          child: child,
          breakpoints: [
            const Breakpoint(start: 0, end: AS.mobileBreakpoint, name: MOBILE),
            const Breakpoint(start: AS.mobileBreakpoint, end: AS.tabletBreakpoint, name: TABLET),
            const Breakpoint(start: AS.desktopBreakpoint, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
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
