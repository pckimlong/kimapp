

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import '../{{name}}.dart';

part '{{name.snakeCase()}}_model.g.dart';
part '{{name.snakeCase()}}_model.freezed.dart';


@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model, {{name.pascalCase()}}CommonMixin {
  const {{name.pascalCase()}}Model._();

  @TableModel({{name.pascalCase()}}Table.table)
  const factory {{name.pascalCase()}}Model({
    @JsonKey(name: {{name.pascalCase()}}Table.id) required const {{name.pascalCase()}}Id id,
  }) = _{{name.pascalCase()}}Model;

  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) 
  =>  _${{name.pascalCase()}}ModelFromJson(json);

  factory {{name.pascalCase()}}Model.fromDetailModel({{name.pascalCase()}}DetailModel base) => {{name.pascalCase()}}Model(id: base.id);
  
  static const TableBuilder table = _table{{name.pascalCase()}}Model;
}