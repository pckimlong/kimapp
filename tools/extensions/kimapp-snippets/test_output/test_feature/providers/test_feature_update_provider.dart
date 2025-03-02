import 'package:autoverpod/autoverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_test_feature_repo.dart';
import '../test_feature_schema.schema.dart';
import 'test_feature_detail_provider.dart';
import 'test_feature_list_pagination_provider.dart';
import 'test_feature_list_provider.dart';

part 'test_feature_update_provider.g.dart';

@formWidget
@riverpod
class TestFeatureUpdate extends _$TestFeatureUpdateWidget {
  @override
  Future<TestFeatureUpdateParam> build(TestFeatureId testFeatureId) async {
    final result = await ref.read(testFeatureRepoProvider).findOne(testFeatureId).getOrThrow();
    return TestFeatureUpdateParam(
        // TODO: Initialize form fields with the testFeature data
    );
  }

  @override
  Future<TestFeatureModel> submit(TestFeatureUpdateParam state) async {
    return await ref.read(testFeatureRepoProvider).update(testFeatureId, data: state).getOrThrow();
  }

  @override
  void onSuccess(TestFeatureModel result) {
    ref.read(testFeatureListProvider.notifier).updateItem(result);
    ref.read(testFeatureDetailProvider(testFeatureId).notifier).updateState((_) => result);

    //! Use with caution
    /// this update might lead to data inconsistency, for example, if we have update the item to not meet the param filter
    /// in this case, the item should be removed from the paginated list, but using this method will just update the item
    /// other case is if we update sort order, the item might need to change position
    TestFeaturePaginationTracker.instance.updatePaginatedItem(ref, result);
    
    super.onSuccess(result);
  }
}