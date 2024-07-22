/// Represents the schema configuration for a Kimapp database table.
///
/// This class is used as an annotation to define the structure and properties
/// of a database table in the Kimapp framework. It includes information about
/// the table name, associated Dart class names, columns, and additional models.
///
/// Usage:
/// ```dart
/// @KimappSchema(
///   tableName: "users",
///   className: 'User',
///   baseModelName: 'UserModel',
///   columns: [
///     IdField('id', generateAs: 'UserId', type: 'int'),
///     Field('name', type: 'String', addToModels: ['CreateUserParam', 'UpdateUserParam']),
///     // ... other fields
///   ],
///   models: [
///     Model(name: 'CreateUserParam'),
///     Model(name: 'UpdateUserParam'),
///     // ... other models
///   ],
/// )
/// ```
class KimappSchema {
  /// Creates a new instance of [KimappSchema].
  ///
  /// All parameters contribute to defining the structure and behavior of the database table
  /// and its associated Dart classes.
  const KimappSchema({
    required this.tableName,
    required this.columns,
    this.baseModelName,
    this.className,
    this.models = const [],
  });

  /// The name of the database table this schema represents.
  ///
  /// This is a crucial identifier for the schema and should match the actual table name in the database.
  /// 
  /// Example:
  /// ```dart
  /// tableName: 'users'
  /// ```
  final String tableName;

  /// The name of the generated Dart class for this schema.
  /// 
  /// If not provided, it will be automatically derived from [tableName], capitalizing the first letter.
  /// 
  /// It's strongly recommended to provide this explicitly to ensure correct naming,
  /// as it's used to generate other related classes and avoid potential naming conflicts.
  /// 
  /// Example:
  /// ```dart
  /// className: 'User'  // For a 'users' table
  /// ```
  /// 
  /// This will be used to generate classes like `UserRawModel`, `UserTable`, etc.
  final String? className;

  /// The name of the base model class for this schema.
  /// 
  /// If not provided, it defaults to [className] suffixed with 'RawModel'.
  /// This class typically represents the raw data structure of the table and serves
  /// as a foundation for other model classes.
  /// 
  /// Example:
  /// ```dart
  /// baseModelName: 'UserRawModel'  // For a 'User' class
  /// ```
  final String? baseModelName;

  /// The list of columns for this table schema.
  /// 
  /// Each column is represented by a [Field] object or its subclasses.
  /// Columns defined here will be included in the table constraint class and potentially in other generated models.
  /// 
  /// There are three types of columns:
  /// 1. [IdField]: Represents a primary key column. Always added to the table constraint class and base model.
  /// 2. [JoinField]: Represents a foreign key column. By default, ignored in the table constraint class.
  /// 3. [Field]: Represents a standard column.
  /// 
  /// If a column has a type specified as a String, it will be added as a field to the [baseModel].
  /// If [addToModels] is specified for a column, it will be added to the specified models in the [models] list.
  /// 
  /// Note: If a model name in [addToModels] doesn't exist in [models], an error will be thrown during code generation.
  /// 
  /// Example:
  /// ```dart
  /// columns: [
  ///   IdField('id', generateAs: 'UserId', type: 'int'),
  ///   Field('name', type: 'String', addToModels: ['CreateUserParam', 'UpdateUserParam']),
  ///   JoinField('createdBy', type: 'int', foreignKey: 'created_by'),
  /// ]
  /// ```
  final List<Field> columns;

