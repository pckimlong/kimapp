

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import '../{{name}}.dart';

part '{{name.snakeCase()}}_lite_model.g.dart';
part '{{name.snakeCase()}}_lite_model.freezed.dart';


@freezed
class {{name.pascalCase()}}LiteModel with _${{name.pascalCase()}}LiteModel, {{name.pascalCase()}}CommonMixin {
  const {{name.pascalCase()}}LiteModel._();

  @TableModel({{name.pascalCase()}}Table.table)
  const factory {{name.pascalCase()}}LiteModel({
    @JsonKey(name: {{name.pascalCase()}}Table.id) required const {{name.pascalCase()}}Id id,
  }) = _{{name.pascalCase()}}LiteModel;

  factory {{name.pascalCase()}}LiteModel.fromJson(Map<String, dynamic> json) 
  =>  _${{name.pascalCase()}}LiteModelFromJson(json);

  factory {{name.pascalCase()}}LiteModel.fromModel({{name.pascalCase()}}Model base) => {{name.pascalCase()}}LiteModel(id: base.id);

  factory {{name.pascalCase()}}LiteModel.fromDetailModel({{name.pascalCase()}}DetailModel base) => {{name.pascalCase()}}LiteModel(id: base.id);
  
  
  static const TableBuilder table = _table{{name.pascalCase()}}LiteModel;
}