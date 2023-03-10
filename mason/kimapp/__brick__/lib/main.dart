import 'src/presentation/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Kimapp.intialize();

  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const AppWidget(),
    ),
  );
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}
