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



/// powerful way to describe your data model compared to the original TableStructure.
///
/// Example:
/// ```dart
/// final userSchema = FlexibleSchemaDefinition(
///   tableName: 'users',
///   columns: [
///     ColumnDefinition('first_name', String, includeIn: ['CreateUserDTO', 'UserViewModel']),
///     ColumnDefinition('last_name', String, includeIn: ['CreateUserDTO', 'UserViewModel']),
///     ColumnDefinition('email', String, includeIn: ['CreateUserDTO', 'UserViewModel']),
///   ],
///   idColumn: IdColumn('id', int),
///   additionalClasses: [
///     AdditionalClass.builder('CreateUserDTO').build(),
///     AdditionalClass.builder('UserViewModel').build(),
///   ],
/// );
/// ```
class FlexibleSchemaBuilder {
  /// Constructs a FlexibleSchemaDefinition with the given properties.
  ///
  /// [tableName] is required and should match the name in your database.
  /// [columns] is a list of [ColumnDefinition]s that define the table's structure.
  /// [idColumn] is optional but recommended for most tables.
  /// [classPrefixName] can be used to maintain naming conventions across your project.
  /// [additionalClasses] allows you to define related classes like DTOs or view models.
  const FlexibleSchemaBuilder({
    required this.tableName,
    required this.columns,
    this.idColumn,
    this.classPrefixName,
    this.additionalClasses = const [],
  });

  /// The name of the database table.
  final String tableName;

  /// The list of columns in the table.
  ///
  /// Each [ColumnDefinition] can specify which additional classes it should be included in,
  /// allowing for flexible reuse of column definitions.
  final List<ColumnDefinition> columns;

  /// The primary key column of the table.
  ///
  /// This is optional, but recommended for most tables to ensure type safety.
  final IdColumn? idColumn;

  /// A prefix to be used for generated class names.
  ///
  /// This is useful for maintaining naming conventions across your project.
  /// For example, a prefix of "Tbl" could result in generated classes like "TblUser".
  final String? classPrefixName;

  /// Additional classes to be generated based on this schema definition.
  ///
  /// These can include DTOs, view models, or other related classes.
  /// Use [AdditionalClass.builder] to create instances for this list.
  final List<AdditionalClass> additionalClasses;
}


/// Represents a column in the database table.
///
/// This class allows you to define not just the column's properties,
/// but also which additional classes should include this column.
///
/// Example:
/// ```dart
/// ColumnDefinition('email', String, includeIn: ['CreateUserDTO', 'UserViewModel'])
/// ```
class ColumnDefinition {
  /// Constructs a ColumnDefinition with the given name, type, and inclusion list.
  ///
  /// [name] should match the column name in your database.
  /// [type] should be a Dart type corresponding to the database column type.
  /// [includeIn] is an optional list of additional class names where this column should be included.
  const ColumnDefinition(
    this.name,
    this.type, {
    this.includeIn = const [],
  });

  /// The name of the column in the database.
  final String name;

  /// The data type of the column.
  ///
  /// This should be a Dart type that corresponds to the database column type.
  /// Common types include String, int, double, bool, and DateTime.
  final Type type;

  /// A list of additional class names where this column should be included.
  ///
  /// This allows for easy reuse of column definitions across multiple classes.
  /// For example, an 'email' column might be included in both a 'CreateUserDTO'
  /// and a 'UserViewModel'.
  final List<String> includeIn;
}

/// Represents the primary key column of the table.
///
/// While similar to [ColumnDefinition], this class is used specifically for
/// identifying the primary key, which often has special handling in ORMs and
/// database operations.
///
/// Example:
/// ```dart
/// IdColumn('id', int)
/// ```
class IdColumn {
  /// Constructs an IdColumn with the given name and type.
  ///
  /// [name] should match the primary key column name in your database.
  /// [type] is typically int or String, but can be any type supported by your database.
  const IdColumn(this.name, this.type);
  
  /// The name of the ID column.
  final String name;

  /// The data type of the ID column (typically int or String).
  final Type type;
}

/// Represents a column that is joined from another table.
///
/// This is used in table models to define relationships between tables,
/// supporting features like foreign keys and eager loading.
///
/// Example:
/// ```dart
/// JoinedColumn(name: 'role', type: RoleModel, foreignKey: 'role_id')
/// ```
class JoinedTableColumn {
  /// Constructs a [JoinedTableColumn] with the given properties.
  ///
  /// [name] is the name of the property in your model representing the joined data.
  /// [type] is typically another model class representing the joined table's structure.
  /// [foreignKey] is the name of the column in this table that references the joined table.
  const JoinedTableColumn({
    required this.name,
    required this.type,
    required this.foreignKey,
  });

