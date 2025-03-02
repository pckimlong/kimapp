import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_test_feature_repo.dart';
import '../test_feature_schema.schema.dart';
import 'test_feature_list_provider.dart';
import 'test_feature_list_pagination_provider.dart';

part 'test_feature_create_provider.g.dart';

@formWidget
@riverpod
class TestFeatureCreate extends _$TestFeatureCreateWidget {
  @override
  TestFeatureCreateParam build() => const TestFeatureCreateParam();

  @override
  Future<TestFeatureModel> submit(TestFeatureCreateParam state) async {
    return await ref.read(testFeatureRepoProvider).create(state).getOrThrow();
  }

  @override
  void onSuccess(TestFeatureModel result) {
    ref.read(testFeatureListProvider.notifier).insertItem(result);
    ref.invalidate(testFeatureListPaginationProvider);
  }
}