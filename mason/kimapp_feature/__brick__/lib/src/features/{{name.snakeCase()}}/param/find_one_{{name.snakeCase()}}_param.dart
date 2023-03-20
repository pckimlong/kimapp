import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: unused_import
import '../core/{{name.snakeCase()}}_objects.dart';
part 'find_one_{{name.snakeCase()}}_param.freezed.dart';


@freezed
class FindOne{{name.pascalCase()}}Param with _$FindOne{{name.pascalCase()}}Param {
  const FindOne{{name.pascalCase()}}Param._();

  const factory FindOne{{name.pascalCase()}}Param.byId({{name.pascalCase()}}Id {{name.camelCase()}}Id) = _ById;
}