import 'package:freezed_annotation/freezed_annotation.dart';

part "{{name.snakeCase()}}_list_pagination_param.freezed.dart";

@freezed
class {{name.pascalCase()}}ListPaginationParam with _${{name.pascalCase()}}ListPaginationParam {
  const factory {{name.pascalCase()}}ListPaginationParam() = _{{name.pascalCase()}}ListPaginationParam;
}
