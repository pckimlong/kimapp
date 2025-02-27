// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$animalHash() => r'e4c601a5b3d5a66fc3454d2c6f78e874bdb5e307';

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

abstract class _$Animal extends BuildlessAutoDisposeAsyncNotifier<AnimalModel> {
  late final String animalName;
  late final int age;

  FutureOr<AnimalModel> build({
    required String animalName,
    int age = 1,
  });
}

/// See also [Animal].
@ProviderFor(Animal)
const animalProvider = AnimalFamily();

/// See also [Animal].
class AnimalFamily extends Family<AsyncValue<AnimalModel>> {
  /// See also [Animal].
  const AnimalFamily();

  /// See also [Animal].
  AnimalProvider call({
    required String animalName,
    int age = 1,
  }) {
    return AnimalProvider(
      animalName: animalName,
      age: age,
    );
  }

  @override
  AnimalProvider getProviderOverride(
    covariant AnimalProvider provider,
  ) {
    return call(
      animalName: provider.animalName,
      age: provider.age,
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
  String? get name => r'animalProvider';
}

/// See also [Animal].
class AnimalProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Animal, AnimalModel> {
  /// See also [Animal].
  AnimalProvider({
    required String animalName,
    int age = 1,
  }) : this._internal(
          () => Animal()
            ..animalName = animalName
            ..age = age,
          from: animalProvider,
          name: r'animalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$animalHash,
          dependencies: AnimalFamily._dependencies,
          allTransitiveDependencies: AnimalFamily._allTransitiveDependencies,
          animalName: animalName,
          age: age,
        );

  AnimalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.animalName,
    required this.age,
  }) : super.internal();

  final String animalName;
  final int age;

  @override
  FutureOr<AnimalModel> runNotifierBuild(
    covariant Animal notifier,
  ) {
    return notifier.build(
      animalName: animalName,
      age: age,
    );
  }

  @override
  Override overrideWith(Animal Function() create) {
    return ProviderOverride(
      origin: this,
      override: AnimalProvider._internal(
        () => create()
          ..animalName = animalName
          ..age = age,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        animalName: animalName,
        age: age,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Animal, AnimalModel> createElement() {
    return _AnimalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalProvider &&
        other.animalName == animalName &&
        other.age == age;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, animalName.hashCode);
    hash = _SystemHash.combine(hash, age.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AnimalRef on AutoDisposeAsyncNotifierProviderRef<AnimalModel> {
  /// The parameter `animalName` of this provider.
  String get animalName;

  /// The parameter `age` of this provider.
  int get age;
}

class _AnimalProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Animal, AnimalModel>
    with AnimalRef {
  _AnimalProviderElement(super.provider);

  @override
  String get animalName => (origin as AnimalProvider).animalName;
  @override
  int get age => (origin as AnimalProvider).age;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
