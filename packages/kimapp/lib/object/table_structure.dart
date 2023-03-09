abstract class TableStructureClass {
  String get tableName;
  List<String> get columns;

  String get className => tableName;

  /// Generate id object columns if non-null
  ///
  /// ````Map<ObjectName, DataType>````
  ///
  /// [ObjectName] is the name of identity object ````eg. Doctor => DoctorId````
  ///
  /// *Note that generator will automatically add [Id] at the end.*
  /// ```dart
  /// @override
  /// Map<String, Type>? get idColumn => {'Doctor': String};
  /// ```
  Map<String, Type>? idColumn;
}
