

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import '../core/core.dart';

part '{{name.snakeCase()}}_detail_model.g.dart';
part '{{name.snakeCase()}}_detail_model.freezed.dart';


@freezed
class {{name.pascalCase()}}DetailModel with _${{name.pascalCase()}}DetailModel, {{name.pascalCase()}}CommonMixin {
  const {{name.pascalCase()}}DetailModel._();

  @TableModel({{name.pascalCase()}}Table.table)
  const factory {{name.pascalCase()}}DetailModel({
    @JsonKey(name: {{name.pascalCase()}}Table.id) required  const {{name.pascalCase()}}Id id,
  }) = _{{name.pascalCase()}}DetailModel;

  factory {{name.pascalCase()}}DetailModel.fromJson(Map<String, dynamic> json) 
  =>   _${{name.pascalCase()}}DetailModelFromJson(json);
  
  
  static const TableBuilder table = _table{{name.pascalCase()}}DetailModel;
}