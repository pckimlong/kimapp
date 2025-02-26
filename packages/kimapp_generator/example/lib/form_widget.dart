import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_widget.freezed.dart';
part 'form_widget.g.dart';

@freezed
class UserState with _$UserState {
  const UserState._();

  const factory UserState({
    @Default('') String name,
    @Default(0) int age,
    @Default(ProviderStatus.initial()) ProviderStatus<String> status,
  }) = _UserState;
}

@kimappForm
@riverpod
class User extends _$User {
  Future<ProviderStatus<String>> call() async {
    return await perform<String>(
      (state) async {
        throw UnimplementedError();
      },
      onSuccess: (success) {},
    );
  }

  void updateState(UserState Function(UserState oldState) newState) {
    state = newState(state).copyWith(status: state.status);
  }

  @override
  UserState build() => const UserState();
}

class UsageExample extends ConsumerWidget {
  const UsageExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserFormBuilderWidget(
      builder: (context, ref, status, notifier, child) {
        return const Column(
          children: [],
        );
      },
    );
  }
}
