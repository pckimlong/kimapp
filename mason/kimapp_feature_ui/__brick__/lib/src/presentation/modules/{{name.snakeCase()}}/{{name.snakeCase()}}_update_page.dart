import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';

import '../../../features/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_update_provider.dart';
import '../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}_schema.schema.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class {{name.pascalCase()}}UpdatePage extends HookConsumerWidget {
  const {{name.pascalCase()}}UpdatePage({super.key, @PathParam('id') required this.{{name.camelCase()}}IdString,});

  final String {{name.camelCase()}}IdString;

  static Future<{{name.pascalCase()}}Model?> show(BuildContext context, {{name.pascalCase()}}Id {{name.camelCase()}}Id) async {
    return await context.pushRoute({{name.pascalCase()}}UpdateRoute({{name.camelCase()}}IdString: {{name.camelCase()}}Id.toString()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final {{name.camelCase()}}Id = {{name.pascalCase()}}Id.fromValue({{name.camelCase()}}IdString.toInt());
    return _Body({{name.camelCase()}}Id: {{name.camelCase()}}Id);
  }
}

class _Body extends StatefulHookConsumerWidget {
  const _Body({
    required this.{{name.camelCase()}}Id,
  });

  final {{name.pascalCase()}}Id {{name.camelCase()}}Id;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  @override
  Widget build(BuildContext context) {
    return {{name.pascalCase()}}UpdateFormWidget(
      initializingIndicator: () => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      {{name.camelCase()}}Id: widget.{{name.camelCase()}}Id,
      builder: (ref, formKey, status, isProgressing, failure, submit) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Update {{name.pascalCase()}}'),
            actions: [
              TextButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  
                  final result = await submit();
                  if (result.isSuccess) {
                    BotToast.showText(text: '{{name.pascalCase()}} Updated');
                    if (context.mounted) {
                      context.maybePop(result.successOrNull);
                    }
                  }

                  if (result.isFailure && context.mounted) {
                    _showFailureSnackbar(result);
                  }
                },
                child: const Text('Update'),
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