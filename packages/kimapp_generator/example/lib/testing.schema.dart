// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappSchemaGenerator
// **************************************************************************

// ignore_for_file: invalid_annotation_target, unused_import
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import 'package:example/freezed_model.dart';
import 'package:example/kimapp_schema_example.schema.dart';
import 'testing.dart';

part 'testing.schema.freezed.dart';
part 'testing.schema.g.dart';

/// Represents the unique identifier for a Testing.
/// This class wraps the `int` value, providing type safety and encapsulation.
class TestingId extends Identity<int> {
  const TestingId._(this.value);

  @override
  final int value;

  /// Creates an instance of TestingId from a JSON value.
  /// Accepts int representations.
  /// Throws ArgumentError if the value is null or not of type int.
  factory TestingId.fromJson(dynamic value) {
    if (value is int) {
      return TestingId._(value);
    } else if (value == null) {
      throw ArgumentError.notNull('value');
    } else {
      throw ArgumentError(
          'Value of TestingId must be of type int, but was ${value.runtimeType}. Please provide the correct type.');
    }
  }

  /// Creates an instance of TestingId from a int value.
  factory TestingId.fromValue(int value) {
    return TestingId._(value);
  }
}

/// Defines the table structure for Testing.
/// This class provides constant string values for table and column names,
/// facilitating type-safe database operations and query building.
class TestingTable {
  const TestingTable._();

  /// The name of the database table for Testing entities.
  /// Use this constant for constructing SQL queries to ensure consistency.
  static const String table = "testings";

  /// Column: id
  /// Represents the id of the Testing entity.
  /// This is the primary key column for the Testing table.
  /// Data type: `int`
  static const String id = "id";

  /// Column: name
  /// Represents the name of the Testing entity.
  /// Data type: `String`
  static const String name = "name";

  /// Column: phone
  /// Represents the phone of the Testing entity.
  /// Data type: `String`
  static const String phone = "phone";

  /// Column: address
  /// Represents the address of the Testing entity.
  /// Data type: `String`
  static const String address = "address";

  /// Column: null_column
  /// Represents the null column of the Testing entity.
  /// Data type: `String?`
  static const String nullColumn = "null_column";

  /// Column: no_included
  /// Represents the no included of the Testing entity.
  static const String noIncluded = "no_included";

  /// List of all column names for Testing table.
  static const List<String> allColumns = [
    id,
    name,
    phone,
    address,
    nullColumn,
    noIncluded,
  ];

  /// List of primary key column names for Testing table.
  static const List<String> primaryKeys = [
    id,
  ];
}

/// Base model class for TestingModel.
@freezed
class TestingModel with _$TestingModel {
  const TestingModel._();

  @TableModel("testings")
  const factory TestingModel({
    /// id field
    @JsonKey(name: "id") required TestingId id,

    /// name field
    @JsonKey(name: "name") required String name,

    /// phone field
    @JsonKey(name: "phone") required String phone,

    /// address field
    @JsonKey(name: "address") required String address,

    /// null_column field
    @JsonKey(name: "null_column") String? nullColumn,

    /// selfref field
    @JoinedColumn(foreignKey: null, candidateKey: null)
    @JsonKey(name: "selfref")
    Example2Model? selfref,

    /// freezedClass field
    @JoinedColumn(foreignKey: null, candidateKey: null)
    @JsonKey(name: "freezedClass")
    required FreezedModel freezedClass,
  }) = _TestingModel;

  /// Creates an instance of TestingModel from a JSON map.
  factory TestingModel.fromJson(Map<String, dynamic> json) =>
      _$TestingModelFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableTestingModel;
}

/// Represents the TestingView model.
@freezed
class TestingView with _$TestingView {
  const TestingView._();

  @TableModel("v_testings")
  const factory TestingView({
    @JsonKey(name: "id") required TestingId id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "phone") required String phone,
    @JsonKey(name: "address") required String address,
    @JsonKey(name: "null_column") String? nullColumn,
    @JoinedColumn(foreignKey: null, candidateKey: null)
    @JsonKey(name: "selfref")
    Example2Model? selfref,
    @JoinedColumn(foreignKey: null, candidateKey: null)
    @JsonKey(name: "freezedClass")
    required FreezedModel freezedClass,
  }) = _TestingView;

  /// Creates an instance of TestingView from a JSON map.
  factory TestingView.fromJson(Map<String, dynamic> json) =>
      _$TestingViewFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableTestingView;
}
