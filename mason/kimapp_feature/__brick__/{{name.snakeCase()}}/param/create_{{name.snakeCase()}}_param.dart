import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

part 'create_{{name.snakeCase()}}_param.g.dart';
part 'create_{{name.snakeCase()}}_param.freezed.dart';


@freezed
class Create{{name.pascalCase()}}Param with _$Create{{name.pascalCase()}}Param {
  const Create{{name.pascalCase()}}Param._();

  const factory Create{{name.pascalCase()}}Param() = _Create{{name.pascalCase()}}Param;

  factory Create{{name.pascalCase()}}Param.fromJson(Map<String, dynamic> json) {
    _$Create{{name.pascalCase()}}ParamFromJson(json);
  }
}