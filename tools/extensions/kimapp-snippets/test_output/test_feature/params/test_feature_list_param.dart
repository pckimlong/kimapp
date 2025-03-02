import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_feature_list_param.freezed.dart';

@freezed
class TestFeatureListParam with _$TestFeatureListParam {
  const TestFeatureListParam._();

  @JsonSerializable(explicitToJson: true)
  const factory TestFeatureListParam({
    String? search,
  }) = _TestFeatureListParam;
}