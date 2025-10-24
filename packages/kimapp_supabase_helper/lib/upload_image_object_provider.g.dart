// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_object_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UploadImageObject)
const uploadImageObjectProvider = UploadImageObjectProvider._();

final class UploadImageObjectProvider extends $NotifierProvider<
    UploadImageObject, ProviderStatus<BaseStorageObject>> {
  const UploadImageObjectProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'uploadImageObjectProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$uploadImageObjectHash();

  @$internal
  @override
  UploadImageObject create() => UploadImageObject();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProviderStatus<BaseStorageObject> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<ProviderStatus<BaseStorageObject>>(value),
    );
  }
}

String _$uploadImageObjectHash() => r'c38086b029ce40f1d21e8907c2ffa7ac765f97b4';

abstract class _$UploadImageObject
    extends $Notifier<ProviderStatus<BaseStorageObject>> {
  ProviderStatus<BaseStorageObject> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProviderStatus<BaseStorageObject>,
        ProviderStatus<BaseStorageObject>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ProviderStatus<BaseStorageObject>,
            ProviderStatus<BaseStorageObject>>,
        ProviderStatus<BaseStorageObject>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
