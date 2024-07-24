// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TableStructureGenerator
// **************************************************************************

// ignore_for_file: invalid_annotation_target, unused_import
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import 'table_structure_example.dart';

class SampleId extends Identity<int> {
  const SampleId._(this.value);

  @override
  final int value;

  factory SampleId.fromJson(dynamic value) {
    return SampleId._(value);
  }

  factory SampleId.fromValue(int value) {
    return SampleId._(value);
  }
}

class SampleTable {
  const SampleTable._();

  static const String table = "samples";

  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
}
