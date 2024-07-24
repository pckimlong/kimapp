// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappSchemaGenerator
// **************************************************************************

// ignore_for_file: invalid_annotation_target, unused_import
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import 'kimapp_schema_example.dart';

part 'kimapp_schema_example.schema.freezed.dart';
part 'kimapp_schema_example.schema.g.dart';

/// Represents the unique identifier for a Example.
/// This class wraps the `int` value, providing type safety and encapsulation.
class ExmapleId extends Identity<int> {
  const ExmapleId._(this.value);

  @override
  final int value;

  /// Creates an instance of ExmapleId from a JSON value.
  /// Accepts int representations.
  /// Throws ArgumentError if the value is null or not of type int.
  factory ExmapleId.fromJson(dynamic value) {
    if (value is int) {
      return ExmapleId._(value);
    } else if (value == null) {
      throw ArgumentError.notNull('value');
    } else {
      throw ArgumentError(
          'Value of ExmapleId must be of type int, but was ${value.runtimeType}. Please provide the correct type.');
    }
  }

  /// Creates an instance of ExmapleId from a int value.
  factory ExmapleId.fromValue(int value) {
    return ExmapleId._(value);
  }
}

/// Defines the table structure for Example.
/// This class provides constant string values for table and column names,
/// facilitating type-safe database operations and query building.
class ExampleTable {
  const ExampleTable._();

  /// The name of the database table for Example entities.
  /// Use this constant for constructing SQL queries to ensure consistency.
  static const String table = "exampleses";

  /// Column: id
  /// Represents the id of the Example entity.
  /// This is the primary key column for the Example table.
  /// Data type: `int`
  static const String id = "id";

  /// Column: name
  /// Represents the name of the Example entity.
  /// Data type: `String`
  static const String name = "name";

  /// Column: phone
  /// Represents the phone of the Example entity.
  /// Data type: `String`
  static const String phone = "phone";

  /// List of all column names for Example table.
  static const List<String> allColumns = [
    id,
    name,
    phone,
  ];

  /// List of primary key column names for Example table.
  static const List<String> primaryKeys = [
    id,
  ];
}

/// Base model class for Example2Model.
@freezed
class Example2Model with _$Example2Model {
  const Example2Model._();

  @TableModel("exampleses")
  const factory Example2Model({
    /// id field
    @JsonKey(name: "id") required ExmapleId id,

    /// name field
    @JsonKey(name: "name") required String name,

    /// phone field
    @JsonKey(name: "phone") required String phone,
  }) = _Example2Model;

  /// Creates an instance of Example2Model from a JSON map.
  factory Example2Model.fromJson(Map<String, dynamic> json) =>
      _$Example2ModelFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableExample2Model;
}

/// Represents the CreateExampleParam model.
@freezed
class CreateExampleParam with _$CreateExampleParam {
  const CreateExampleParam._();

  @TableModel("exampleses")
  const factory CreateExampleParam({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "phone") required String phone,
  }) = _CreateExampleParam;

  /// Creates an instance of CreateExampleParam from a JSON map.
  factory CreateExampleParam.fromJson(Map<String, dynamic> json) =>
      _$CreateExampleParamFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableCreateExampleParam;
}

/// Represents the ExampleView model.
@freezed
class ExampleView with _$ExampleView {
  const ExampleView._();

  @TableModel("v_examples")
  const factory ExampleView({
    @JsonKey(name: "id") required ExmapleId id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "phone") required String phone,
  }) = _ExampleView;

  /// Creates an instance of ExampleView from a JSON map.
  factory ExampleView.fromJson(Map<String, dynamic> json) =>
      _$ExampleViewFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableExampleView;
}
