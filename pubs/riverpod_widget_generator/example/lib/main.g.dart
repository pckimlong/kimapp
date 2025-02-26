// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$animalHash() => r'edaa0f85e286d686b68e29fd117a9fe03aa019e4';

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
  late final int age;

  FutureOr<AnimalModel> build({
    required int age,
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
    required int age,
  }) {
    return AnimalProvider(
      age: age,
    );
  }

  @override
  AnimalProvider getProviderOverride(
    covariant AnimalProvider provider,
  ) {
    return call(
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
    required int age,
  }) : this._internal(
          () => Animal()..age = age,
          from: animalProvider,
          name: r'animalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$animalHash,
          dependencies: AnimalFamily._dependencies,
          allTransitiveDependencies: AnimalFamily._allTransitiveDependencies,
          age: age,
        );

  AnimalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.age,
  }) : super.internal();

  final int age;

  @override
  FutureOr<AnimalModel> runNotifierBuild(
    covariant Animal notifier,
  ) {
    return notifier.build(
      age: age,
    );
  }

  @override
  Override overrideWith(Animal Function() create) {
    return ProviderOverride(
      origin: this,
      override: AnimalProvider._internal(
        () => create()..age = age,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
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
    return other is AnimalProvider && other.age == age;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, age.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AnimalRef on AutoDisposeAsyncNotifierProviderRef<AnimalModel> {
  /// The parameter `age` of this provider.
  int get age;
}

class _AnimalProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Animal, AnimalModel>
    with AnimalRef {
  _AnimalProviderElement(super.provider);

  @override
  int get age => (origin as AnimalProvider).age;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// **************************************************************************
// RiverpodStateWidgetGenerator
// **************************************************************************

/// {@template baseProxy}
/// Testing
/// {@endtemplate}
class _AnimalProxyWidgetRef extends WidgetRef {
  /// {@macro baseProxy}
  _AnimalProxyWidgetRef(this._ref);

  final WidgetRef _ref;

  @override
  BuildContext get context => _ref.context;

  @override
  bool exists(ProviderBase<Object?> provider) => _ref.exists(provider);

  @override
  void invalidate(ProviderOrFamily provider) => _ref.invalidate(provider);

  @override
  void listen<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
  }) =>
      _ref.listen(provider, listener, onError: onError);

  @override
  ProviderSubscription<T> listenManual<T>(
    ProviderListenable<T> provider,
    void Function(T?, T) listener, {
    void Function(Object, StackTrace)? onError,
    bool fireImmediately = false,
  }) =>
      _ref.listenManual(
        provider,
        listener,
        onError: onError,
        fireImmediately: fireImmediately,
      );

  @override
  T read<T>(ProviderListenable<T> provider) => _ref.read(provider);

  @override
  State refresh<State>(Refreshable<State> provider) => _ref.refresh(provider);

  @override
  T watch<T>(ProviderListenable<T> provider) => _ref.watch(provider);
}

/// {@template subProxy}
/// SubProxy
/// {@endtemplate}
class _AnimalSubProxyWidgetRef extends _AnimalProxyWidgetRef {
  /// {@macro subProxy}
  _AnimalSubProxyWidgetRef(super._ref, {required this.test});

  final String test;
}

final providerDefinition = {
  "baseName": "Animal",
  "returnType": {
    "rawType": "Future<AnimalModel>",
    "baseType": "AnimalModel",
    "wrapperType": "Future",
    "classInfo": null
  },
  "providerName": "AnimalProvider",
  "providerType": "ProviderType.classBased",
  "familyParameters": [
    {
      "name": "age",
      "type": "int",
      "isRequired": true,
      "isNamed": true,
      "defaultValue": null,
      "annotations": [],
      "documentation": null
    }
  ],
  "methods": [
    {
      "name": "build",
      "returnType": "Future<AnimalModel>",
      "parameters": [
        {
          "name": "age",
          "type": "int",
          "isRequired": true,
          "isNamed": true,
          "defaultValue": null,
          "annotations": [],
          "documentation": null
        }
      ],
      "isStatic": false,
      "annotations": ["@override"],
      "documentation": null
    }
  ],
  "modifiers": [],
  "documentation": null,
  "dependencies": [],
  "genericParameters": {}
};
