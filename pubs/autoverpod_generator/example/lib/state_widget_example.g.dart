// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_widget_example.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myName)
@stateWidget
const myNameProvider = MyNameProvider._();

@stateWidget
final class MyNameProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const MyNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return myName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$myNameHash() => r'174c92ed23138b8882929a2a813fe81c66d5c309';

@ProviderFor(MyNameAsync)
@stateWidget
const myNameAsyncProvider = MyNameAsyncProvider._();

@stateWidget
final class MyNameAsyncProvider
    extends $AsyncNotifierProvider<MyNameAsync, String> {
  const MyNameAsyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myNameAsyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myNameAsyncHash();

  @$internal
  @override
  MyNameAsync create() => MyNameAsync();
}

String _$myNameAsyncHash() => r'bab30a25f88879e8b80825c6868b0b3cd53ca024';

@stateWidget
abstract class _$MyNameAsync extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
