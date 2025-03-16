// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'model_forge_example.dart';

part 'model_forge.forge.freezed.dart';
part 'model_forge.forge.g.dart';

class DemoId {
  const DemoId({required this.value});

  final int value;

  Map<String, dynamic> toJson() => {'id': value};

  factory DemoId.fromJson(dynamic json) => DemoId(value: json['id']);
}

@freezed
sealed class DemoModel extends $DemoModel with _$DemoModel {
  const DemoModel._({required super.id, required super.name}) : super();

  const factory DemoModel({
    @JsonKey(name: DemoModel.idKey) required DemoId id,
    @JsonKey(name: DemoModel.nameKey) required String? name,
  }) = _DemoModel;

  factory DemoModel.fromJson(Map<String, dynamic> json) => _$DemoModelFromJson(json);

  static const String idKey = 'id';
  static const String nameKey = 'name';

  // Supabase related
  static const String tableName = 'demos';
  static const String selectColumns = 'id, name';
}
