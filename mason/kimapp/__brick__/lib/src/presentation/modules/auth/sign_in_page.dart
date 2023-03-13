import 'package:flutter_login/flutter_login.dart';

import '../../../../exports.dart';
import '../../../features/auth/auth.dart';
import '../../../providers/app/app_info_provider.dart';

@RoutePage()
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInfo = ref.watch(appInfoProvider).valueOrNull;
    ref.watch(signInProvider);

    return Scaffold(
      key: const Key('sign-in-page'),
      body: FlutterLogin(
        userType: LoginUserType.name,
        footer: appInfo?.version,
        userValidator: FormBuilderValidators.required(errorText: 'សូមបញ្ជូល Username'),
        onLogin: (data) async {
          final param = SignInParam(email: data.name, password: data.password);
          final result = await ref.read(signInProvider.notifier).call(param);

          if (result.isSuccess) return null;

          return result.whenOrNull(failure: (failure) => failure.message());
        },
        onRecoverPassword: (data) async {
          return null;
        },
        hideForgotPasswordButton: true,
      ),
    );
  }
}
