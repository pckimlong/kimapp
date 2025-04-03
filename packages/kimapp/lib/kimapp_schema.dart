// ignore_for_file: unintended_html_in_doc_comment

class Schema {
  final String tableName;
  final String? className;
  final String? baseModelName;

  /// Defines the schema for a database table or model.
  ///
  /// [tableName]: Base name for the schema, typically corresponding to the database table name.
  /// Examples:
  /// - For a `users` table, the name would be `users`
  /// - For a `product_categories` table, the name would be `product_categories`
  /// This name is used as the default for generating class names if [className] is not specified.
  ///
  /// [className]: A human-readable name for the schema, allowing customization of the generated class name.
  /// If not set, [tableName] will be used to generate the class name by converting it to PascalCase.
  /// Examples:
  /// - If [tableName] is `product_categories` and [className] is not set, the generated class name would be `ProductCategory`
  /// - If [tableName] is `product_categories` and [className] is set to `Category`, the generated class name would be `Category`
  ///
  /// [baseModelName]: Name for the base model automatically generated by the code generator.
  /// If not provided, a default name will be constructed using [className] (or [tableName] if [className] is not set)
  /// appended with `BaseModel`.
  /// Examples:
  /// - If [className] is `ProductCategory` and [baseModelName] is not set:
  ///   The generated base model name would be `ProductCategoryBaseModel`
  /// - If [baseModelName] is set to `ProductModel`:
  ///   The generated base model name would be `ProductModel`
  /// - If [tableName] is `users`, [className] is not set, and [baseModelName] is not set:
  ///   The generated base model name would be `UserBaseModel`
  ///
  /// Important: The class annotated with this Schema must extend KimappSchema with one private constructor
  /// for the code generator to function correctly. If the annotated class does not extend KimappSchema,
  /// an error will be thrown during code generation.
  ///
  /// Overall Example:
  ///
  /// ```dart
  /// @Schema(
  ///   tableName: 'users',
  ///   className: 'User',
  ///   baseModelName: 'UserBaseModel',
  /// )
  /// class UserSchema extends KimappSchema {
  ///   UserSchema._();
  ///
  ///   Field get id => Field.id();
  ///   // ...
  /// }
  /// ```
  ///
  /// In this example:
  /// - `tableName` is set to 'users', corresponding to the database table name.
  /// - `className` is set to 'User', which will be used as the generated class name.
  /// - `baseModelName` is set to 'UserBaseModel', which will be the name of the generated base model.
  /// - The class `UserSchema` extends `KimappSchema`, which is required for the code generator to
  ///   successfully generate the necessary code. Failure to extend KimappSchema will result in an error.
  ///
  /// @param tableName: Base name for the schema, typically corresponding to the database table name.
  /// @param className: A human-readable name for the schema, allowing customization of the generated class name.
  /// @param baseModelName: Name for the base model automatically generated by the code generator.
  const Schema({
    required this.tableName,
    this.className,
    this.baseModelName,
  });
}

class Model {
  final String _name;
  final List<BaseField> _fields;
  final bool _inherited;
  final String? _tableName;

  Model._(this._name, this._fields, this._inherited, this._tableName);

  factory Model(String name) {
    return Model._(name, [], false, null);
  }

  /// Inherits all fields from the base model defined in the schema.
  ///
  /// This method allows a derived model to automatically include all fields
  /// from its base model, with the option to exclude specific fields.
  ///
  /// Usage:
  /// ```dart
  /// class UserSchema extends KimappSchema2 {
  ///   final id = Field.id<int>().withGenerateAs('DemoId');
  ///   final name = Field<String>();
  ///   final email = Field<String>();
  ///
  ///   @override
  ///   List<Model> get models {
  ///     return [
  ///       Model('UserDetailModel').inheritAllFromBase(),
  ///       Model('UserLiteModel').inheritAllFromBase(excepts: [email]),
  ///     ];
  ///   }
  /// }
  /// ```
  ///
  /// In this example:
  /// - 'UserDetailModel' inherits all fields (id, name, email) from the base model.
  /// - 'UserLiteModel' inherits all fields except 'email'.
  ///
  /// @param excepts An optional list of BaseField objects to exclude from inheritance.
  ///                These fields will not be included in the derived model.
  ///
  /// @return A new Model instance with inherited fields, excluding any specified in 'excepts'.
  ///
  /// Note: This method is particularly useful for creating variations of a base model
  /// with different field subsets, without manually redefining shared fields.
  Model inheritAllFromBase({List<BaseField> excepts = const []}) {
    return Model._(_name, [..._fields], true, _tableName);
  }

