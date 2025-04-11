import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';

import '../../../core/app/app_info_provider.dart';
import '../../../features/auth/auth.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key, this.onSuccess});

  final void Function()? onSuccess;

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final appInfo = ref.watch(appInfoProvider).valueOrNull;

    return FlutterLogin(
      title: 'សូមស្វាគមន៍',
      savedEmail: "",
      userType: LoginUserType.name,
      footer: appInfo?.version,
      messages: LoginMessages(
        userHint: 'ឈ្មោះគណនី',
        passwordHint: 'ពាក្យសម្ងាត់',
      ),
      userValidator: FormBuilderValidators.required(errorText: 'សូមបញ្ជូល Username'),
      theme: LoginTheme(
          // titleStyle: context.textTheme.titleLarge?.copyWith(color: Colors.white),
          // textFieldStyle: context.textTheme.bodyStrong,
          // bodyStyle: context.textTheme.body,
          // errorColor: Colors.errorPrimaryColor,
          // buttonStyle: context.textTheme.bodyStrong?.copyWith(color: Colors.white.withOpacity(0.8)),
          // footerTextStyle: context.textTheme.body,
          // cardTheme: m.CardTheme(
          //     color: Colors.white,
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          // footerBackgroundColor: AS.primaryColor,
          // primaryColor: AS.primaryColor,
          // accentColor: AS.primaryColor,
          // inputTheme: m.InputDecorationTheme(
          //   iconColor: AS.primaryColor,
          //   suffixIconColor: AS.primaryColor,
          //   prefixIconColor: AS.primaryColor,
          //   border: m.OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(4),
          //     borderSide: BorderSide(width: 0.4, color: context.theme.borderInputColor),
          //   ),
          // ),
          // buttonTheme: LoginButtonTheme(
          //   backgroundColor: AS.primaryColor,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          // ),
          ),
      onLogin: (data) async => await _signInPress(data, ref),
      onRecoverPassword: (data) async {
        return null;
      },
      hideForgotPasswordButton: true,
    );
  }

  Future<String?> _signInPress(LoginData data, WidgetRef ref) async {
    final param = SignInParam(email: data.name, password: data.password);
    final result = await ref.read(signInProvider.notifier).call(param);

    if (result.isSuccess) {
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      } else {
        if (mounted) {
          context.replaceRoute(SplashRoute());
        }
      }

      return null;
    }

    if (result.isFailure) {
      return result.failure!.message();
    }
    return null;
  }
}