  /// The name of the joined column in this table.
  final String name;

  /// The type of the joined column (usually another model class).
  final Type type;

  /// The name of the foreign key column in this table that links to the other table.
  final String foreignKey;
}

/// Represents an additional class to be generated based on the table structure.
///
/// This can be used for creating DTOs, view models, or other related classes.
/// Use [AdditionalClass.builder] to create instances of this class.
///
/// Example:
/// ```dart
/// AdditionalClass.builder('CreateUserDTO')
///   .addColumn('password', String)
///   .build()
/// ```
class AdditionalClass {
  const AdditionalClass._({
    required this.name,
    required this.columns,
    required this.joinedColumns,
    this.isTableModel = false,
    this.tableName,
  });

  /// The name of the additional class.
  final String name;

  /// The list of columns to be included in this class.
  final List<ColumnDefinition> columns;

  /// The list of joined columns for this class (if it's a table model).
  final List<JoinedTableColumn> joinedColumns;

  /// Indicates whether this class represents a database table.
  ///
  /// If true, appropriate ORM annotations or table-specific code may be generated.
  final bool isTableModel;

  /// The database table name, if different from the class name.
  ///
  /// This is useful when the table name doesn't match the desired class name.
  final String? tableName;

  /// Creates a builder for constructing an AdditionalClass.
  ///
  /// Use this method to start building an AdditionalClass instance.
  /// 
  /// Example:
  /// ```dart
  /// AdditionalClass.builder('UserViewModel')
  ///   .addColumn('fullName', String)
  ///   .build()
  /// ```
  static AdditionalClassBuilder builder(String name) => AdditionalClassBuilder._(name);
}

/// A builder class for creating AdditionalClass instances.
///
/// This uses the builder pattern to provide a fluent API for defining additional classes.
/// Start with [AdditionalClass.builder] and chain method calls to configure the class.
class AdditionalClassBuilder {
  AdditionalClassBuilder._(this.name);

  final String name;
  final List<ColumnDefinition> _columns = [];
  final List<JoinedTableColumn> _joinedColumns = [];
  bool _isTableModel = false;
  String? _tableName;

  /// Adds a regular column to the additional class.
  ///
  /// Use this method to add columns that are specific to this additional class
  /// and not defined in the main table structure.
  ///
  /// Example:
  /// ```dart
  /// AdditionalClass.builder('CreateUserDTO')
  ///   .addColumn('password', String)
  ///   .build()
  /// ```
  AdditionalClassBuilder addColumn(String name, Type type) {
    _columns.add(ColumnDefinition(name, type));
    return this;
  }

  /// Adds a joined column to the additional class.
  ///
  /// This is typically used for table models to define relationships with other tables.
  ///
  /// Example:
  /// ```dart
  /// AdditionalClass.builder('UserWithRoleModel')
  ///   .setTableModel(true)
  ///   .addJoinedColumn('role', RoleModel, 'role_id')
  ///   .build()
  /// ```
  AdditionalClassBuilder addJoinedColumn(String name, Type type, String foreignKey) {
    _joinedColumns.add(JoinedTableColumn(name: name, type: type, foreignKey: foreignKey));
    return this;
  }

  /// Sets whether this additional class represents a database table.
  ///
  /// Set this to true if the class should be treated as a full database entity,
  /// which may affect how ORM annotations or database access code is generated.
  AdditionalClassBuilder setTableModel(bool isTableModel) {
    _isTableModel = isTableModel;
    return this;
  }

  /// Sets a custom table name for this additional class.
  ///
  /// This is useful when the desired class name doesn't match the actual table name.
  ///
  /// Example:
  /// ```dart
  /// AdditionalClass.builder('UserEntity')
  ///   .setTableModel(true)
  ///   .setTableName('tbl_users')
  ///   .build()
  /// ```
  AdditionalClassBuilder setTableName(String tableName) {
    _tableName = tableName;
    return this;
  }

  /// Builds and returns the AdditionalClass instance.
  ///
  /// Call this method after configuring all desired properties to create
  /// the final AdditionalClass instance.
  AdditionalClass build() {
    return AdditionalClass._(
      name: name,
      columns: _columns,
      joinedColumns: _joinedColumns,
      isTableModel: _isTableModel,
      tableName: _tableName,
    );
  }
}