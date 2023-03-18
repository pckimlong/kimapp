// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_db.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseHash() => r'ba36e004d5e508f6a7de04eed2bb4d9838561969';

/// See also [supabase].
@ProviderFor(supabase)
final supabaseProvider = Provider<Supabase>.internal(
  supabase,
  name: r'supabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$supabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseRef = ProviderRef<Supabase>;
String _$supabaseAdminHash() => r'85a19d63f2c30a3fcd572534be06c095c4739497';

/// See also [supabaseAdmin].
@ProviderFor(supabaseAdmin)
final supabaseAdminProvider = AutoDisposeProvider<SupabaseClient>.internal(
  supabaseAdmin,
  name: r'supabaseAdminProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SupabaseAdminRef = AutoDisposeProviderRef<SupabaseClient>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
