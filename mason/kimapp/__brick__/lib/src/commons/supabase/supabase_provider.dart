import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

part 'supabase_key.dart';
part 'supabase_key.dart';
part 'supabase_provider.g.dart';
part 'supabase_provider.g.dart';

Future<void> initializeSupabase({
  required String url,
  required String anonKey,
  String? schema,
  LocalStorage? localStorage,
  bool? debug,
}) async {
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
    localStorage: localStorage,
    debug: debug,
    schema: schema,
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
