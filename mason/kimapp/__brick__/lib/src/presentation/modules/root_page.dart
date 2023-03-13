import '../../providers/account/current_account_provider.dart';

import '../../../exports.dart';
import '../../features/auth/auth.dart';

@RoutePage()
class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(currentAccountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(signOutProvider.notifier).call();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
