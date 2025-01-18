import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

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
    final isFirstPageLoading = ref.watch(
      {{name.pascalCase()}}ListPaginationProvider(page: 0, param: param).select(
        (value) => value.isLoading,
      ),
    );

    return RiverpodPaginationListView(
      loading: isFirstPageLoading,
      getData: (ref, index) => ref.watch({{name.pascalCase()}}PaginatedAtIndexProvider(index, param: param)),
      loadingItemBuilder: (index, isFirstItem) {
        return const _Item(item: null);
      },
      itemBuilder: (index, data) {
        return _Item(key: ValueKey(index), item: data);
      },
    );
  }
}

class _Item extends ConsumerWidget {
  const _Item({
    super.key,
    required this.item,
  });

  final {{name.pascalCase()}}Model? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (item == null) {
      return Text('Loading...');
    }
    return Text(item!.id.toString());
  }
}
