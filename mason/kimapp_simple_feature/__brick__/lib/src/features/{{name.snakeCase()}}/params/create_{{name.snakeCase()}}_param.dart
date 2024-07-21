import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_{{name.snakeCase()}}_param.freezed.dart';
part 'create_{{name.snakeCase()}}_param.g.dart';


@Freezed(toJson: true)
class Create{{name.pascalCase()}}Param with _$Create{{name.pascalCase()}}Param {
  const Create{{name.pascalCase()}}Param._();

  const factory Create{{name.pascalCase()}}Param() = _Create{{name.pascalCase()}}Param;
  
}