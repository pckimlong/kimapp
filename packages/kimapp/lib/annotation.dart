/// Allow to code generator to generate a table class contain name and columns name
/// which can be use in side data class for example as a json key, which will be help error prone
/// and also generate a raw data class model if any column string contain specific format for
/// generator to generate data class
class TableStructure {
  const TableStructure(
    this.tableName, {
    required this.columns,
    this.idColumn,
    this.classPrefixName,
  });

  /// List of columns names which will be generate
  ///
  /// If any value inside the list contain semicolon `:` in format of `ColumnName:DataType`
  ///
  /// Generator will generate a raw data class model along with table
  /// but if column contain `:` but in a incorrect format build will fail
  ///
  /// [ColumnName] is the name of real database column usually it a snake_case string, generator will
  /// generate a camelCase String variable link to original snake_case string eg
  ///
  /// ```dart
  ///   'first_name' => String firstName = 'first_name';
  /// ```
  ///
  /// [DataType] is a data type of the column
  final List<String> columns;

  /// Table name
  final String tableName;

  /// Generate identity class for given table if provided or not null
  ///
  /// Format rule:
  /// `Name:DataType`
  ///
  /// [Name] is identity class name, you can customize whatever you want
  /// suffix with :
  ///
  /// [DataType] is internal type of id value in the class, eg int, String...
  ///
  /// Example
  /// ```dart
  ///  idColumn: 'UserId:int'
  /// ```
  final String? idColumn;

  /// Prefix table class name to any given name
  ///
  /// by default table name will be use as class name
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

/// Generate form widget and handle state with ease
class KimappForm {
  const KimappForm();
}

const kimappForm = KimappForm();
