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
class ExmapleId extends Identity<int> {
  const ExmapleId._(this.value);

  @override
  final int value;

  factory ExmapleId.fromJson(dynamic value) {
    return ExmapleId._(value);
  }

  factory ExmapleId.fromValue(int value) {
    return ExmapleId._(value);
  }
}

/// Defines the table structure for Example.
class ExampleTable {
  const ExampleTable._();

  /// The name of the database table.
  static const String table = "exampleses";

  /// Column: id
  static const String id = "id";

  /// Column: name
  static const String name = "name";

  /// Column: age
  static const String age = "age";
}

/// Base model class for ExampleModel.
@freezed
class ExampleModel with _$ExampleModel {
  const ExampleModel._();

  @TableModel("exampleses")
  const factory ExampleModel({
    /// id field
    @JsonKey(name: "id") required int id,

    /// name field
    @JsonKey(name: "name") required String name,

    /// age field
    @JsonKey(name: "age") required int age,
  }) = _ExampleModel;

  /// Creates an instance of ExampleModel from a JSON map.
  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableExampleModel;
}

/// Represents the CreateExampleParam model.
@freezed
class CreateExampleParam with _$CreateExampleParam {
  const CreateExampleParam._();

  @TableModel("exampleses")
  const factory CreateExampleParam({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "age") required int age,
  }) = _CreateExampleParam;

  /// Creates an instance of CreateExampleParam from a JSON map.
  factory CreateExampleParam.fromJson(Map<String, dynamic> json) =>
      _$CreateExampleParamFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableCreateExampleParam;
}

/// Represents the UpdateExampleParam model.
@freezed
class UpdateExampleParam with _$UpdateExampleParam {
  const UpdateExampleParam._();

  @TableModel("exampleses")
  const factory UpdateExampleParam() = _UpdateExampleParam;

  /// Creates an instance of UpdateExampleParam from a JSON map.
  factory UpdateExampleParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateExampleParamFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableUpdateExampleParam;
}

/// Represents the ExampleView model.
@freezed
class ExampleView with _$ExampleView {
  const ExampleView._();

  @TableModel("v_examples")
  const factory ExampleView() = _ExampleView;

  /// Creates an instance of ExampleView from a JSON map.
  factory ExampleView.fromJson(Map<String, dynamic> json) =>
      _$ExampleViewFromJson(json);

  /// Supabase table configuration for this model.
  static const TableBuilder table = _tableExampleView;
}
