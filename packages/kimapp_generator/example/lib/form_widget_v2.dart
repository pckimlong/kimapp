import 'package:autoverpod/autoverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_widget_v2.freezed.dart';
part 'form_widget_v2.g.dart';

@freezed
abstract class ProductParam
    with _$ProductParam, ProviderStatusClassMixin<ProductParam, void> {
  const ProductParam._();

  const factory ProductParam({
    required String name,
    @Default(ProviderStatus.initial()) ProviderStatus<void> status,
  }) = _ProductParam;

  @override
  ProductParam updateStatus(ProviderStatus<void> newStatus) {
    return copyWith(status: newStatus);
  }
}

typedef ProductCreateState = ProductParam;

@formWidget
@riverpod
class ProductCreate extends _$ProductCreate with _$ProductCreateForm {
  @override
  ProductParam build() => const ProductParam(name: '');

  Future<void> call() async {
    // TODO: Implement product creation logic
    throw UnimplementedError();
  }
}
