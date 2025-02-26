import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_widget_v2.freezed.dart';
part 'form_widget_v2.g.dart';

@freezed
class ProductParam with _$ProductParam {
  const ProductParam._();

  const factory ProductParam() = _ProductParam;
}

@formWidget
@riverpod
class ProductCreate extends _$ProductCreate with _$ProductCreateFormMixin {
  @override
  FutureOr<ProductParam> build() {
    return const ProductParam();
  }
}

mixin _$ProductCreateFormMixin {}

class FormWidget {
  const FormWidget();
}

const formWidget = FormWidget();

class FormUpdateWidget {
  const FormUpdateWidget();
}

const formUpdateWidget = FormUpdateWidget();


/// Check for formWidget or formUpdateWidget annotation
/// Check for return type, if it is freezed class, implement all update field in mixin directly call copyWith method
/// if it it not freezed, generate all field in mixin to ask for override in riverpod class
/// if no call function, generate a placeholder call function implementation, this allow to required override in riverpod class