// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

final type = {
  "baseName": "AnimalModelForm",
  "returnType": {
    "rawType": "Testing",
    "baseType": "Testing",
    "wrapperType": "Testing",
    "classInfo": {
      "name": "Testing",
      "isFreezed": false,
      "parentTypes": [],
      "constructors": [""],
      "fields": [
        {
          "name": "age",
          "type": "int",
          "isNullable": false,
          "isFinal": true,
          "documentation": null,
          "defaultValue": null,
          "annotations": [],
          "isPrivate": false,
          "isStatic": false,
          "isGetter": true,
          "isLate": false
        },
        {
          "name": "name",
          "type": "String",
          "isNullable": false,
          "isFinal": true,
          "documentation": null,
          "defaultValue": null,
          "annotations": [],
          "isPrivate": false,
          "isStatic": false,
          "isGetter": true,
          "isLate": false
        }
      ],
      "copyWithMethod": {
        "name": "copyWith",
        "returnType": "Testing",
        "parameters": [
          {
            "name": "age",
            "type": "int?",
            "isRequired": false,
            "isNamed": true,
            "defaultValue": null,
            "annotations": [],
            "documentation": null
          },
          {
            "name": "name",
            "type": "String?",
            "isRequired": false,
            "isNamed": true,
            "defaultValue": null,
            "annotations": [],
            "documentation": null
          }
        ],
        "isStatic": false,
        "annotations": [],
        "documentation": null
      },
      "methods": {
        "copyWith": {
          "name": "copyWith",
          "returnType": "Testing",
          "parameters": [
            {
              "name": "age",
              "type": "int?",
              "isRequired": false,
              "isNamed": true,
              "defaultValue": null,
              "annotations": [],
              "documentation": null
            },
            {
              "name": "name",
              "type": "String?",
              "isRequired": false,
              "isNamed": true,
              "defaultValue": null,
              "annotations": [],
              "documentation": null
            }
          ],
          "isStatic": false,
          "annotations": [],
          "documentation": null
        }
      }
    }
  },
  "providerName": "animalModelFormProvider",
  "providerType": "ProviderType.classBased",
  "familyParameters": [
    {
      "name": "age",
      "type": "int",
      "isRequired": true,
      "isNamed": false,
      "defaultValue": null,
      "annotations": [],
      "documentation": null
    }
  ],
  "methods": [
    {
      "name": "build",
      "returnType": "Testing",
      "parameters": [
        {
          "name": "age",
          "type": "int",
          "isRequired": true,
          "isNamed": false,
          "defaultValue": null,
          "annotations": [],
          "documentation": null
        }
      ],
      "isStatic": false,
      "annotations": ["@override"],
      "documentation": null
    },
    {
      "name": "submit",
      "returnType": "Future<int>",
      "parameters": [
        {
          "name": "age",
          "type": "int",
          "isRequired": true,
          "isNamed": false,
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

abstract class _$AnimalModelFormWidget extends _$AnimalModelForm {
  static final callStateProvider = StateProvider.autoDispose
      .family<AsyncValue<int>?, ({int age})>((ref, _) => null);

  /// Callback for when the form is successfully submitted. Override this method to handle the result. eg perform side effects in other providers.
  @protected
  void onSuccess(int result) {}
  @protected
  @nonVirtual
  Future<AsyncValue<int>> call(int age) async {
    final callState = ref.read(callStateProvider((age: age)));
    final updateCallState = ref.read(callStateProvider((age: age)).notifier);

    // If it's already loading, return loading
    if (callState?.isLoading == true) return const AsyncValue.loading();

    if (callState?.hasValue == true) {
      return callState!;
    }

    updateCallState.state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async => await submit(age));

    updateCallState.state = result;

    if (result.hasValue) {
      onSuccess(result.requireValue);
    }

    return result;
  }

  void invalidateSelf() {
    ref.invalidate(callStateProvider);
    ref.invalidateSelf();
  }

  /// Internal submit implementation - DO NOT CALL DIRECTLY
  ///
  /// ⚠️ Warning: This method should not be called directly. Use [call] instead.
  /// Direct usage of this method will bypass error handling and status management.
  ///
  /// This method is intended to be overridden by implementing classes to provide
  /// the actual submission logic.
  @visibleForOverriding
  Future<int> submit(int age);

  /// Update the age field of Testing class.
  void updateAge(int newValue) => state = state.copyWith(age: newValue);

  /// Update the name field of Testing class.
  void updateName(String newValue) => state = state.copyWith(name: newValue);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$animalModelFormHash() => r'32aea45badd4c8187cb952e1adeefa6cacb787e9';

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

abstract class _$AnimalModelForm extends BuildlessAutoDisposeNotifier<Testing> {
  late final int age;

  Testing build(
    int age,
  );
}

/// See also [AnimalModelForm].
@ProviderFor(AnimalModelForm)
const animalModelFormProvider = AnimalModelFormFamily();

/// See also [AnimalModelForm].
class AnimalModelFormFamily extends Family<Testing> {
  /// See also [AnimalModelForm].
  const AnimalModelFormFamily();

  /// See also [AnimalModelForm].
  AnimalModelFormProvider call(
    int age,
  ) {
    return AnimalModelFormProvider(
      age,
    );
  }

  @override
  AnimalModelFormProvider getProviderOverride(
    covariant AnimalModelFormProvider provider,
  ) {
    return call(
      provider.age,
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
  String? get name => r'animalModelFormProvider';
}

/// See also [AnimalModelForm].
class AnimalModelFormProvider
    extends AutoDisposeNotifierProviderImpl<AnimalModelForm, Testing> {
  /// See also [AnimalModelForm].
  AnimalModelFormProvider(
    int age,
  ) : this._internal(
          () => AnimalModelForm()..age = age,
          from: animalModelFormProvider,
          name: r'animalModelFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$animalModelFormHash,
          dependencies: AnimalModelFormFamily._dependencies,
          allTransitiveDependencies:
              AnimalModelFormFamily._allTransitiveDependencies,
          age: age,
        );

  AnimalModelFormProvider._internal(
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
  Testing runNotifierBuild(
    covariant AnimalModelForm notifier,
  ) {
    return notifier.build(
      age,
    );
  }

  @override
  Override overrideWith(AnimalModelForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: AnimalModelFormProvider._internal(
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
  AutoDisposeNotifierProviderElement<AnimalModelForm, Testing> createElement() {
    return _AnimalModelFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalModelFormProvider && other.age == age;
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
mixin AnimalModelFormRef on AutoDisposeNotifierProviderRef<Testing> {
  /// The parameter `age` of this provider.
  int get age;
}

class _AnimalModelFormProviderElement
    extends AutoDisposeNotifierProviderElement<AnimalModelForm, Testing>
    with AnimalModelFormRef {
  _AnimalModelFormProviderElement(super.provider);

  @override
  int get age => (origin as AnimalModelFormProvider).age;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
