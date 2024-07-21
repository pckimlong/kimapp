import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import '{{name.snakeCase()}}_model.table.dart';

export '{{name.snakeCase()}}_model.table.dart';

part '{{name.snakeCase()}}_model.g.dart';
part '{{name.snakeCase()}}_model.freezed.dart';


@TableStructure(
  '{{name.snakeCase()}}s',
  classPrefixName: '{{name.pascalCase()}}',
  idColumn: '{{name.pascalCase()}}Id:{{id_data_type}}',
  columns: [
    'id',
  ],
)
@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
  const {{name.pascalCase()}}Model._();

  @TableModel({{name.pascalCase()}}Table.table)
  const factory {{name.pascalCase()}}Model({
    @JsonKey(name: {{name.pascalCase()}}Table.id) required {{name.pascalCase()}}Id id,
  }) = _{{name.pascalCase()}}Model;

  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) 
  =>  _${{name.pascalCase()}}ModelFromJson(json);

  static const TableBuilder table = _table{{name.pascalCase()}}Model;
}