import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';
import '../auth.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  ProviderStatus<UserId> build() => const ProviderStatus.initial();

  Future<ProviderStatus<UserId>> call(SignInParam signInParam) async {
    return await perform(
      onSuccess: (authUserId) => ref
          .read(authStateProvider.notifier)
          .updateAuthState(AuthenticationState.authenticated(authUserId)),
      (state) async {
        final result = await ref.read(authRepoProvider).signIn(signInParam);
        return result.getOrThrow();
      },
    );
  }
}
