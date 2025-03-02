import 'package:flutter/material.dart';
import 'package:autoverpod/autoverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../test_feature_schema.schema.dart';
import '../i_test_feature_repo.dart';

part 'test_feature_detail_provider.g.dart';

@stateWidget
@riverpod
class TestFeatureDetail extends _$TestFeatureDetail {
  @override
  FutureOr<TestFeatureModel> build(TestFeatureId id) {
    return ref.watch(testFeatureRepoProvider).findOne(id).then((value) => value.getOrThrow());
  }

  void updateState(TestFeatureModel Function(TestFeatureModel oldState) newState) {
    state = state.whenData(newState);
  }
}