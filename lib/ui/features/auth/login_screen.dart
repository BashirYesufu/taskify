import 'package:flutter/material.dart';
import 'package:taskify/ui/features/dashboard/dashboard.dart';
import 'package:taskify/ui/widgets/app_button.dart';
import 'package:taskify/ui/widgets/app_input_field.dart';
import 'package:taskify/ui/widgets/app_pass_word_field.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../../util/ui_util/ui_actions.dart';
import '../../widgets/app_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login";

  static void launch(BuildContext context){
    AppRouter.clearAndNavigateTo(context, routeName);
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final _emailTC = TextEditingController();
  final _passwordTC = TextEditingController();

  @override
  void initState() {
    bindBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasBackButton: false,
      loadingStream: _authBloc.progressStatusObservable,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login', style: AppTextStyles.superBold(context, size: 24),),
            Text('Welcome back', style: AppTextStyles.regular(context, secondary: true),),
            AppInputField(
              title: 'Email address',
              hintText: 'Enter email address',
              controller: _emailTC,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AppPasswordField(
                title: 'Password',
                hintText: 'Enter password',
                controller: _passwordTC,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AppButton(
          title: 'Register',
          onTap: ()=> _authBloc.login(email: _emailTC.text, password: _passwordTC.text),
        ),
      ),
      ),
    );
  }

  void bindBloc(){
    _authBloc.loginResponse.listen((_){
      Dashboard.launch(context);
    }, onError: (error){
      UIActions.showError(context, message: error);
    });
  }

}