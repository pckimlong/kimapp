import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kimapp/extensions.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth.dart';

part "auth_state_provider.freezed.dart";
part "auth_state_provider.g.dart";

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.authenticated(UserId userId) = _Authenticated;

  const factory AuthenticationState.unauthenticated() = _Unauthenticated;

  bool get isAuthenticated => whenOrNull(authenticated: (id) => id) != null;

  bool get isUnauthenticated => whenOrNull(unauthenticated: () => true) == true;
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  Future<void> initialize() async {
    final authUserIdOption = (await ref.watch(authRepoProvider).currentId()).getOrThrow();
    final newState = authUserIdOption.match(
      () => const AuthenticationState.unauthenticated(),
      (userId) => AuthenticationState.authenticated(userId),
    );

    // Only update state if it's different to avoid unnecessary rebuilds
    if (newState != state) {
      state = newState;
    }
  }

  @override
  AuthenticationState build() {
    // Set up auth state change listener
    final supabaseAuth = ref.watch(supabaseProvider).client.auth;

    final subscription = supabaseAuth.onAuthStateChange.distinct().listen((_) {
      // Add slight delay to allow Supabase to stabilize
      Future.delayed(const Duration(milliseconds: 100), initialize);
    });

    ref.onDispose(subscription.cancel);

    // Still return unauthenticated by default
    return const AuthenticationState.unauthenticated();
  }
}
