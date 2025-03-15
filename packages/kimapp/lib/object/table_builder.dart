import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "table_builder.freezed.dart";

@freezed
sealed class TableBuilder with _$TableBuilder {
  const TableBuilder._();

  const factory TableBuilder({
    required String tableName,
    required List<ColumnBuilder> columns,
  }) = _TableBuilder;

  String get selectStatement => columns.map((e) => e.value).join(', ');
}

@freezed
sealed class ColumnBuilder with _$ColumnBuilder {
  const ColumnBuilder._();

  const factory ColumnBuilder(String column) = _ColumnBuilder;

  const factory ColumnBuilder.join(
    TableBuilder table, {
    String? key,
    String? foreignKey,
    String? candidateKey,
  }) = _Join;

  String get value {
    return switch (this) {
      _ColumnBuilder(:final column) => column,
      _Join(:final table, :final key, :final foreignKey, :final candidateKey) =>
        () {
          final selectStatement = '(${table.selectStatement})';
          final tableName = table.tableName;
          final effectiveKey = key ?? tableName;

          if (candidateKey.isNullOrBlank) {
            return '$effectiveKey:${foreignKey ?? tableName}$selectStatement';
          } else if (candidateKey.isNotNullOrEmpty) {
            return '$effectiveKey:${table.tableName}!$candidateKey$selectStatement';
          } else {
            return '$effectiveKey$selectStatement';
          }
        }(),
    };
  }
}
