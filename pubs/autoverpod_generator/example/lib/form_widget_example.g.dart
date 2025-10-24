// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_widget_example.dart';

// **************************************************************************
// FormProviderGenerator
// **************************************************************************

// ============================================================================
// AUTOVERPOD GENERATED FORM PROVIDER - DO NOT MODIFY BY HAND
// ============================================================================
//
// Generated from: updateUserProvider
//
// GENERATED PROVIDER:
// - updateUserCallStatusProvider: Form submission status provider
//
// ABSTRACT CLASS: _$UpdateUserWidget
// - call(): Submit form with validation and status handling
// - submit(): Override to implement form submission logic
// - onSuccess(): Override to handle successful submissions
//

final updateUserCallStatusProvider = NotifierProvider.autoDispose
    .family<_UpdateUserCallStatusNotifier, AsyncValue<bool>?, ({int id})>(
      (({int id}) _) => _UpdateUserCallStatusNotifier(),
    );

class _UpdateUserCallStatusNotifier extends Notifier<AsyncValue<bool>?> {
  @override
  AsyncValue<bool>? build() => null;
}

abstract class _$UpdateUserWidget extends _$UpdateUser {
  /// Callback for when the form is successfully submitted.
  /// Override this method and run "dart pub run build_runner build" to make it work. otherwise error will be thrown.
  @protected
  void onSuccess(bool result);
  @nonVirtual
  Future<AsyncValue<bool>> call({required Uint8List? photoBytes}) async {
    // Ignore if form is not loaded yet
    if (this.state.isLoading) return const AsyncValue.loading();
    // Cannot submit when form is not loaded yet
    if (this.state.hasValue == false) return const AsyncValue.loading();

    final _callStatus = ref.read(updateUserCallStatusProvider((id: id)));
    final _updateCallStatus = ref.read(
      updateUserCallStatusProvider((id: id)).notifier,
    );

    if (_callStatus?.isLoading == true) return const AsyncValue.loading();

    if (_callStatus?.hasValue == true) {
      return _callStatus!;
    }

    _updateCallStatus.state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () async => await submit(this.state.requireValue, photoBytes: photoBytes),
    );

    _updateCallStatus.state = result;

    if (result.hasValue) {
      onSuccess(result.requireValue);
    }

    return result;
  }

  void invalidateSelf() {
    ref.invalidate(updateUserCallStatusProvider((id: id)));
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
  @protected
  Future<bool> submit(UpdateUserModel state, {required Uint8List? photoBytes});

  /// Update the state of the form.
  /// This allows for more flexible updates to specific fields.
  void updateState(UpdateUserModel Function(UpdateUserModel state) update) =>
      state = state.whenData(update);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateUserModel _$UpdateUserModelFromJson(Map<String, dynamic> json) =>
    _UpdateUserModel(
      name: json['name'] as String? ?? '',
      age: (json['age'] as num?)?.toInt(),
      email: json['email'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UpdateUserModelToJson(_UpdateUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'e75530ca34ed2fc7744e8fd5e2a8e5d7f738dc62';

/// Annotated with @formWidget and @riverpod
// @stateWidget

@ProviderFor(UpdateUser)
@formWidget
const updateUserProvider = UpdateUserFamily._();

/// Annotated with @formWidget and @riverpod
// @stateWidget
@formWidget
final class UpdateUserProvider
    extends $AsyncNotifierProvider<UpdateUser, UpdateUserModel> {
  /// Annotated with @formWidget and @riverpod
  // @stateWidget
  const UpdateUserProvider._({
    required UpdateUserFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'updateUserProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$updateUserHash();

  @override
  String toString() {
    return r'updateUserProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UpdateUser create() => UpdateUser();

  @override
  bool operator ==(Object other) {
    return other is UpdateUserProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$updateUserHash() => r'9d6c1001ed4d54fb9f0fecfe604f0ae70b2ed26b';

/// Annotated with @formWidget and @riverpod
// @stateWidget

@formWidget
final class UpdateUserFamily extends $Family
    with
        $ClassFamilyOverride<
          UpdateUser,
          AsyncValue<UpdateUserModel>,
          UpdateUserModel,
          FutureOr<UpdateUserModel>,
          int
        > {
  const UpdateUserFamily._()
    : super(
        retry: null,
        name: r'updateUserProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Annotated with @formWidget and @riverpod
  // @stateWidget

  @formWidget
  UpdateUserProvider call(int id) =>
      UpdateUserProvider._(argument: id, from: this);

  @override
  String toString() => r'updateUserProvider';
}

/// Annotated with @formWidget and @riverpod
// @stateWidget

@formWidget
abstract class _$UpdateUser extends $AsyncNotifier<UpdateUserModel> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<UpdateUserModel> build(int id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<UpdateUserModel>, UpdateUserModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UpdateUserModel>, UpdateUserModel>,
              AsyncValue<UpdateUserModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
