import 'package:kimapp_supabase_helper/supabase_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseX on Ref {
  SupabaseClient get supabaseClient => read(supabaseProvider).client;
  SupabaseQueryBuilder supabaseTable(String tableName) =>
      supabaseClient.from(tableName);
  SupabaseStorageClient get supabaseStorage => supabaseClient.storage;
  StorageFileApi supabaseStorageBucket(String bucketName) =>
      supabaseStorage.from(bucketName);
}
