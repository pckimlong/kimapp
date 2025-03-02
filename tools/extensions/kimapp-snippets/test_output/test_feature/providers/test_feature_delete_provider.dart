import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../test_feature_schema.schema.dart';
import '../i_test_feature_repo.dart';
import 'test_feature_detail_provider.dart';
import 'test_feature_list_pagination_provider.dart';
import 'test_feature_list_provider.dart';

part 'test_feature_delete_provider.g.dart';

@riverpod
class TestFeatureDelete extends _$TestFeatureDelete {
  @override
  ProviderStatus<Unit> build(TestFeatureId id) => const ProviderStatus.initial();

  Future<ProviderStatus<Unit>> call() async {
    return await perform((state) async {
     final result = await ref.read(testFeatureRepoProvider).delete(id);
     return result.getOrThrow();
    }, onSuccess: (success) {
      ref.read(testFeatureListProvider.notifier).removeWhere((e) => e.id == id);
      ref.invalidate(testFeatureDetailProvider(id));

      /// Can set the invalidateOnLength to 0, but if it just 1, the invalidate is not expensive, it deserve to be used
      /// since it will help accurate the data consistency
      TestFeaturePaginationTracker.instance.deletePaginatedItem(ref, id, invalidateOnLength: 1);
    },);
  }
}