import '../../../../exports.dart';
import '../startup.dart';

const _devUrl = "http://192.168.0.199:54321";
const _devAnonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0";

class InitSupabaseTask extends StartUpTask {
  const InitSupabaseTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    final url = context.env.isDevelop ? _devUrl : const String.fromEnvironment('API_URL');
    final key = context.env.isDevelop ? _devAnonKey : const String.fromEnvironment('API_ANON_KEY');

    await initializeSupabase(
      url: url,
      anonKey: key,
      debug: context.env.isDevelop,
    );
  }
}
