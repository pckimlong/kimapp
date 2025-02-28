// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_widget_example.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

abstract class _$UpdateUserWidget extends _$UpdateUser {
  static final callStateProvider = StateProvider.autoDispose
      .family<AsyncValue<bool>?, ({int id})>((ref, _) => null);

  /// Callback for when the form is successfully submitted.
  /// Override this method to handle the result or perform side effects.
  @protected
  void onSuccess(bool result) {}
  @protected
  @nonVirtual
  Future<AsyncValue<bool>> call(
    UpdateUserModel state, {
    required Uint8List? photoBytes,
  }) async {
    // Ignore if form is not loaded yet
    if (this.state.isLoading) return const AsyncValue.loading();
    // Cannot submit when form is not loaded yet
    if (this.state.hasValue == false) return const AsyncValue.loading();

    final callState = ref.read(callStateProvider((id: id)));
    final updateCallState = ref.read(callStateProvider((id: id)).notifier);

    // If it's already loading, return loading
    if (callState?.isLoading == true) return const AsyncValue.loading();

    if (callState?.hasValue == true) {
      return callState!;
    }

    updateCallState.state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async =>
        await submit(this.state.requireValue, photoBytes: photoBytes));

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

  /// Internal submit implementation for form submission.
  ///
  /// ⚠️ WARNING: Do not call this method directly - use [call] instead.
  /// Direct usage bypasses:
  /// - Error handling
  /// - Loading state management
  /// - Success callback handling
  /// - Form validation
  ///
  /// This method should be overridden to implement the actual form submission logic:
  /// 1. Validate form data
  /// 2. Transform data if needed
  /// 3. Call API/repository methods
  /// 4. Return success/failure result
  @visibleForOverriding
  Future<bool> submit(
    UpdateUserModel state, {
    required Uint8List? photoBytes,
  });

  /// Update the name field of UpdateUserModel class.
  void updateName(String newValue) =>
      state = state.whenData((state) => state.copyWith(name: newValue));

  /// Update the age field of UpdateUserModel class.
  void updateAge(int? newValue) =>
      state = state.whenData((state) => state.copyWith(age: newValue));

  /// Update the email field of UpdateUserModel class.
  void updateEmail(String? newValue) =>
      state = state.whenData((state) => state.copyWith(email: newValue));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateUserModelImpl _$$UpdateUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateUserModelImpl(
      name: json['name'] as String? ?? '',
      age: (json['age'] as num?)?.toInt(),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$UpdateUserModelImplToJson(
        _$UpdateUserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'email': instance.email,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'e75530ca34ed2fc7744e8fd5e2a8e5d7f738dc62';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$updateUserHash() => r'9d6c1001ed4d54fb9f0fecfe604f0ae70b2ed26b';

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

abstract class _$UpdateUser
    extends BuildlessAutoDisposeAsyncNotifier<UpdateUserModel> {
  late final int id;

  FutureOr<UpdateUserModel> build(
    int id,
  );
}

/// Annotated with @formWidget and @riverpod
///
/// Copied from [UpdateUser].
@ProviderFor(UpdateUser)
const updateUserProvider = UpdateUserFamily();

/// Annotated with @formWidget and @riverpod
///
/// Copied from [UpdateUser].
class UpdateUserFamily extends Family<AsyncValue<UpdateUserModel>> {
  /// Annotated with @formWidget and @riverpod
  ///
  /// Copied from [UpdateUser].
  const UpdateUserFamily();

  /// Annotated with @formWidget and @riverpod
  ///
  /// Copied from [UpdateUser].
  UpdateUserProvider call(
    int id,
  ) {
    return UpdateUserProvider(
      id,
    );
  }

  @override
  UpdateUserProvider getProviderOverride(
    covariant UpdateUserProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'updateUserProvider';
}

/// Annotated with @formWidget and @riverpod
///
/// Copied from [UpdateUser].
class UpdateUserProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UpdateUser, UpdateUserModel> {
  /// Annotated with @formWidget and @riverpod
  ///
  /// Copied from [UpdateUser].
  UpdateUserProvider(
    int id,
  ) : this._internal(
          () => UpdateUser()..id = id,
          from: updateUserProvider,
          name: r'updateUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateUserHash,
          dependencies: UpdateUserFamily._dependencies,
          allTransitiveDependencies:
              UpdateUserFamily._allTransitiveDependencies,
          id: id,
        );

  UpdateUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<UpdateUserModel> runNotifierBuild(
    covariant UpdateUser notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(UpdateUser Function() create) {
    return ProviderOverride(
      origin: this,
      override: UpdateUserProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UpdateUser, UpdateUserModel>
      createElement() {
    return _UpdateUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateUserProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateUserRef on AutoDisposeAsyncNotifierProviderRef<UpdateUserModel> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UpdateUserProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UpdateUser, UpdateUserModel>
    with UpdateUserRef {
  _UpdateUserProviderElement(super.provider);

  @override
  int get id => (origin as UpdateUserProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
