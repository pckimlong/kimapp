import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import '../core/core.dart';
part 'delete_{{name.snakeCase()}}_param.freezed.dart';
part 'delete_{{name.snakeCase()}}_param.g.dart';


@Freezed(toJson: true)
class Delete{{name.pascalCase()}}Param with _$Delete{{name.pascalCase()}}Param {
  const Delete{{name.pascalCase()}}Param._();

  const factory Delete{{name.pascalCase()}}Param({
    required const {{name.pascalCase()}}Id const {{name.camelCase()}}Id,
  }) = _Delete{{name.pascalCase()}}Param;

}