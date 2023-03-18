import 'package:freezed_annotation/freezed_annotation.dart';
part 'find_one_{{name.snakeCase()}}_param.freezed.dart';


@freezed
class FindOne{{name.pascalCase()}} with _$FindOne{{name.pascalCase()}} {
  const FindOne{{name.pascalCase()}}._();

  const factory FindOne{{name.pascalCase()}}.byId({{name.pascalCase()}}Id {{name.camelCase()}}Id) = _ById;
}