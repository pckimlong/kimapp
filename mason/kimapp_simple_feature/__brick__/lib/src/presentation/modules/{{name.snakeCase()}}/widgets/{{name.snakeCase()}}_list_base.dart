import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}_schema.schema.dart';
import '../../../../features/{{name.snakeCase()}}/providers/{{name.snakeCase()}}_list_pagination_provider.dart';
import '../../../app/app_style.dart';

class  {{name.pascalCase()}}ListBaseConfig{
  const  {{name.pascalCase()}}ListBaseConfig();
}

final _initialParamProvider = Provider.autoDispose<{{name.pascalCase()}}ListParam>((ref) {
  throw UnimplementedError();
});

final _configProvider = Provider.autoDispose<{{name.pascalCase()}}ListBaseConfig>((ref) {
  throw UnimplementedError();
});

final _paramProvider = StateProvider.autoDispose<{{name.pascalCase()}}ListParam>(
  (ref) {
    final initialParam = ref.watch(_initialParamProvider);
    return initialParam;
  },
  dependencies: [_initialParamProvider],
);

class {{name.pascalCase()}}ListBase extends ConsumerWidget {
  const {{name.pascalCase()}}ListBase({
    super.key, 
    this.initialParam,
    this.config = const {{name.pascalCase()}}ListBaseConfig(),
  });

  final {{name.pascalCase()}}ListParam? initialParam;
  final {{name.pascalCase()}}ListBaseConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
          _initialParamProvider.overrideWithValue(initialParam ?? const {{name.pascalCase()}}ListParam()),
          _configProvider.overrideWithValue(config),
        ],
      child: const _Content(),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(_configProvider);
    final param = ref.watch(_paramProvider);
    final firstPageAsync = ref.watch(
      {{name.pascalCase()}}ListPaginationProvider(page: 0, param: param).select(
        (value) => value.whenData((value) => value.length),
      ),
    );

    return firstPageAsync.when(
      data: (count) => _ItemList(firstPageItemCount: count),
      error: (err, s) => Center(child: Text(err.toString())),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class _ItemList extends ConsumerWidget {
  const _ItemList({required this.firstPageItemCount});

  final int firstPageItemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (firstPageItemCount == 0) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No Item'),
            AS.hGap12,
            // TODO - Add refresh button with ref.invalidate(...)
          ],
        ),
      );
    }

    final param = ref.watch(_paramProvider);
    return ListView.builder(
      itemBuilder: (context, index) {
        final paginated = ref.watch({{name.pascalCase()}}PaginatedAtIndexProvider(index, param: param));
        return paginated?.whenOrNull(
            loading: (isFirstItem) {
              if(isFirstItem){
                return const Text('Loading...', textAlign: TextAlign.center);
              }
              return const Text('Loading old item...', textAlign: TextAlign.center);
            },
            data: (financial) {
              // TODO - Implement financial item widget
              return Text(financial.id.value.toString());
            },
          );
      },
    );
  }
}
