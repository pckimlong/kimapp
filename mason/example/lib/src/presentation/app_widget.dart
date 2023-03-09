import '../../exports.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'router/app_router.dart';

class AppWidget extends HookConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appKey = useMemoized(() => GlobalKey());
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      key: appKey,
      supportedLocales: const [...FormBuilderLocalizations.supportedLocales],
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
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
    );
  }
}
