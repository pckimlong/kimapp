

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import '../{{name}}.dart';

part '{{name.snakeCase()}}_raw_model.g.dart';
part '{{name.snakeCase()}}_raw_model.freezed.dart';


@freezed
class {{name.pascalCase()}}RawModel with _${{name.pascalCase()}}RawModel, {{name.pascalCase()}}CommonMixin {
  const {{name.pascalCase()}}RawModel._();

  @TableModel({{name.pascalCase()}}Table.table)
  const factory {{name.pascalCase()}}RawModel({
    @JsonKey(name: {{name.pascalCase()}}Table.id) required const {{name.pascalCase()}}Id id,
  }) = _{{name.pascalCase()}}RawModel;

  factory {{name.pascalCase()}}RawModel.fromJson(Map<String, dynamic> json) 
  =>  _${{name.pascalCase()}}RawModelFromJson(json);

  factory {{name.pascalCase()}}RawModel.fromDetailModel({{name.pascalCase()}}DetailModel base) => {{name.pascalCase()}}RawModel(id: base.id);
  
  
  static const TableBuilder table = _table{{name.pascalCase()}}RawModel;
}