
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_param.freezed.dart';

@freezed
class SignInParam with _$SignInParam {
  const SignInParam._();

  const factory SignInParam({
    required String email,
    required String password,
  }) = _SignInParam;
}
