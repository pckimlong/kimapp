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
///     IdField('id', generateAs: 'UserId', type: T(int)),
///     Field('name', type: T(String), addToModels: ['CreateUserParam', 'UpdateUserParam']),
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
    required this.fields,
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
  /// If a column has a DataType, it will be added as a field to the [baseModel].
  /// If [addToModels] is specified for a column, it will be added to the specified models in the [models] list.
  /// 
  /// Note: If a model name in [addToModels] doesn't exist in [models], an error will be thrown during code generation.
  /// 
  /// Example:
  /// ```dart
  /// columns: [
  ///   IdField('id', generateAs: 'UserId', type: T(int)),
  ///   Field('name', type: T(String), addToModels: ['CreateUserParam', 'UpdateUserParam']),
  ///   JoinField('createdBy', type: T(int), foreignKey: 'created_by'),
  /// ]
  /// ```
  final List<Field> fields;

  /// Additional model classes to be generated based on this schema.
  /// 
  /// These models can include fields from [fields] (specified by [addToModels])
  /// and can also have their own additional fields. This allows for creating
  /// specialized models for different use cases (e.g., creation, updating, listing).
  /// 
  /// Key points:
  /// - Models can incorporate fields from [fields] using [addToModels].
  /// - Models can define their own unique fields not present in the main table.
  /// - Duplicate field definitions (in both [fields] and model-specific fields) will raise an error.
  /// - Use [SupabaseTable] with [Model] to designate it as a table model, facilitating Supabase integration.
  /// 
  /// Example:
  /// ```dart
  /// models: [
  ///   Model(name: 'CreateUserParam'),
  ///   Model(name: 'UpdateUserParam'),
  ///   Model(
  ///     name: 'UserListParam',
  ///     columns: [Field('type', type: T(String))]
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
///   type: T(int),
///   addToModels: ['UserDetails', 'UserProfile'],
/// )
/// ```
class IdField extends Field {
  /// Creates an [IdField] instance.
  ///
  /// [name]: The name of the ID field in the database.
  /// [generateAs]: The name to use when generating the ID type.
  /// [type]: The type descriptor for the ID field (e.g., T(int), T(String)).
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
/// The type of a JoinField must be a custom type, typically representing the joined entity.
///
/// Example:
/// ```dart
/// JoinField(
///   'department',
///   type: T(Department, 'Department?'),
///   foreignKey: 'department_id',
///   addToModels: ['EmployeeDetails'],
/// )
/// ```
class JoinField extends Field {
  /// Creates a [JoinField] instance.
  ///
  /// [name]: The name of the join field in the generated model class. e.g., 'department'
  /// [type]: The type descriptor for the join field.
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

/// Represents a type descriptor for code generation.
/// It captures information about the base type, nullability, and custom type names.
class T {
  /// The base Type (e.g., int, String, List, Map, etc.)
  final Type type;

  /// Modifier for the type. It can be:
  /// - null: for raw types
  /// - '?': for nullable types
  /// - A custom type name: must match the base Type name, optionally followed by '?'
  final String? typeModifier;

  /// Constructor for T
  /// @param type The base Type
  /// @param typeModifier Optional modifier for nullability or custom type
  /// 
  /// Example:
  /// ```dart
  /// T(int); // base type
  /// T(int, '?'); // base type nullable
  /// T(int, 'UserId'); // custom type
  /// T(int, 'UserId?'); // custom type with nullable
  /// ```
  const T(this.type, [this.typeModifier]);
  

  /// Checks if the type is nullable
  /// @return true if the type is nullable, false otherwise
  bool get isNullable => typeModifier == '?' || (customType?.endsWith('?') ?? false);

