import '../../../exports.dart';
import '../../../main.dart';
import '../core/app_theme.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeProvider);
    final themeMode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.light;
    final theme = Theme.of(context);

    return MaterialApp(
      theme: themeData,
      themeMode: themeMode,
      home: Scaffold(
        backgroundColor: theme.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appName,
                style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary),
              ),
              AS.hGap24,
              CircularProgressIndicator.adaptive(
                backgroundColor: theme.colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
