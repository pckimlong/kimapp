import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/models.dart';

part "{{name.snakeCase()}}_list_pagination_response.freezed.dart";

@freezed
class {{name.pascalCase()}}ListPaginationResponse with _${{name.pascalCase()}}ListPaginationResponse {
  const {{name.pascalCase()}}ListPaginationResponse._();

  factory {{name.pascalCase()}}ListPaginationResponse({
    required List<{{name.pascalCase()}}Model> items,
    required int count,
  }) = _{{name.pascalCase()}}ListPaginationResponse;
}
