import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/helpers/provider_status_helper.dart';
import '../../../features/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_update_provider.widget.dart';
import '../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}_schema.schema.dart';
import '../../app/app_style.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/my_error_widget.dart';

@RoutePage()
class {{name.pascalCase()}}UpdatePage extends ConsumerStatefulWidget {
  const {{name.pascalCase()}}UpdatePage({
    super.key,
    @PathParam('id') required this.{{name.camelCase()}}IdString,
  });

  final String {{name.camelCase()}}IdString;

  static Future<{{name.pascalCase()}}Model?> show(BuildContext context, {{name.pascalCase()}}Id {{name.camelCase()}}Id) async {
    return await context.pushRoute({{name.pascalCase()}}UpdateRoute({{name.camelCase()}}IdString: {{name.camelCase()}}Id.toString()));
  }

  @override
  ConsumerState<{{name.pascalCase()}}UpdatePage> createState() => _{{name.pascalCase()}}UpdatePageState();
}

class _{{name.pascalCase()}}UpdatePageState extends ConsumerState<{{name.pascalCase()}}UpdatePage> {
  Future<void> _submit(BuildContext context, {{name.pascalCase()}}UpdateProxyWidgetRef ref) async {
    final result = await ref.submit();
    if (result.hasValue) {
      BotToast.showText(text: '{{name.pascalCase()}} Updated');
      if (context.mounted) {
        context.maybePop(result.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final {{name.camelCase()}}Id = {{name.pascalCase()}}Id.fromValue(widget.{{name.camelCase()}}IdString.toInt());
    return {{name.pascalCase()}}UpdateFormScope(
      {{name.camelCase()}}Id: {{name.camelCase()}}Id,
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Update {{name.pascalCase()}}'),
            actions: [
              TextButton(
                onPressed: ref.status?.isLoading == true
                    ? null
                    : () async {
                        await _submit(context, ref);
                      },
                child: Text('Update'),
              ),
              AS.wGap8,
            ],
          ),
        );
      },
      child: Column(
        children: [
          {{name.pascalCase()}}UpdateFormStatus(
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