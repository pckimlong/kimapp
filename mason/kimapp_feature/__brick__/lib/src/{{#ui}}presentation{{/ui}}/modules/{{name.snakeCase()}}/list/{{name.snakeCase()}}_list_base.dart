import '../../../../../../exports.dart';

import '../../../../features/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';

final _initialParamProvider = Provider<{{name.pascalCase()}}ListPaginationParam?>((ref) {
  return;
});

final _paramProvider = StateProvider<{{name.pascalCase()}}ListPaginationParam>(
  (ref) {
    final initialParam = ref.watch(_initialParamProvider);
    return initialParam ?? const {{name.pascalCase()}}ListPaginationParam();
  },
  dependencies: [_initialParamProvider],
);

class {{name.pascalCase()}}ListBase extends ConsumerWidget {
  const {{name.pascalCase()}}ListBase({super.key, this.initialParam});

  final {{name.pascalCase()}}ListPaginationParam? initialParam;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [_initialParamProvider.overrideWithValue(initialParam)],
      child: const _Content(),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        if (paginated != null) {
          return paginated.whenOrNull(
            loading: () => const Text('Loading...'),
            data: (financial) {
              // TODO - Implement financial item widget
              return Text(financial.id.value.toString());
            },
          );
        }
        return null;
      },
    );
  }
}
