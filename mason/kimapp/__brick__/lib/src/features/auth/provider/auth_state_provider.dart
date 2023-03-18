// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';
import '../auth.dart';

part "auth_state_provider.freezed.dart";
part "auth_state_provider.g.dart";

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.authenticated(AuthUserId userId) = _Authenticated;

  const factory AuthenticationState.unauthenticated() = _Unauthenticated;

  bool get isAuthenticated => whenOrNull(authenticated: (id) => id) != null;

  bool get isUnauthenticated => whenOrNull(unauthenticated: () => true) == true;
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  void updateAuthState(AuthenticationState newState) => state = newState;

  Future<void> initialize() async {
    final authAuthUserIdOption = (await ref.watch(authRepoProvider).currentId()).getOrThrow();
    state = authAuthUserIdOption.match(
      () => const AuthenticationState.unauthenticated(),
      (userId) => AuthenticationState.authenticated(userId),
    );
  }

  @override
  AuthenticationState build() {
    // TODO - Listen to auth state change and navigate to appropriate route?

    /// Return unauthenticated by default and let splash page initial actual state
    return const AuthenticationState.unauthenticated();
  }
}
