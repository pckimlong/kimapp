import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'update_{{name.snakeCase()}}_param.g.dart';
part 'update_{{name.snakeCase()}}_param.freezed.dart';


@freezed
class Update{{name.pascalCase()}}Param with _$Update{{name.pascalCase()}}Param {
  const Update{{name.pascalCase()}}Param._();

  const factory Update{{name.pascalCase()}}Param() = _Update{{name.pascalCase()}}Param;

  factory Update{{name.pascalCase()}}Param.fromJson(Map<String, dynamic> json) {
    _$Update{{name.pascalCase()}}ParamFromJson(json);
  }
}