  /// Adds additional fields to the model.
  ///
  /// This method allows a derived model to add additional fields to its definition.
  /// It's useful for extending the model with new fields that are not present in the base model.
  ///
  /// Usage:
  /// ```dart
  /// Model('UserExtendedModel')
  ///   .inheritAllFromBase()
  ///   .addFields({
  ///     'lastLoginDate': Field<DateTime>('last_login_date'),
  ///     'profilePicture': Field<String>('profile_picture')
  ///   });
  /// ```
  ///
  /// @param fields A map of field names to BaseField objects to add to the model.
  /// @return A new Model instance with the additional fields appended to existing fields.
  ///
  /// Note: This method creates a new Model instance and does not modify the original.
  /// The new fields are added to the end of the existing field list.
  Model addFields(Map<String, BaseField> fields) {
    return Model._(_name, [..._fields, ...fields.values], _inherited, _tableName);
  }

  /// Specifies a custom table name for the model, useful for Supabase integration.
  ///
  /// This method allows to generate models as table models which useful for supabase integration
  ///
  /// @param tableName The custom table name to use for this model. If null, the model will use
  ///                  the default table name as specified in the [Schema] annotation.
  Model table([String? tableName]) {
    return Model._(_name, _fields, _inherited, tableName);
  }
}

/// Base class for defining a schema for the Kimapp code generator.
///
/// This class is abstract and must be extended by concrete implementations.
/// It provides a list of models that are part of the schema.
abstract class KimappSchema {
  /// List of additional models that are part of the schema.
  ///
  /// This getter should be overridden in concrete implementations to define the models
  /// for the schema. Each model in the list represents a different entity or view
  /// in your data structure.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// List<Model> get models {
  ///   return [
  ///     Model('UserDetailModel')
  ///         .table('v_user_detail')
  ///         .addFields({'id': id, 'name': name})
  ///         .inheritAllFromBase(),
  ///     Model('UserLiteModel')
  ///         .table('v_user_lite')
  ///         .inheritAllFromBase(excepts: [description, createdBy]),
  ///   ];
  /// }
  /// ```
  ///
  /// For more details on how to use the Model class and its methods like
  /// `table()`, `addFields()`, and `inheritAllFromBase()`, refer to the
  /// documentation of the Model class.
  ///
  List<Model> get models => [];
}

abstract class BaseField<DataType> {
  final String? key;
  final bool ignoreInClassGenerator;

  const BaseField({
    required this.key,
    this.ignoreInClassGenerator = false,
  });
}

class Field<DataType> extends BaseField<DataType> {
  Field(String key) : super(key: key);

  /// Represents a field as an identity field.
  ///
  /// This method creates an identity field, typically used for primary keys or unique identifiers.
  /// It generates an IdField instance with the specified key.
  ///
  /// The generic type parameter <T> represents the data type of the identity field (e.g., int, String).
  ///
  /// Usage:
  /// ```dart
  /// final id = Field.id<int>('id');
  /// final uuid = Field.id<String>('uuid');
  /// ```
  ///
  /// @param key The name of the field to be used as the identity field in the database.
  /// @return An IdField<T> instance representing the identity field.
  ///
  /// Note:
  /// - The generated field will have special handling in the model and table classes.
  /// - Ensure that the key matches the actual column name in your database schema.
  /// - The type parameter <T> should match the data type used in your database for this field.
  /// - This field is typically used for primary keys or unique identifiers in your data model.
  /// - The IdField can be further customized using the `generateAs()` method to specify a custom class name for the generated ID type.
  static IdField<T> id<T>(String key) => IdField<T>(key);

  /// Creates a join field to establish a relationship with another table model class.
  ///
  /// This method is used to define a join relationship between two models. It's particularly
  /// useful for representing foreign key relationships in your data model.
  ///
  /// The generic type parameter <T> should be the type of the related model class.
  ///
  /// Usage:
  /// ```dart
  /// final user = Field.join<UserModel>()
  ///   .withForeignKey('user_id')
  ///   .withCandidateKey('id');
  /// ```
  ///
  /// In this example:
  /// - `UserModel` is the related model class.
  /// - 'user_id' is the foreign key in the current model.
  /// - 'id' is the candidate key (usually the primary key) in the `UserModel`.
  ///
  /// Important:
  /// 1. The type parameter <T> must be a class annotated with @TableModel.
  /// 2. This method returns a JoinField<T> instance, which should be further configured
  ///    using the `withForeignKey()` and `withCandidateKey()` methods.
  /// 3. Ensure that the foreign key and candidate key names match the actual field names
  ///    in your database schema to maintain data integrity.
  ///
  /// @return A new instance of JoinField<T> for further configuration.
  static JoinField<T> join<T>() => JoinField<T>();

