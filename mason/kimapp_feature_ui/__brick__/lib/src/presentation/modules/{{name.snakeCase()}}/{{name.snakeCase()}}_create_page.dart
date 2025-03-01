import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/helpers/provider_status_helper.dart';
import '../../../features/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_create_provider.widget.dart';
import '../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}_schema.schema.dart';
import '../../app/app_style.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/my_error_widget.dart';

@RoutePage()
class {{name.pascalCase()}}CreatePage extends ConsumerStatefulWidget {
  const {{name.pascalCase()}}CreatePage({super.key});

  static Future<{{name.pascalCase()}}Model?> show(BuildContext context) async {
    return await context.pushRoute(const {{name.pascalCase()}}CreateRoute());
  }

  @override
  ConsumerState<{{name.pascalCase()}}CreatePage> createState() => _{{name.pascalCase()}}CreatePageState();
}

class _{{name.pascalCase()}}CreatePageState extends ConsumerState<{{name.pascalCase()}}CreatePage> {
  Future<void> _submit(BuildContext context, {{name.pascalCase()}}CreateProxyWidgetRef ref) async {
    final result = await ref.submit();
    if (result.hasValue) {
      BotToast.showText(text: '{{name.pascalCase()}} Created');
      if (context.mounted) {
        context.maybePop(result.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return {{name.pascalCase()}}CreateFormScope(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create {{name.pascalCase()}}'),
            actions: [
              TextButton(
                onPressed: ref.status?.isLoading == true
                    ? null
                    : () async {
                        await _submit(context, ref);
                      },
                child: Text('Save'),
              ),
              AS.wGap8,
            ],
          ),
        );
      },
      child: Column(
        children: [
          {{name.pascalCase()}}CreateFormStatus(
            builder: (context, ref, status) {
              final providerStatus = status.toProviderStatus();
              return providerStatus.maybeWhen(
                inProgress: () => const LinearProgressIndicator(),
                failure: (failure) => MyErrorWidget(error: failure),
                orElse: () => SizedBox.shrink(),
              );
            },
          ),

          // Add more fields here...
        ],
      ),
    );
  }
}