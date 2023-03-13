import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../exports.dart';

extension SupabaseX on Ref {
  SupabaseClient get supabaseClient => read(supabaseProvider).client;

  SupabaseQueryBuilder supabaseTable(String tableName) {
    return supabaseClient.from(tableName);
  }

  PostgrestFilterBuilder<T> supabaseSelect<T>(TableBuilder table) {
    return supabaseTable(table.tableName).select<T>(table.selectStatement);
  }

  PostgrestTransformBuilder<T> supabaseInsertSelect<T>(
    TableBuilder table, {
    required Map<String, dynamic> value,
  }) {
    return supabaseTable(table.tableName).insert(value).select<T>(table.selectStatement).single();
  }

  PostgrestTransformBuilder<T> supabaseUpdateSelect<T>(
    TableBuilder table, {
    required Map<String, dynamic> value,
    required PostgrestFilterBuilder Function(PostgrestFilterBuilder filter) filter,
  }) {
    final query = supabaseTable(table.tableName).update(value);
    return filter(query).select<T>(table.selectStatement).single();
  }
}
