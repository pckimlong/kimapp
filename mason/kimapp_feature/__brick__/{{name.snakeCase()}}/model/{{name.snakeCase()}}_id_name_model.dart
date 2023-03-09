import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import './../core/core.dart';

part '{{name.snakeCase()}}_id_name_model.g.dart';
part '{{name.snakeCase()}}_id_name_model.freezed.dart';


@freezed
class {{name.pascalCase()}}IdNameModel with _${{name.pascalCase()}}IdNameModel, {{name.pascalCase()}}CommonMixin {
  const {{name.pascalCase()}}IdNameModel._();

  @TableModel({{name.pascalCase()}}sTable.table)
  const factory {{name.pascalCase()}}IdNameModel({
    @JsonKey(name: {{name.pascalCase()}}sTable.id) required {{name.pascalCase()}}Id id,
  }) = _{{name.pascalCase()}}IdNameModel;

  factory {{name.pascalCase()}}IdNameModel.fromJson(Map<String, dynamic> json) {
    _${{name.pascalCase()}}IdNameModelFromJson(json);
  }
  
  static const TableBuilder table = _table{{name.pascalCase()}}IdNameModel;

  @override
  {{name.pascalCase()}}Id get identity => this.id;
}