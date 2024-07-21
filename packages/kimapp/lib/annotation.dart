/// Annotation to generate a table class containing table name and column names.
/// This can be used in data classes, for example as JSON keys, to help prevent errors.
/// It can also generate a raw data class model if any column string contains a specific format
/// for the generator to create a data class.
class TableStructure {
  const TableStructure(
    this.tableName, {
    required this.columns,
    this.idColumn,
    this.classPrefixName,
    this.additionalClasses = const [],
    this.generateRawClass = false,
    this.rawClassTableMode = true,
  });

  /// List of column names to be generated.
  ///
  /// If any value inside the list contains a colon `:` in the format of `ColumnName:DataType`,
  /// the generator will create a raw data class model along with the table.
  ///
  /// [ColumnName] is the name of the actual database column, usually in snake_case. The generator will
  /// create a camelCase String variable linked to the original snake_case string, e.g.:
  ///
  /// ```dart
  ///   'first_name' => String firstName = 'first_name';
  /// ```
  ///
  /// [DataType] specifies the data type of the column.
  /// 
  /// To generate additional classes, add [...] at the end with the DataType and class indices.
  ///
  /// Example:
  /// Define additional classes:
  /// ```dart
  ///  additionalClasses: ['CreateUserParam', 'UpdateUserParam']
  /// ```
  /// 
  /// Then define columns:
  /// ```dart
  ///  columns: ['first_name:String[0,1]', 'last_name:String[0,1]']
  /// ```
  ///
  /// This will generate 2 additional classes:
  /// ```dart
  ///  class CreateUserParam {
  ///    String firstName;
  ///    String lastName;
  ///  }
  /// class UpdateUserParam {
  ///    String firstName;
  ///    String lastName;
  /// }
  /// ```
  /// The values 0,1 are indices of the additional classes.
  final List<String> columns;

  /// Whether to generate a raw class or not.
  /// 
  /// If true, it will generate a raw class with all columns that have a DataType specified.
  /// Default is false.
  final bool generateRawClass;

  /// If true and [generateRawClass] is true, it will generate raw class with [TableModel] annotation.
  /// default is true.
  final bool rawClassTableMode;

  /// The name of the table.
  final String tableName;

  /// Generates an identity class for the given table if provided and not null.
  ///
  /// Format rule:
  /// `Name:DataType`
  ///
  /// [Name] is the identity class name, which can be customized as needed.
  /// It should be followed by a colon `:`.
  ///
  /// [DataType] is the internal type of the id value in the class, e.g., int, String, etc.
  ///
  /// Example:
  /// ```dart
  ///  idColumn: 'UserId:int'
  /// ```
  final String? idColumn;

  /// Prefix for the table class name.
  ///
  /// By default, the table name will be used as the class name.
  /// This allows you to specify a custom prefix.
  final String? classPrefixName;

  /// Additional classes to generate, including fromJson/toJson handlers.
  ///
  /// Example:
  /// ```dart
  ///  additionalClasses: ['CreateUserParam', 'UpdateUserParam']
  /// ```
  /// 
  /// The fields of each generated class will be affected by how you define [columns].
  /// The structure and types of the generated classes will correspond to the column definitions.
  /// 
  /// You can generate a [TableModel] for a class by appending `:table` to the class name.
  /// 
  /// Example:
  /// ```dart
  /// additionalClasses: ['UserLiteModel:table']
  /// ```
  /// 
  /// This generates a table class. See [TableModel] for more details.
  /// 
  /// To specify a custom table name, use `:table(tableName)`:
  /// 
  /// Example:
  /// ```dart
  /// additionalClasses: ['UserLiteModel:table(users_tbl)']
  /// ```
  /// 
  /// You can also define custom columns for each additional class using square brackets [...].
  /// The format for custom columns is `ColumnName:DataType`, similar to [columns].
  /// 
  /// Example:
  /// ```dart
  /// additionalClasses: [
  ///   'CreateUserParam[firstName:String,lastName:String]', 
  ///   'UpdateUserParam:table[id:int,name:String]'
  /// ]
  /// ```
  /// 
  /// Note: Non-PascalCase column names will be converted to PascalCase for property names,
  /// while preserving the original name in the `@JsonKey` annotation.
  final List<String> additionalClasses;
}

/// Represents a table model with a table name.
class TableModel {
  const TableModel(this.tableName);

  /// The name of the table.
  final String tableName;
}

/// Represents a joined column in a database relationship.
class JoinedColumn {
  const JoinedColumn({
    this.foreignKey,
    this.candidateKey,
  });

  /// The foreign key in the relationship.
  final String? foreignKey;

  /// The candidate key in the relationship.
  final String? candidateKey;
}

/// Annotation to generate a form widget and handle state with ease.
class KimappForm {
  const KimappForm();
}

/// Constant instance of KimappForm for easy use in annotations.
const kimappForm = KimappForm();

/// Annotation to generate a widget with ease.
/// Uses Riverpod selector and generates all widgets from the given return type.
class StateWidget {
  const StateWidget();
}

/// Constant instance of StateWidget for easy use in annotations.
const stateWidget = StateWidget();