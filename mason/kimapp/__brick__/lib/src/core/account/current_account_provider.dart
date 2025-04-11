import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/auth.dart';

part 'current_account_provider.freezed.dart';
part 'current_account_provider.g.dart';

@freezed
class CurrentAccountState with _$CurrentAccountState {
  const CurrentAccountState._();

  const factory CurrentAccountState.none() = _None;

  const factory CurrentAccountState() = CurrentAccountStateData;

  CurrentAccountStateData? get account {
    return switch (this) {
      final CurrentAccountStateData data => data,
      _ => null,
    };
  }
}

extension CurrentAccountStateDataX on CurrentAccountStateData {}

@Riverpod(keepAlive: true)
class CurrentAccount extends _$CurrentAccount {
  @override
  FutureOr<CurrentAccountState> build() async {
    final uid = ref.watch(currentUserIdProvider);
    if (uid == null) return const CurrentAccountState.none();

    return const CurrentAccountState();
  }
}
