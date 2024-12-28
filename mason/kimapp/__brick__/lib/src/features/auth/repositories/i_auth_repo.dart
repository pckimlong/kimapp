import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';
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
      final user = _ref.read(supabaseProvider).client.auth.currentSession?.user;
      return right(Option.fromNullable(user?.userId));
    });
  }

  @override
  Future<Either<Failure, UserId>> signIn(SignInParam param) async {
    return await errorHandler(() async {
      final result = await _ref
          .read(supabaseProvider)
          .client
          .auth
          .signInWithPassword(email: param.email, password: param.password.trim());

      return right(result.user!.userId);
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return await errorHandler(() async {
      await _ref.read(supabaseProvider).client.auth.signOut();
      return right(unit);
    });
  }
}
