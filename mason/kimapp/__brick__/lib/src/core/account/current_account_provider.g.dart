// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserIdHash() => r'b3c507f20b59872bc9b673ee25eb135f15360d4c';

/// See also [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = Provider<UserId?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserIdRef = ProviderRef<UserId?>;
String _$currentAccountHash() => r'ca6246de589b4a44c51ebae6867f8b39b55b1900';

/// See also [CurrentAccount].
@ProviderFor(CurrentAccount)
final currentAccountProvider =
    AsyncNotifierProvider<CurrentAccount, CurrentAccountState>.internal(
  CurrentAccount.new,
  name: r'currentAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentAccount = AsyncNotifier<CurrentAccountState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
