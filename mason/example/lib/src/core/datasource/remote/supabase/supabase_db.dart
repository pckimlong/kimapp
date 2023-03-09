import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supabase_db.g.dart';
part 'supabase_key.dart';

/// Must call in main() function
Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: _url,
    anonKey: _anonKey,
    debug: kDebugMode,
  );
}

@Riverpod(keepAlive: true)
Supabase supabase(SupabaseRef ref) {
  return Supabase.instance;
}

@riverpod
SupabaseClient supabaseAdmin(SupabaseAdminRef ref) {
  return SupabaseClient(_url, _adminKey);
}
