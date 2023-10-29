import '../../../../exports.dart';
import '../../app/app_state_provider.dart';
import 'splash_widget.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key, this.onInitialized});

  /// Execute when app has been initialized. This can be use in auto route for showing
  /// splash screen before reach to give route
  final VoidCallback? onInitialized;

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    ref.read(appStateProvider.notifier).initialize().then((value) {
      if (value == ApplicationState.initialized) {
        if (widget.onInitialized != null) {
          widget.onInitialized!();
        } else {
          context.replaceRoute(const RootRoute());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appVersion = ref.watch(appInfoProvider).valueOrNull?.version;

    return SplashWidget(
      loadedInMain: false,
      appVersion: appVersion,
      error: error,
    );
  }
}
