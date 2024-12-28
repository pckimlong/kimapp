// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, require_trailing_commas, type=lint

part of 'file_from_url_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fileFromUrlHash() => r'05e10651895829a07d565149b5ebee84bea59d4a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef FileFromUrlRef = AutoDisposeFutureProviderRef<File?>;

/// Provide use to get uint8list from url and also cache it
///
/// Copied from [fileFromUrl].
@ProviderFor(fileFromUrl)
const fileFromUrlProvider = FileFromUrlFamily();

/// Provide use to get uint8list from url and also cache it
///
/// Copied from [fileFromUrl].
class FileFromUrlFamily extends Family<AsyncValue<File?>> {
  /// Provide use to get uint8list from url and also cache it
  ///
  /// Copied from [fileFromUrl].
  const FileFromUrlFamily();

  /// Provide use to get uint8list from url and also cache it
  ///
  /// Copied from [fileFromUrl].
  FileFromUrlProvider call(
    String? url,
  ) {
    return FileFromUrlProvider(
      url,
    );
  }

  @override
  FileFromUrlProvider getProviderOverride(
    covariant FileFromUrlProvider provider,
  ) {
    return call(
      provider.url,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fileFromUrlProvider';
}

/// Provide use to get uint8list from url and also cache it
///
/// Copied from [fileFromUrl].
class FileFromUrlProvider extends AutoDisposeFutureProvider<File?> {
  /// Provide use to get uint8list from url and also cache it
  ///
  /// Copied from [fileFromUrl].
  FileFromUrlProvider(
    this.url,
  ) : super.internal(
          (ref) => fileFromUrl(
            ref,
            url,
          ),
          from: fileFromUrlProvider,
          name: r'fileFromUrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fileFromUrlHash,
          dependencies: FileFromUrlFamily._dependencies,
          allTransitiveDependencies:
              FileFromUrlFamily._allTransitiveDependencies,
        );

  final String? url;

  @override
  bool operator ==(Object other) {
    return other is FileFromUrlProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$tempDirHash() => r'1b5c46fb53f5f3286fb8d4663cf40c775a202bf7';

/// See also [_tempDir].
@ProviderFor(_tempDir)
final _tempDirProvider = AutoDisposeFutureProvider<String>.internal(
  _tempDir,
  name: r'_tempDirProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tempDirHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _TempDirRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
