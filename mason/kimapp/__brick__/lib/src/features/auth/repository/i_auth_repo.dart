import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sok_chea_sihanouk_clinic/src/features/auth/auth.dart';

import '../../../../exports.dart';
import '../param/sign_up_param.dart';

part 'i_auth_repo.g.dart';

@Riverpod(keepAlive: true)
IAuthRepo authRepo(AuthRepoRef ref) => _Impl(ref);

abstract class IAuthRepo {
  Future<Either<Failure, Option<AuthUserId>>> currentId();
  Future<Either<Failure, AuthUserId>> signIn(SignInParam param);
  Future<Either<Failure, AuthUserId>> signUp(SignUpParam param);
  Future<Either<Failure, Unit>> signOut();
}

class _Impl implements IAuthRepo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure, Option<AuthUserId>>> currentId() async {
    return await errorHandler(() async {
      final user = _ref.read(supabaseProvider).client.auth.currentSession?.user;

      if (user == null) return right(none());

      final userId = AuthUserId.fromValue(user.id);
      return right(Option.of(userId));
    });
  }

  @override
  Future<Either<Failure, AuthUserId>> signIn(SignInParam param) async {
    return await errorHandler(() async {
      // TODO: implement signIn
      return right(AuthUserId.fromValue(''));
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return await errorHandler(() async {
      await _ref.read(supabaseProvider).client.auth.signOut();
      return right(unit);
    });
  }

  @override
  Future<Either<Failure, AuthUserId>> signUp(SignUpParam param) async {
    return await errorHandler(() async {
      // TODO: implement signUp
      return right(AuthUserId.fromValue(''));
    });
  }
}
