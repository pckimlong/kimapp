// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../exports.dart';

class AppErrorPage extends ConsumerWidget {
  const AppErrorPage({
    super.key,
    required this.error,
    required this.stackTrace,
    required this.onRetry,
  });

  final Object error;
  final StackTrace stackTrace;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(home: Scaffold());
  }
}
