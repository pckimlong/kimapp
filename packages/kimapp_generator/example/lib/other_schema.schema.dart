// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// KimappSchemaGenerator
// **************************************************************************

// Generated from: other_schema.dart
//
// Generated Classes:
// - OtherTable: Static constants for table/column names - table, id, name
// - OtherId: Identity<int> wrapper for other primary key
// - OtherModel: id:OtherId, name:String

// ignore_for_file: invalid_annotation_target, unused_import, require_trailing_commas
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';
import 'other_schema.dart';
part 'other_schema.schema.freezed.dart';
part 'other_schema.schema.g.dart';

class OtherTable {
  const OtherTable._();
  static const String table = "others";
  static const String id = "id";
  static const String name = "name";
}

class OtherId extends Identity<int> {
  const OtherId._(this.value);
  @override
  final int value;
  factory OtherId.fromJson(dynamic value) {
    if (value is int) {
      return OtherId._(value);
    } else if (value == null) {
      throw ArgumentError.notNull('value');
    } else {
      throw ArgumentError(
          'Value of OtherId must be of type int, but was ${value.runtimeType}. Please provide the correct type.');
    }
  }
  factory OtherId.fromValue(int value) {
    return OtherId._(value);
  }

  /// Creates an instance of OtherId with a value of -1.
  /// This is used to represent an empty or invalid OtherId for placeholder or default values of form fields.
  /// WARNING: This is not a valid OtherId access it value through [value] or [call] will throw an error.
  factory OtherId.empty() => OtherId._(-1);
}

abstract class BaseOtherSchema {}

abstract class IOtherModel {
  OtherId get id;
  String get name;
}

@freezed
sealed class OtherModel
    with _$OtherModel
    implements BaseOtherSchema, IOtherModel {
  const OtherModel._();
  @TableModel(OtherModel.tableName)
  @JsonSerializable(explicitToJson: true)
  const factory OtherModel({
    @JsonKey(name: "id") required OtherId id,
    @JsonKey(name: "name") required String name,
  }) = _OtherModel;
  factory OtherModel.fromJson(Map<String, dynamic> json) =>
      _$OtherModelFromJson(json);
  static const TableBuilder table = _tableOtherModel;
  static const String tableName = "others";
}
