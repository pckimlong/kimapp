import 'package:autoverpod/autoverpod.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_test_feature_repo.dart';
import '../test_feature_schema.schema.dart';

part 'test_feature_list_provider.g.dart';

@stateWidget
@riverpod
class TestFeatureList extends _$TestFeatureList with IListAsyncNotifier<TestFeatureModel> {
  @override
  bool identity(TestFeatureModel item) => item.id == item.id;

  @override
  FutureOr<IList<TestFeatureModel>> build() {
    return ref.watch(testFeatureRepoProvider).findAll().getOrThrow();
  }
}