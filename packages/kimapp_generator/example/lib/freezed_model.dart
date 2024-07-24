
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'freezed_model.freezed.dart';
part 'freezed_model.g.dart';


@freezed
class FreezedModel with _$FreezedModel {
  const FreezedModel._();

  @TableModel('FreezedModel')
  const factory FreezedModel() = _FreezedModel;

factory FreezedModel.fromJson(Map<String, dynamic> json) => _$FreezedModelFromJson(json);
static const TableBuilder table = _tableFreezedModel;
}