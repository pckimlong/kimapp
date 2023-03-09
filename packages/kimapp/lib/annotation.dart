class TableStructure {
  const TableStructure(
    this.tableName, {
    required this.columns,
    this.classPrefixName,
  });

  final List<String> columns;
  final String tableName;
  final String? classPrefixName;
}

class TableModel {
  const TableModel(this.tableName);

  final String tableName;
}

class JoinedColumn {
  const JoinedColumn({
    this.foreignKey,
    this.candidateKey,
  });

  final String? candidateKey;
  final String? foreignKey;
}
