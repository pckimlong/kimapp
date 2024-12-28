import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'supabase_key.dart';
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
    debug: debug,
    postgrestOptions: PostgrestClientOptions(schema: schema ?? 'public'),
  );
}

@Riverpod(keepAlive: true)
Supabase supabase(Ref ref) {
  return Supabase.instance;
}

@riverpod
SupabaseClient supabaseAdmin(Ref ref) {
  return SupabaseClient(_url, _adminKey);
}
