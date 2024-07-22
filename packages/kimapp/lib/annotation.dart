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
    this.customTypes = const [],
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

    /// Specifies custom types to be used in the generated classes.
  ///
  /// This is required when you want to use custom types in the generated classes.
  /// It ensures correct imports and type usage in the generated code.
  ///
  /// Example:
  /// ```dart
  /// customTypes: [IList, ISet, CustomType]
  /// ```
  ///
  /// The builder will throw an error if a custom type is used in a column definition
  /// but not provided in this list.
  ///
  /// Custom types are any types that are not Dart core types.
  /// Dart core types (which don't need to be specified here) include:
  /// String, int, double, bool, DateTime, Map, List, Set, and Object.
  ///
  /// Use this to ensure proper type handling and import generation for your custom types.
  final List<Type> customTypes;

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
  /// 
  /// You can define joined columns for additional classes by adding parentheses
  /// after the column's data type, specifying the foreign key.
  /// This feature is only available when using `:table` for the additional class.
  ///
  /// Example:
  /// ```dart
  /// additionalClasses: ['User:table(users)[id:int, name:String, user:UserModel(created_by)]']
  /// ```
  ///
  /// This will generate a Table model as:
  ///
  /// ```dart
  /// class User {
  ///   // other columns
  ///   @JoinColumn(foreignKey: 'created_by')
  ///   required UserModel user;
  /// }
  /// ```
  ///
  /// Important notes:
  /// 1. This feature is only available for additional classes, not for the main columns.
  /// 2. The joined table (e.g., UserModel) must also be annotated with @TableModel.
  /// 3. Use this syntax: `columnName:DataType(foreignKey)` for joined columns.
  /// 4. The `:table` suffix is required to enable this feature for an additional class.
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
