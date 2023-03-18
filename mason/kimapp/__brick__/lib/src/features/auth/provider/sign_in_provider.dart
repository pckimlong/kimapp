// ignore_for_file: public_member_api_docs, sort_constructors_first

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../exports.dart';
import '../auth.dart';


part 'sign_in_provider.g.dart';

@riverpod
class SignIn extends _$SignIn {
  @override
  ProviderStatus<AuthUserId> build() => const ProviderStatus.initial();

  Future<ProviderStatus<AuthUserId>> call(SignInParam signInParam) async {
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
