import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../exports.dart';
import '../../features/auth/auth.dart';
import 'supabase_provider.dart';

extension SupabaseUserX on User {
  UserId get userId => UserId.fromValue(id);
}

extension SupabaseRefExtension on Ref {
  Supabase get supabase => read(supabaseProvider);
  SupabaseClient get supabaseClient => supabase.client;
  SupabaseQueryBuilder table(String tableName) => supabaseClient.from(tableName);
}
