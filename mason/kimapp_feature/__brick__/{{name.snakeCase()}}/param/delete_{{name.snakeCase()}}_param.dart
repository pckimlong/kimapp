import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
// ignore: unused_import
import '../core/core.dart';
part 'delete_{{name.snakeCase()}}_param.g.dart';
part 'delete_{{name.snakeCase()}}_param.freezed.dart';


@freezed
class Delete{{name.pascalCase()}}Param with _$Delete{{name.pascalCase()}}Param {
  const Delete{{name.pascalCase()}}Param._();

  const factory Delete{{name.pascalCase()}}Param({
    required {{name.pascalCase()}}Id {{name.camelCase()}}Id,
  }) = _Delete{{name.pascalCase()}}Param;

  factory Delete{{name.pascalCase()}}Param.fromJson(Map<String, dynamic> json) 
  =>  _$Delete{{name.pascalCase()}}ParamFromJson(json);
  
}