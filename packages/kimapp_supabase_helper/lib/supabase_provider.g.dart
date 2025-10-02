// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supabase)
const supabaseProvider = SupabaseProvider._();

final class SupabaseProvider
    extends $FunctionalProvider<Supabase, Supabase, Supabase>
    with $Provider<Supabase> {
  const SupabaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'supabaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$supabaseHash();

  @$internal
  @override
  $ProviderElement<Supabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Supabase create(Ref ref) {
    return supabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Supabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Supabase>(value),
    );
  }
}

String _$supabaseHash() => r'956c2d9c8e1d10a87c877fd72450f6bf3c67ebb2';
