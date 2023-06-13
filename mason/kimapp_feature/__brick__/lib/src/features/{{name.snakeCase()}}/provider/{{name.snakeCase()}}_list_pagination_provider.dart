
import 'package:riverpod_annotation/riverpod_annotation.dart';


import '../../../../export.dart';
// ignore: unused_import
import '../{{name.snakeCase()}}.dart';

part '{{name.snakeCase()}}_list_pagination_provider.g.dart';

const _page{{name.pascalCase()}}Limit = 25;

@riverpod
FutureOr<IList<{{name.pascalCase()}}Model>> {{name.camelCase()}}ListPagination(
  {{name.pascalCase()}}ListPaginationRef ref, {
  required int page,
  required {{name.pascalCase()}}ListPaginationParam param,
}) async {
  ref.catchTime(const Duration(minutes: 5));

  const limit = _page{{name.pascalCase()}}Limit;
  final offset = page * limit;

  await Future.delayed(const Duration(milliseconds: 250));
  return ref
      .watch({{name.camelCase()}}RepoProvider)
      .findPagination(limit: limit, offset: offset, param: param)
      .then((value) => value.getOrThrow());
}

@riverpod
PaginatedItem<{{name.pascalCase()}}Model>? {{name.camelCase()}}PaginatedAtIndex(
  {{name.pascalCase()}}PaginatedAtIndexRef ref,
  int index, {
  required {{name.pascalCase()}}ListPaginationParam param,
}) {
  const limit = _page{{name.pascalCase()}}Limit;
  final page = index ~/ limit;
  final pageItems = ref.watch({{name.camelCase()}}ListPaginationProvider(page: page, param: param));
  return PaginatedItem.build(pageItems: pageItems, limit: limit, index: index);
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
//         if (paginated != null) {
//           return paginated.whenOrNull(
//             loading: () => const Text('Loading...'),
//             data: ({{name.camelCase()}}) {
//               // TODO - Implement {{name.camelCase()}} item widget
//               return Text({{name.camelCase()}}.id.value.toString());
//             },
//           );
//         }
//         return null;
//       },
//     );
//   }
// }
