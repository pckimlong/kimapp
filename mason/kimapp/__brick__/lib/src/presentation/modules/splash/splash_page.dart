import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/app/app_info_provider.dart';
import '../../app/app_state_provider.dart';
import '../../router/app_router.gr.dart';
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
  String? _error;
  @override
  void initState() {
    super.initState();

    ref.read(appStateProvider.notifier).initialize(
      onError: (error) {
        setState(() {
          _error = error;
        });
      },
    ).then((value) {
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
      error: _error,
    );
  }
}
