// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../exports.dart';
import '../../features/auth/auth.dart';

part 'current_account_provider.freezed.dart';
part 'current_account_provider.g.dart';

@freezed
class CurrentAccountState with _$CurrentAccountState {
  const CurrentAccountState._();

  /// None mean no data attach to, might be in unauthenticated state
  const factory CurrentAccountState.none() = _None;

  const factory CurrentAccountState({
    // Implement more information as need.
    //
    // Eg UserInfo, Role, Permission...
    //
    required AuthUserId authUserId,
  }) = CurrentAccountStateData;

  CurrentAccountStateData? get account => mapOrNull(id);
}

@Riverpod(keepAlive: true)
class CurrentAccount extends _$CurrentAccount {
  @override
  FutureOr<CurrentAccountState> build() async {
    _initAutoUpdate(ref);

    final authState = await ref.watch(authStateProvider.future);

    return authState.when(
      authenticated: (uid) {
        // Watch other provider here

        return CurrentAccountState(authUserId: uid);
      },
      unauthenticated: () => const CurrentAccountState.none(),
    );
  }

  /// Auto invalidate current account state, this allow to make sure data consistency
  void _initAutoUpdate(Ref ref) {
    ref.autoInvalidateSelf(const Duration(minutes: 5));

    // Handle realtime if possible
  }
}
