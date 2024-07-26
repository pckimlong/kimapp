// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_schema.schema.dart';

// **************************************************************************
// TableModelGenerator
// **************************************************************************

const _tableDemoModel = TableBuilder(
  tableName: "demos",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder.join(InvalidType.table,
        key: "null", candidateKey: null, foreignKey: 'other_id'),
  ],
);

const _tableDemoDetailModel = TableBuilder(
  tableName: "v_demo_detail",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder.join(InvalidType.table,
        key: "null", candidateKey: null, foreignKey: 'other_id'),
  ],
);

const _tableDemoLiteModel = TableBuilder(
  tableName: "test",
  columns: [
    ColumnBuilder('id'),
    ColumnBuilder('name'),
    ColumnBuilder('description'),
    ColumnBuilder.join(InvalidType.table,
        key: "null", candidateKey: null, foreignKey: 'other_id'),
  ],
);