  /// Retrieves the custom type name, if any
  /// @return The custom type name without '?', or null if not a custom type
  String? get customType {
    if (typeModifier == null || typeModifier == '?') return null;
    return typeModifier!.endsWith('?') 
        ? typeModifier!.substring(0, typeModifier!.length - 1) 
        : typeModifier;
  }
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
///   type: T(String),
///   addToModels: ['UserSignup', 'UserProfile'],
///   ignoreRaw: false,
/// )
/// ```
class Field {
  /// Creates a [Field] instance.
  ///
  /// [name]: The name of the field in the database or model.
  /// [type]: The type descriptor for the field.
  /// [addToModels]: List of model names to include this field in (optional).
  /// [ignoreRaw]: If true, this field will be excluded from the raw model class (optional).
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

  /// The type descriptor for the field.
  ///
  /// This property specifies the data type of the field using the [T] class.
  /// It supports both primitive Dart types and custom types.
  /// 
  /// Examples:
  /// ```dart
  /// Field('age', type: T(int))
  /// Field('name', type: T(String))
  /// Field('isActive', type: T(bool))
  /// Field('createdAt', type: T(DateTime))
  /// Field('nickname', type: T(String, '?')) // Nullable type
  /// Field('userId', type: T(int, 'UserId')) // Custom type
  /// Field('optionalId', type: T(int, 'UserId?')) // Nullable custom type
  /// ```
  ///
  /// Note: Complex types like List or Map should be handled using custom types.
  /// All custom types that cannot be resolved by the generator will require
  /// explicit specification to ensure proper type handling and code generation.
  final T? type;
  
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
///     Field('name', type: T(String)),
///     Field('age', type: T(int)),
///   ],
///   supabaseTable: SupabaseTable(tableName: 'users'),
///   inheritAllFields: true,
/// )
/// ```
class Model {
  /// Creates a [Model] instance.
  ///
  /// [name]: The name of the model. This will be used as the class name for the generated model in Dart.
  /// [columns]: Additional fields/columns specific to this model. These are optional and can extend or override the base schema.
  /// [supabaseTable]: Optional Supabase table configuration for this model. When provided, it instructs the code generator to create a Kimapp table model with Supabase-specific functionality.
  /// [inheritAllFields]: If true, all fields from [KimappSchema.fields] will be included in this model, even if not specified in addToModels. Defaults to false.
  const Model({
    required this.name,
    this.fields = const [],
    this.supabaseTable,
    this.inheritAllFields = false,
  });

  /// The name of the model.
  ///
  /// This will be used as the class name for the generated model in Dart.
  /// It should follow Dart naming conventions, typically starting with an uppercase letter.
  final String name;

  /// List of fields/columns specific to this model.
  /// 
  /// This property is optional, as the model can inherit fields from [KimappSchema.fields].
  /// However, additional fields can be defined here to extend or override the base schema.
  /// These fields are in addition to any fields inherited from the base schema or included via [addToModels].
  ///
  /// Example:
  /// ```dart
  /// fields: [
  ///   Field('lastLoginDate', type: T(DateTime)),
  ///   Field('isVerified', type: T(bool)),
  /// ]
  /// ```
  final List<Field> fields;

  /// Supabase table configuration for this model, if applicable.
  /// 
  /// When provided, this instructs the code generator to create a Kimapp table model,
  /// which includes Supabase-specific functionality for database operations.
  /// This is particularly useful when the model directly corresponds to a Supabase table.
  ///
  /// Example:
  /// ```dart
  /// supabaseTable: SupabaseTable(tableName: 'users')
  /// ```
  final SupabaseTable? supabaseTable;

  /// Determines whether all fields from [KimappSchema.fields] should be included in this model.
  /// 
  /// If true, all fields in [KimappSchema.fields] will be included in this model, 
  /// even if they are not explicitly specified in [addToModels].
  /// This is useful for creating comprehensive models that include all table fields.
  ///
  /// Default is false, meaning only fields specified in [addToModels] or in this model's [fields] are included.
  ///
  /// Example:
  /// ```dart
  /// inheritAllFields: true
  /// ```
  final bool inheritAllFields;
}