// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_widget_example.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$asyncGenerateHash() => r'd7b347983924cbfce0f44d98a9e0bbdacef35cd9';

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

/// See also [asyncGenerate].
@ProviderFor(asyncGenerate)
const asyncGenerateProvider = AsyncGenerateFamily();

/// See also [asyncGenerate].
class AsyncGenerateFamily extends Family<AsyncValue<DemoModel>> {
  /// See also [asyncGenerate].
  const AsyncGenerateFamily();

  /// See also [asyncGenerate].
  AsyncGenerateProvider call(
    int hello,
  ) {
    return AsyncGenerateProvider(
      hello,
    );
  }

  @override
  AsyncGenerateProvider getProviderOverride(
    covariant AsyncGenerateProvider provider,
  ) {
    return call(
      provider.hello,
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
  String? get name => r'asyncGenerateProvider';
}

/// See also [asyncGenerate].
class AsyncGenerateProvider extends AutoDisposeFutureProvider<DemoModel> {
  /// See also [asyncGenerate].
  AsyncGenerateProvider(
    int hello,
  ) : this._internal(
          (ref) => asyncGenerate(
            ref as AsyncGenerateRef,
            hello,
          ),
          from: asyncGenerateProvider,
          name: r'asyncGenerateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$asyncGenerateHash,
          dependencies: AsyncGenerateFamily._dependencies,
          allTransitiveDependencies:
              AsyncGenerateFamily._allTransitiveDependencies,
          hello: hello,
        );

  AsyncGenerateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hello,
  }) : super.internal();

  final int hello;

  @override
  Override overrideWith(
    FutureOr<DemoModel> Function(AsyncGenerateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AsyncGenerateProvider._internal(
        (ref) => create(ref as AsyncGenerateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hello: hello,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DemoModel> createElement() {
    return _AsyncGenerateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncGenerateProvider && other.hello == hello;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hello.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AsyncGenerateRef on AutoDisposeFutureProviderRef<DemoModel> {
  /// The parameter `hello` of this provider.
  int get hello;
}

class _AsyncGenerateProviderElement
    extends AutoDisposeFutureProviderElement<DemoModel> with AsyncGenerateRef {
  _AsyncGenerateProviderElement(super.provider);

  @override
  int get hello => (origin as AsyncGenerateProvider).hello;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
