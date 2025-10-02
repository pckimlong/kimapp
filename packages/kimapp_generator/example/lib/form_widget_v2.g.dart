// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_widget_v2.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductCreate)
@formWidget
const productCreateProvider = ProductCreateProvider._();

@formWidget
final class ProductCreateProvider
    extends $AsyncNotifierProvider<ProductCreate, ProductParam> {
  const ProductCreateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productCreateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCreateHash();

  @$internal
  @override
  ProductCreate create() => ProductCreate();
}

String _$productCreateHash() => r'861e0742542d475acae0e41d484abc4796633daa';

@formWidget
abstract class _$ProductCreate extends $AsyncNotifier<ProductParam> {
  FutureOr<ProductParam> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ProductParam>, ProductParam>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductParam>, ProductParam>,
        AsyncValue<ProductParam>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
