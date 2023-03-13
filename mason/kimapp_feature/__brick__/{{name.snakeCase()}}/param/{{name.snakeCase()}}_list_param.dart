import 'package:freezed_annotation/freezed_annotation.dart';

part "{{name.snakeCase()}}_list_param.freezed.dart";

@freezed
class {{name.pascalCase()}}ListParam with _${{name.pascalCase()}}ListParam {
  const factory {{name.pascalCase()}}ListParam({@Default(50) int limit,}) = _{{name.pascalCase()}}ListParam;
}
