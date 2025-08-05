import 'package:flutter/material.dart';
import 'package:taskify/ui/features/dashboard/dashboard.dart';
import 'package:taskify/ui/widgets/app_button.dart';
import 'package:taskify/ui/widgets/app_input_field.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../../util/ui_util/color/color_manager.dart';
import '../../../util/ui_util/ui_actions.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_views.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/register";

  static void launch(BuildContext context){
    AppRouter.clearAndNavigateTo(context, routeName);
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final _emailTC = TextEditingController();
  final _passwordTC = TextEditingController();
  final _confirmPasswordTC = TextEditingController();

  String password = '';
  bool get hasEightCharacters => password.length >= 8;
  bool get hasAlphabet => RegExp(r'[a-zA-Z]').hasMatch(password);
  bool get hasNumber => RegExp(r'\d').hasMatch(password);
  bool get hasSpecialCharacter => RegExp(r'[!@#£%^$&*()_+{}\[\]:;<>,.?~\\-]').hasMatch(password);
  bool get validPassword => hasEightCharacters && hasAlphabet && hasNumber && hasSpecialCharacter;

  @override
  void initState() {
    bindBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      loadingStream: _authBloc.progressStatusObservable,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create an account', style: AppTextStyles.superBold(context, size: 24),),
            Text('Time to get you started', style: AppTextStyles.regular(context, secondary: true),),
            AppInputField(
              title: 'Email address',
              hintText: 'Enter email address',
              controller: _emailTC,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AppInputField(
                title: 'Password',
                hintText: 'Enter password',
                controller: _passwordTC,
                onChanged: (text){
                  setState(() {
                    password = text;
                  });
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Password must:', style: AppTextStyles.regular(context, secondary: true),),
                SizedBox(height: 6),
                buildPasswordItem(context, title: 'Be at least 8 characters long', check: hasEightCharacters),
                buildPasswordItem(context, title: 'Have at least 1 alphabet (abc...)', check: hasAlphabet),
                buildPasswordItem(context, title: 'Have at least one number (123...)', check: hasNumber),
                buildPasswordItem(context, title: 'Have at least one special character (*%\$&\$!,.)', check: hasSpecialCharacter),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AppInputField(
                title: 'Confirm Password',
                hintText: 'Confirm your password',
                controller: _confirmPasswordTC,
                onChanged: (text){
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AppButton(
          title: 'Register',
          onTap: ()=> _authBloc.register(email: _emailTC.text, password: password, passwordConfirmation: _confirmPasswordTC.text, isValidPassword: validPassword,),
        ),
      ),
      ),
    );
  }

  void bindBloc(){
    _authBloc.registerResponse.listen((_){
      Dashboard.launch(context);
    }, onError: (error){
      UIActions.showError(context, message: error);
    });
  }

  Widget buildPasswordItem(BuildContext context, {required String title, required bool check}){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          AppRoundedView(
            size: 14,
            color: check ? ColorManager.green : Colors.red,
            child: Icon(Icons.check, color: Colors.white, size: 12,),
          ),
          SizedBox(width: 6,),
          Text(title, style: AppTextStyles.medium(context, size: 10, secondary: true, color:  check ? ColorManager.green : Colors.red),),
        ],
      ),
    );
  }

}