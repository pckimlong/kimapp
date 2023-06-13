
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';
import '../../features/auth/auth.dart';

part 'current_account_provider.freezed.dart';
part 'current_account_provider.g.dart';

@Riverpod(keepAlive: true)
UserId? currentUserId(CurrentUserIdRef ref) =>
    ref.watch(authStateProvider).whenOrNull(authenticated: (id) => id);

@freezed
class CurrentAccountState with _$CurrentAccountState {
  const CurrentAccountState._();

  /// None mean no data attach to, might be in unauthenticated state
  const factory CurrentAccountState.none() = _None;

  const factory CurrentAccountState() = CurrentAccountStateData;

  CurrentAccountStateData? get account => mapOrNull((v) => v);
}

extension CurrentAccountStateDataX on CurrentAccountStateData {}

@Riverpod(keepAlive: true)
class CurrentAccount extends _$CurrentAccount {
  @override
  FutureOr<CurrentAccountState> build() async {
    ref.autoInvalidateSelf(const Duration(minutes: 5));

    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) return const CurrentAccountState.none();

    return const CurrentAccountState();
  }
}