  /// Additional model classes to be generated based on this schema.
  /// 
  /// These models can include fields from [columns] (specified by [addToModels])
  /// and can also have their own additional fields. This allows for creating
  /// specialized models for different use cases (e.g., creation, updating, listing).
  /// 
  /// Key points:
  /// - Models can incorporate fields from [columns] using [addToModels].
  /// - Models can define their own unique fields not present in the main table.
  /// - Duplicate field definitions (in both [columns] and model-specific fields) will raise an error.
  /// - Use [SupabaseTable] with [Model] to designate it as a table model, facilitating Supabase integration.
  /// 
  /// Example:
  /// ```dart
  /// models: [
  ///   Model(name: 'CreateUserParam'),
  ///   Model(name: 'UpdateUserParam'),
  ///   Model(
  ///     name: 'UserListParam',
  ///     columns: [Field('type', type: 'String')]
  ///   ),
  ///   Model(
  ///     name: 'UserTable',
  ///     supabaseTable: SupabaseTable(tableName: 'users')
  ///   ),
  /// ]
  /// ```
  /// 
  /// This structure allows for flexible model creation, including input parameters,
  /// custom models, and Supabase-compatible table models, enhancing the versatility of the generated code.
  final List<Model> models;
}

/// Represents an ID field in a database table, typically used as a primary key.
///
/// This class extends [Field] and adds specific functionality for ID columns.
/// ID fields are crucial for uniquely identifying records in a table and often
/// have special handling in database operations and ORM mappings.
///
/// Example:
/// ```dart
/// IdField(
///   'user_id',
///   generateAs: 'UserId',
///   type: 'int',
///   addToModels: ['UserDetails', 'UserProfile'],
/// )
/// ```
class IdField extends Field {
  /// Creates an [IdField] instance.
  ///
  /// [name]: The name of the ID field in the database.
  /// [generateAs]: The name to use when generating the ID type.
  /// [type]: The Dart type of the ID field as a String (e.g., 'int', 'String').
  /// [addToModels]: Optional list of model names to include this field in.
  const IdField(
    super.name, {
    required this.generateAs,
    required super.type,
    super.addToModels,
  });

  /// The name to use when generating the ID type.
  ///
  /// This is used to create a custom type for the ID, enhancing type safety and clarity in the generated code.
  /// By default, it will use [className] in [KimappSchema] suffixed with 'Id'.
  /// For example, if the class name is 'User', generateAs might be 'UserId'.
  final String generateAs;
}

/// Represents a join field in a database table, typically used for foreign key relationships.
///
/// This class extends [Field] and adds specific functionality for join columns.
/// Join fields are essential for establishing relationships between tables and
/// often require special handling in queries and data operations.
///
/// Example:
/// ```dart
/// JoinField(
///   'department',
///   type: 'int',
///   foreignKey: 'department_id',
///   addToModels: ['EmployeeDetails'],
/// )
/// ```
class JoinField extends Field {
  /// Creates a [JoinField] instance.
  ///
  /// [name]: The name of the join field in the generated model class. e.g., 'department'
  /// [type]: The Dart type of the join field as a String.
  /// [foreignKey]: Optional foreign key reference (e.g., 'department_id').
  /// [candidateKey]: Optional candidate key in the referenced table.
  /// [addToModels]: Optional list of model names to include this field in.
  /// [ignoreRaw]: If true, this field will be excluded from the raw model class.
  const JoinField(
    super.name, {
    required super.type,
    this.foreignKey,
    this.candidateKey,
    super.addToModels,
    super.ignoreRaw,
  });

  /// The foreign key reference, typically in the format 'table.column'.
  ///
  /// This specifies the column in the current table that references another table.
  /// It's crucial for establishing the relationship between tables.
  final String? foreignKey;

  /// The candidate key in the referenced table, if different from its primary key.
  ///
  /// This is used when the foreign key references a unique column in the related table
  /// that is not the primary key.
  final String? candidateKey;
}

/// Represents a Supabase table configuration.
///
/// This class is used to instruct the code generator to generate a model as a Kimapp table model,
/// which is compatible with Supabase operations. It allows for seamless integration between
/// the generated Dart models and Supabase tables.
///
/// Example:
/// ```dart
/// SupabaseTable(tableName: 'users')
/// ```
class SupabaseTable {
  /// Creates a [SupabaseTable] instance.
  ///
  /// [tableName]: The name of the table in Supabase.
  const SupabaseTable({
    this.tableName,
  });

