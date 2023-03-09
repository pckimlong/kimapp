import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import './../core/core.dart';

part 'doctor_id_name_model.g.dart';
part 'doctor_id_name_model.freezed.dart';


@freezed
class DoctorIdNameModel with _$DoctorIdNameModel, DoctorCommonMixin {
  const DoctorIdNameModel._();

  @TableModel(DoctorsTable.table)
  const factory DoctorIdNameModel({
    @JsonKey(name: DoctorsTable.id) required DoctorId id,
  }) = _DoctorIdNameModel;

  factory DoctorIdNameModel.fromJson(Map<String, dynamic> json) {
    _$DoctorIdNameModelFromJson(json);
  }
  
  static const TableBuilder table = _tableDoctorIdNameModel;

  @override
  DoctorId get identity => this.id;
}