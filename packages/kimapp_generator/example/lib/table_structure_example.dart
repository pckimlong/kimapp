@TableStructure(
  'articles',
  classPrefixName: 'Article',
  idColumn: 'ArticleId:String',
  columns: [
    'article_id',
    'parent_id',
    'link_to_lid',
    'title',
    'image',
    'link',
    'short_description',
    'description',
    'audio',
    'addon',
    'l_id',
    'view',
    'edit_date',
    'published_date',
    'index',
    'is_hidden',
    'redirect_url',
    'ordering',
    'tag',
    'is_full_description',
    'front_page',
  ],
)
import 'package:kimapp/kimapp.dart';

export 'table_structure_example.table.dart';
