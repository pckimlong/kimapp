import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../exports.dart';
import '../../features/auth/auth.dart';

part 'current_account_provider.freezed.dart';
part 'current_account_provider.g.dart';

@freezed
class CurrentAccount with _$CurrentAccount {
  const CurrentAccount._();

  /// None mean no data attach to, might be in unauthenticated state
  const factory CurrentAccount.none() = _None;

  const factory CurrentAccount({
    // Implement more information as need.
    //
    // Eg UserInfo, Role, Permission...
    //
    required AuthUserId authUserId,
  }) = CurrentAccountData;

  CurrentAccountData? get account => mapOrNull(id);
}

@Riverpod(keepAlive: true)
FutureOr<CurrentAccount> currentAccount(CurrentAccountRef ref) async {
  final authState = await ref.watch(authStateProvider.future);

  return authState.when(
    authenticated: (uid) {
      // Watch other provider here

      return CurrentAccount(
        authUserId: uid,
      );
    },
    unauthenticated: () => const CurrentAccount.none(),
  );
}
