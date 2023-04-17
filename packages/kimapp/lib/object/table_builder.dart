import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartx/dartx.dart';

part "table_builder.freezed.dart";

@freezed
class TableBuilder with _$TableBuilder {
  const TableBuilder._();
  const factory TableBuilder({
    required String tableName,
    required List<ColumnBuilder> columns,
  }) = _TableBuilder;
  String get selectStatement => columns.map((e) => e.value).join(', ');
}

@freezed
class ColumnBuilder with _$ColumnBuilder {
  const ColumnBuilder._();

  const factory ColumnBuilder(String column) = _ColumnBuilder;

  const factory ColumnBuilder.join(
    TableBuilder table, {
    String? key,
    String? foreignKey,
    String? candidateKey,
  }) = _Join;

  String get value {
    return map(
      (value) => value.column,
      join: (value) {
        final selectStatement = '(${value.table.selectStatement})';
        final tableName = value.table.tableName;

        return '${value.key ?? tableName}${value.candidateKey.isNullOrBlank ? ":${value.foreignKey ?? tableName}" : ""}${value.candidateKey.isNotNullOrEmpty ? ":${value.table.tableName}!${value.candidateKey}" : ""}$selectStatement';
      },
    );
  }
}
