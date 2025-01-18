import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth.dart';

part 'i_auth_repo.g.dart';

@Riverpod(keepAlive: true)
IAuthRepo authRepo(Ref ref) => _Impl(ref);

abstract class IAuthRepo {
  Future<Either<Failure, Option<UserId>>> currentId();
  Future<Either<Failure, UserId>> signIn(SignInParam param);
  Future<Either<Failure, Unit>> signOut();
}

class _Impl implements IAuthRepo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure, Option<UserId>>> currentId() async {
    return await errorHandler(() async {
      final user = _ref.supabaseClient.auth.currentSession?.user;
      if (user == null) return right(Option.none());
      return right(Option.fromNullable(UserId.fromValue(user.id)));
    });
  }

  @override
  Future<Either<Failure, UserId>> signIn(SignInParam param) async {
    return await errorHandler(() async {
      final result = await _ref.supabaseClient.auth.signInWithPassword(
        email: param.email,
        password: param.password.trim(),
      );

      return right(UserId.fromValue(result.user!.id));
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return await errorHandler(() async {
      await _ref.supabaseClient.auth.signOut();
      return right(unit);
    });
  }
}