  /// Creates an IgnoreField that is excluded from the model class generation
  /// but is still included in the table class definition.
  ///
  /// This method is used to define fields that should not be part of the generated
  /// model class, but are still important for the database schema or table constraints.
  /// It's particularly useful for fields that are managed by the database itself or
  /// for fields that should not be directly accessible in the application layer.
  ///
  /// Usage:
  /// ```dart
  /// final hiddenField = Field.ignore('secret_column');
  /// ```
  ///
  /// This will result in:
  /// ```dart
  /// class ExampleTable {
  ///    static const String secretColumn = 'secret_column';
  ///    // ... other fields ...
  /// }
  /// ```
  /// But `secretColumn` will not appear in the generated model class.
  ///
  /// @param key The name of the field to be ignored in the model class generation.
  /// @return An IgnoreField instance representing the ignored field.
  ///
  /// Note: While this field is ignored in the model, it's crucial to ensure that
  /// the database schema is consistent with this definition to avoid runtime errors.
  static IgnoreField ignore(String key) => IgnoreField(key);
}

/// Represents a field as an ignored field.
class IgnoreField extends BaseField {
  const IgnoreField(String key) : super(key: key);
}

/// Represents a field as an identity field.
class IdField<DataType> extends BaseField<DataType> {
  final String? generatedName;

  /// Represents an identity field in the database, typically used for primary keys or unique identifiers.
  ///
  /// This class extends [BaseField] and is specifically designed to handle identity fields
  /// in database schemas. It's commonly used to represent primary keys, auto-incrementing fields,
  /// or any unique identifier for database records.
  ///
  /// Features:
  /// - Automatically sets up the field as an identity field in the schema.
  /// - Can be used with various data types (int, String, UUID, etc.) as specified by [DataType].
  /// - Supports custom generation of ID class names through the [generateAs] method.
  ///
  /// Usage:
  /// ```dart
  /// final idField = IdField<int>('id');
  /// ```
  ///
  /// By default, the generated ID class name will be derived from the schema name
  /// by appending 'Id'. For example, if the schema name is 'User', the default
  /// ID class name will be 'UserId'.
  ///
  /// To specify a custom name for the generated ID class, use the [generateAs] method:
  /// ```dart
  /// final idField = IdField<int>('id').generateAs('CustomUserId');
  /// ```
  ///
  /// @param key The name of the field to be used as the identity field in the database.
  ///            This is typically the primary key column in the table.
  ///
  /// Note: The [generatedName] is initially set to null. Use the [generateAs] method
  /// to specify a custom class name for the generated identity field if needed.
  const IdField(String key)
      : generatedName = null,
        super(key: key);

  const IdField._(String key, String? generateIdClassNameAs)
      : generatedName = generateIdClassNameAs,
        super(key: key);

  /// Specifies a custom class name for the generated identity field.
  ///
  /// By default, if this method is not called, the ID class name will be generated
  /// by appending 'Id' to the [Schema.name]. For example, if the schema name is 'User',
  /// the default ID class name will be 'UserId'.
  ///
  /// This method allows you to override the default naming convention and provide
  /// a custom class name for the generated ID class. This can be particularly useful for:
  /// - Maintaining consistent naming conventions across your project
  /// - Improving clarity in larger projects with multiple schemas
  /// - Avoiding naming conflicts with existing classes
  ///
  /// @param idClassName A String representing the custom class name to be used for the generated identity field.
  ///
  /// @return A new [IdField] instance with the specified custom class name.
  ///
  /// Example usage:
  /// ```dart
  /// final id = Field.id<int>('id').generateAs('CustomUserId');
  /// ```
  ///
  /// Note: It's important to choose a unique and meaningful name for your custom ID class
  /// to prevent naming conflicts and maintain code readability.
  IdField<DataType> generateAs(String idClassName) => IdField._(key!, idClassName);
}

/// Represents a field as a join field. This mostly design for supabase select statement
class JoinField<DataType> extends BaseField<DataType> {
  final String? foreignKey;
  final String? candidateKey;

  const JoinField({
    this.foreignKey,
    this.candidateKey,
  }) : super(key: null);

  /// Specifies the foreign key for the join relationship.
  ///
  /// foreight Key will automatically add to class as ignore field
  ///
  /// @param key The name of the foreign key in the database.
  /// @return A new [JoinField] instance with the specified foreign key.
  JoinField<DataType> withForeignKey(String key) => JoinField(
        foreignKey: key,
        candidateKey: candidateKey,
      );

  /// Specifies the candidate key for the join relationship.
  ///
  /// @param key The name of the candidate key in the database.
  /// @return A new [JoinField] instance with the specified candidate key.
  JoinField<DataType> withCandidateKey(String key) => JoinField(
        foreignKey: foreignKey,
        candidateKey: key,
      );
}
