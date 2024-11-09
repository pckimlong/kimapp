// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TableStructureGenerator
// **************************************************************************

// ignore_for_file: invalid_annotation_target, unused_import
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/kimapp.dart';

import 'table_structure_example.dart';

class ArticleId extends Identity<String> {
  const ArticleId._(this.value);

  @override
  final String value;

  factory ArticleId.fromJson(dynamic value) {
    return ArticleId._(value);
  }

  factory ArticleId.fromValue(String value) {
    return ArticleId._(value);
  }
}

class ArticleTable {
  const ArticleTable._();

  static const String table = "articles";

  static const String articleId = "article_id";
  static const String parentId = "parent_id";
  static const String linkToLid = "link_to_lid";
  static const String title = "title";
  static const String image = "image";
  static const String link = "link";
  static const String shortDescription = "short_description";
  static const String description = "description";
  static const String audio = "audio";
  static const String addon = "addon";
  static const String lId = "l_id";
  static const String view = "view";
  static const String editDate = "edit_date";
  static const String publishedDate = "published_date";
  static const String index = "index";
  static const String isHidden = "is_hidden";
  static const String redirectUrl = "redirect_url";
  static const String ordering = "ordering";
  static const String tag = "tag";
  static const String isFullDescription = "is_full_description";
  static const String frontPage = "front_page";
}
