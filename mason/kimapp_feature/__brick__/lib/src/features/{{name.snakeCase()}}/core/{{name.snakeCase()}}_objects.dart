@TableStructure(
  '{{name.snakeCase()}}s',
  classPrefixName: '{{name.pascalCase()}}',
  idColumn: '{{name.pascalCase()}}Id:{{id_data_type}}',
  columns: [
    'id',
  ],
)
import 'package:kimapp/kimapp.dart';
import '{{name.snakeCase()}}_objects.table.dart';
export '{{name.snakeCase()}}_objects.table.dart';


mixin {{name.pascalCase()}}CommonMixin {
  {{name.pascalCase()}}Id get id;
}

