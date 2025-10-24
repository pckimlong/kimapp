import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_provider.g.dart';

Future<void> initializeSupabase({
  required String url,
  required String anonKey,
  String schema = 'public',
  LocalStorage? localStorage,
  bool? debug,
  AuthFlowType authFlowType = AuthFlowType.pkce,
}) async {
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
    debug: debug,
    postgrestOptions: PostgrestClientOptions(schema: schema),
    authOptions: FlutterAuthClientOptions(
      localStorage: localStorage,
      authFlowType: authFlowType,
    ),
  );
}

@Riverpod(keepAlive: true)
Supabase supabase(Ref ref) => Supabase.instance;
