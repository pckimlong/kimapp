import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';
import '../auth.dart';

part "auth_state_provider.freezed.dart";
part "auth_state_provider.g.dart";

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.authenticated(AuthUserId authUserId) = _Authenticated;
  const factory AuthenticationState.unauthenticated() = _Unauthenticated;

  bool get isAuthenticated => whenOrNull(authenticated: id) != null;
  bool get isUnauthenticated => whenOrNull(unauthenticated: () => true) == true;
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Future<AuthenticationState> build() async {
    final authUserIdOption = (await ref.watch(authRepoProvider).currentId()).getOrThrow();

    return authUserIdOption.match(
      () => const AuthenticationState.unauthenticated(),
      (userId) => AuthenticationState.authenticated(userId),
    );
  }

  /// Manually update auth state›
  /// real auth event, There won't be any update in testing, since it not getting real signed in
  void updateAuthState(AuthenticationState newState) {
    state = state.whenData((_) => newState);
  }
}
