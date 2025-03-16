/// Annotation to generate a model class
///
/// Example:
///
/// ```dart
/// @ModelForge(modelName: 'DemoModel')
/// class $DemoModel extends ModelBuilder {
///   Define fields like usual class
/// }
///
/// $DemoModel must define as a public class and prefix with `$` symbol and extends ModelBuilder.
/// this is required, because it will be used by generated classes
class ModelForge {
  /// Allow supabase support if provided, it will generate select statements for models
  final String? supabaseTable;

  /// Allow json serializable support if provided, it will generate fromJson and toJson methods
  /// Default is true
  final bool jsonSerializable;

  /// Name of the super class, it is the name of the class that will extend by all generated models
  /// in current model forge schema. If not provided, it will be generated as [modelName] suffixed with `Base`
  final String? superClassName;

  const ModelForge({this.supabaseTable, this.jsonSerializable = true, this.superClassName});
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

  Model inheritAllFromBase({List<BaseField> excepts = const []}) {
    return Model._(_name, [..._fields], true, _tableName);
  }

  Model addFields(Map<String, BaseField> fields) {
    return Model._(_name, [..._fields, ...fields.values], _inherited, _tableName);
  }

  Model table([String? tableName]) {
    return Model._(_name, _fields, _inherited, tableName);
  }
}

abstract class ModelBuilder {
  const ModelBuilder();
  List<Model> get models => [];
}

abstract class BaseField<DataType> {
  final String? key;
  final bool ignoreInClassGenerator;

  const BaseField({required this.key, this.ignoreInClassGenerator = false});
}

class Field<DataType> extends BaseField<DataType> {
  Field(String key) : super(key: key);

  static IdField<T> id<T>(String key) => IdField<T>(key);

  static JoinField<T> join<T>() => JoinField<T>();

  static IgnoreField ignore(String key) => IgnoreField(key);
}

class IgnoreField extends BaseField {
  const IgnoreField(String key) : super(key: key);
}

class IdField<DataType> extends BaseField<DataType> {
  final String? generatedName;

  const IdField(String key) : generatedName = null, super(key: key);

  const IdField._(String key, String? generateIdClassNameAs)
    : generatedName = generateIdClassNameAs,
      super(key: key);

  IdField<DataType> generateAs(String idClassName) => IdField._(key!, idClassName);
}

class JoinField<DataType> extends BaseField<DataType> {
  final String? foreignKey;
  final String? candidateKey;

  const JoinField({this.foreignKey, this.candidateKey}) : super(key: null);

  JoinField<DataType> withForeignKey(String key) =>
      JoinField(foreignKey: key, candidateKey: candidateKey);

  JoinField<DataType> withCandidateKey(String key) =>
      JoinField(foreignKey: foreignKey, candidateKey: key);
}
