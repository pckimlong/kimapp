import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  @override
  ProviderStatus<Unit> build() => const ProviderStatus.initial();

  Future<ProviderStatus<Unit>> call() async {
    return await perform(
      (state) async {
        final result = await ref.read(authRepoProvider).signOut();
        return result.getOrThrow();
      },
    );
  }
}