  /// The name of the table in Supabase.
  ///
  /// If not provided, it will be derived from [tableName] in [KimappSchema].
  /// This allows for flexibility in naming, especially when the Dart model name
  /// differs from the actual table name in Supabase.
  final String? tableName;
}

/// Represents a field in a database table or model.
///
/// This class is the base for all field types and can be used for standard columns.
/// It provides the foundation for defining various types of data fields in models,
/// including basic data types, custom fields, and fields with specific behaviors.
///
/// Example:
/// ```dart
/// Field(
///   'email',
///   type: 'String',
///   addToModels: ['UserSignup', 'UserProfile'],
///   ignoreRaw: false,
/// )
/// ```
class Field {
  /// Creates a [Field] instance.
  ///
  /// [name]: The name of the field.
  /// [type]: The Dart type of the field as a String (optional).
  /// [addToModels]: List of model names to include this field in.
  /// [ignoreRaw]: If true, this field will be excluded from the raw model class.
  const Field(
    this.name, {
    this.type,
    this.addToModels = const [],
    this.ignoreRaw = false,
  });

  /// The name of the field in the database or model.
  ///
  /// This should match the column name in the database table or the desired
  /// property name in the Dart model.
  final String name;

  /// DataType of the field as a String. If it's nullable, add '?' at the end of the type.
  ///
  /// If null, the field can be included in any model classes but will only be added
  /// to the [className]Table constraint class. This allows for fields that are
  /// present in the database but not necessarily represented in all Dart models.
  ///
  /// Note: I decided to use String instead of actual Dart types in my kimapp_schema
  /// due to build order issues. The generated classes use freezed, and since I run
  /// this before freezed, I can't get the actual types. This is a temporary solution,
  /// and I plan to improve it when I find a better way to handle type information
  /// during code generation.
  final String? type;

  /// List of model names where this field should be included.
  /// 
  /// This allows for selective inclusion of fields in different model types.
  /// If provided names are incorrect, the code generator will throw a detailed error.
  final List<String> addToModels;

  /// If true, the field will not be included in the raw model class.
  ///
  /// This is useful for fields that should be excluded from the base representation
  /// of the model, such as computed fields or fields that are only relevant in
  /// certain contexts.
  final bool ignoreRaw;
}

/// Represents a model in the application, which can correspond to a database table or a custom data structure.
///
/// This class is used to define the structure of models, including their fields and Supabase table information.
/// It allows for creating various types of models, from simple data transfer objects to complex table representations.
///
/// Example:
/// ```dart
/// Model(
///   name: 'User',
///   columns: [
///     Field('name', type: 'String'),
///     Field('age', type: 'int'),
///   ],
///   supabaseTable: SupabaseTable(tableName: 'users'),
/// )
/// ```
class Model {
  /// Creates a [Model] instance.
  ///
  /// [name]: The name of the model.
  /// [columns]: Additional fields/columns in the model.
  /// [supabaseTable]: Optional Supabase table configuration for this model.
  const Model({
    required this.name,
    this.columns = const [],
    this.supabaseTable,
    this.inheritAllFields = false,
  });

  /// The name of the model.
  ///
  /// This will be used as the class name for the generated model in Dart.
  final String name;

  /// List of fields/columns in the model.
  /// 
  /// This field is optional, as the model can inherit fields from [KimappSchema.columns].
  /// However, additional fields can be defined here to extend or override the base schema.
  final List<Field> columns;

  /// Supabase table configuration for this model, if applicable.
  /// 
  /// When provided, this instructs the code generator to create a Kimapp table model,
  /// which includes Supabase-specific functionality for database operations.
  final SupabaseTable? supabaseTable;

  /// If true, all fields in [KimappSchema.columns] will be included in this model. even it not specify in addToModels.
  /// 
  /// default is false.
  final bool inheritAllFields;
}
