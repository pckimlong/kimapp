// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:{{project_name.snakeCase()}}/exports.dart';
import 'package:{{project_name.snakeCase()}}/src/features/auth/auth.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  ProviderStatus<AuthUserId> build() {
    ref.onSuccessSelf(
      (authUserId) {
        final authenticated = AuthenticationState.authenticated(authUserId);
        ref.read(authStateProvider.notifier).updateAuthState(authenticated);
      },
    );
    return const ProviderStatus.initial();
  }

  Future<ProviderStatus<AuthUserId>> call(SignInParam signInParam) async {
    return perform((state) async {
      final result = await ref.read(authRepoProvider).signIn(signInParam);
      return result.getOrThrow();
    });
  }
}
