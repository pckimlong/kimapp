import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_widget_v1.freezed.dart';
part 'form_widget_v1.g.dart';

@freezed
sealed class FormWidgetExampleState
    with _$FormWidgetExampleState, ProviderStatusClassMixin<FormWidgetExampleState, bool> {
  const FormWidgetExampleState._();

  const factory FormWidgetExampleState({
    required String name,
    @Default(ProviderStatus.initial()) ProviderStatus<bool> status,
  }) = _FormWidgetExampleState;

  @override
  FormWidgetExampleState updateStatus(ProviderStatus<bool> newStatus) {
    return copyWith(status: newStatus);
  }
}

@kimappForm
@riverpod
class FormWidgetExample extends _$FormWidgetExample with _$FormWidgetExampleForm {
  @override
  FormWidgetExampleState build() => const FormWidgetExampleState(name: '');

  Future<ProviderStatus<bool>> call() async {
    return await perform<bool>(
      (state) async {
        throw UnimplementedError();
      },
    );
  }
}
