import 'package:freezed_annotation/freezed_annotation.dart';
part 'device_info_model.g.dart';
part 'device_info_model.freezed.dart';

@freezed
sealed class DeviceInfoModel with _$DeviceInfoModel {
  const DeviceInfoModel._();

  const factory DeviceInfoModel({
    required String id,
    required String name,
    required String version,
  }) = _DeviceInfoModel;

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) => _$DeviceInfoModelFromJson(json);
}
