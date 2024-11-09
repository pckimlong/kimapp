
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';

import '../{{name.snakeCase()}}_schema.dart';
import '../i_{{name.snakeCase()}}_repo.dart';

part '{{name.snakeCase()}}_list_pagination_provider.g.dart';

_page{{name.pascalCase()}}Limit = 25;

@riverpod
FutureOr<IList<{{name.pascalCase()}}Model>> {{name.camelCase()}}ListPagination(
  {{name.pascalCase()}}ListPaginationRef ref, {
  required int page,
  required {{name.pascalCase()}}ListParam param,
}) async {
  const limit = _page{{name.pascalCase()}}Limit;
  final offset = page * limit;

  await Future.delayed(const Duration(milliseconds: 250));
  final result = await ref
      .watch({{name.camelCase()}}RepoProvider)
      .findPagination(limit: limit, offset: offset, param: param);

  return result.fold(
    (_) => result.getOrThrow(),
    (list) {
      ref.cacheTime(const Duration(minutes: 5));
      return list;
    },
  );
}

@riverpod
PaginatedItem<{{name.pascalCase()}}Model>? {{name.camelCase()}}PaginatedAtIndex(
  {{name.pascalCase()}}PaginatedAtIndexRef ref,
  int index, {
  required {{name.pascalCase()}}ListParam param,
}) {
  const limit = _page{{name.pascalCase()}}Limit;
  final page = index ~/ limit;
  final pageItems = ref.watch({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
  // Likely scroll backward
  final hasNextPage = ref.exists({{name.camelCase()}}ListPaginationProvider(page: page + 1, param: param));
  return PaginatedItem.build(pageItems: pageItems, limit: limit, index: index, showLoadingInAllItem: hasNextPage,);
}


// //TODO - Move UI code to appropriate place
// final _paramProvider = StateProvider<{{name.pascalCase()}}ListPaginationParam>((ref) {
//   return const {{name.pascalCase()}}ListPaginationParam();
// });

// class {{name.pascalCase()}}ListPage extends ConsumerWidget {
//   const {{name.pascalCase()}}ListPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final param = ref.watch(_paramProvider);
//     final firstPageAsync = ref.watch(
//       {{name.pascalCase()}}ListPaginationProvider(page: 0, param: param).select(
//         (value) => value.whenData((value) => value.length),
//       ),
//     );

//     return firstPageAsync.when(
//       data: (count) => _ItemList(firstPageItemCount: count),
//       error: (err, s) => Center(child: Text(err.toString())),
//       loading: () => const CircularProgressIndicator(),
//     );
//   }
// }

// class _ItemList extends ConsumerWidget {
//   const _ItemList({required this.firstPageItemCount});

//   final int firstPageItemCount;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (firstPageItemCount == 0) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text('No Item'),
//             AS.hGap12,
//             // TODO - Add refresh button with ref.invalidate(...)
//           ],
//         ),
//       );
//     }

//     final param = ref.watch(_paramProvider);
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         final paginated = ref.watch({{name.pascalCase()}}PaginatedAtIndexProvider(index, param: param));
//         return paginated?.whenOrNull(
//            loading: (isFirstItem) {
//              if (isFirstItem) {
//                return const Text('Loading...', textAlign: TextAlign.center,);
//              }
//              return const Text('Loading old Item...');
//            },
//             data: ({{name.camelCase()}}) {
//               // TODO - Implement {{name.camelCase()}} item widget
//               return Text({{name.camelCase()}}.id.value.toString());
//             },
//           );
//       },
//     );
//   }
// }
