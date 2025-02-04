import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';

import '../../../features/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_create_provider.dart';
import '../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}_schema.schema.dart';

@RoutePage()
class {{name.pascalCase()}}CreatePage extends HookConsumerWidget {
  const {{name.pascalCase()}}CreatePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Body();
  }
}

class _Body extends StatefulHookConsumerWidget {
  const _Body();
  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  @override
  Widget build(BuildContext context) {
    return {{name.pascalCase()}}CreateFormWidget(
      builder: (ref, status, isProgressing, failure, submit) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create {{name.pascalCase()}}'),
            actions: [
              TextButton(
                onPressed: () async {
                  final result = await submit();
                  if (result.isSuccess) {
                    BotToast.showText(text: '{{name.pascalCase()}} Created');
                    if (context.mounted) {
                      context.maybePop();
                    }
                  }

                  if (result.isFailure && context.mounted) {
                    _showFailureSnackbar(result);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Add your form widgets here
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFailureSnackbar(ProviderStatus<{{name.pascalCase()}}Model> result) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.failure!.message(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}