import 'package:kimapp/kimapp';
import 'package:kimapp_generator/kimapp_generator';
import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseX on Ref {
  SupabaseClient get supabaseClient => read(supabaseProvider).client;

  SupabaseQueryBuilder supabaseTable(String tableName) {
    return supabaseClient.from(tableName);
  }

  PostgrestFilterBuilder<T> supabaseSelect<T>(TableBuilder table) {
    return supabaseTable(table.name).select<T>(table.selectStatement);
  }

  PostgrestTransformBuilder<T> supabaseInsertSelect<T>(
    TableBuilder table, {
    required Map<String, dynamic> value,
  }) {
    return supabaseTable(table.name).insert(value).select<T>(table.selectStatement).single();
  }

  PostgrestTransformBuilder<T> supabaseUpdateSelect<T>(
    TableBuilder table, {
    required Map<String, dynamic> value,
    required PostgrestFilterBuilder Function(PostgrestFilterBuilder filter) filter,
  }) {
    final query = supabaseTable(table.name).update(value);
    return filter(query).select<T>(table.selectStatement).single();
  }
}
