import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{project_name.snakeCase()}}/src/core/core.dart';
import 'package:{{project_name.snakeCase()}}/src/features/auth/auth.dart';

part "auth_state_provider.g.dart";
part "auth_state_provider.freezed.dart";

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.authenticated(AuthUserId authUserId) = _Authenticated;
  const factory AuthenticationState.unauthenticated() = _Unauthenticated;
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  FutureOr<AuthenticationState> build() async {
    final authUserId = (await ref.watch(authRepoProvider).currentId()).getOrThrow();

    // Listen auth state change event
    ref.watch(supabaseProvider).client.auth.onAuthStateChange.listen((_) {
      // Refresh current provider when any state changed occur
      ref.invalidateSelf();
    });

    return authUserId.match(
      () => const AuthenticationState.unauthenticated(),
      (authUserId) => AuthenticationState.authenticated(authUserId),
    );
  }

  /// Manually update auth state. This useful in testing, since this provider is listening to
  /// real auth event, There won't be any update in testing, since it not getting real signed in
  void updateAuthState(AuthenticationState state) => update((preState) => state);
}
