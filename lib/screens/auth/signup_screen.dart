import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../helpers/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('SIGNUP_SCREEN');
    final lang = Provider.of<AppProvider>(context).language;

    void handleRegister() async {
      final email = _emailCtrl.value.text;
      final password = _passwordCtrl.value.text;
      final confirmPassword = _confirmPasswordCtrl.value.text;

      // empty validation
      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        TopSnackBar.showError(context, 'Please fill in all fields');
        return;
      }

      // email validation
      if (!RegEx.isValidEmail(email)) {
        TopSnackBar.showError(context, 'Please enter a valid email');
        return;
      }

      // password validation
      if (password.length < 6) {
        TopSnackBar.showError(context, 'Password must be at least 6 characters');
        return;
      }

      // confirm password validation
      if (confirmPassword != password) {
        TopSnackBar.showError(context, 'Passwords do not match');
        return;
      }

      try {
        await Provider.of<AuthProvider>(context, listen: false).register(
          email,
          password,
          () {
            TopSnackBar.showSuccess(context, 'Successfully registered an account');
            Navigator.of(context).pop();
          },
        );
      } on HttpException catch (error) {
        TopSnackBar.showError(context, error.toString());
        await Analytics.crashEvent(
          'handleRegister',
          exception: error.toString(),
        );
      } catch (error) {
        debugPrint(error.toString());
        TopSnackBar.showError(context, 'Failed to sign you up! Please try again later');
        await Analytics.crashEvent(
          'handleRegister',
          exception: error.toString(),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(lang.signUp),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(lang.email),
                RoundedTextFieldWidget(
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailCtrl,
                ),
                Text(lang.password),
                RoundedTextFieldWidget(
                  obscureText: true,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                  controller: _passwordCtrl,
                ),
                Text(lang.confirmPassword),
                RoundedTextFieldWidget(
                  obscureText: true,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                  controller: _confirmPasswordCtrl,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: handleRegister,
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(10),
                    backgroundColor: LetTutorColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    lang.signUp,
                    style: const TextStyle(
                      fontWeight: LetTutorFontWeights.medium,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    lang.registerWith,
                    style: const TextStyle(
                      fontSize: LetTutorFontSizes.px12,
                      color: LetTutorColors.greyScaleDarkGrey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginWidget(
                      svgSource: LetTutorSvg.facebookAuth,
                      onPressed: () => OAuth.facebookLogin(context),
                    ),
                    SocialLoginWidget(
                      svgSource: LetTutorSvg.google,
                      onPressed: () => OAuth.googleLogin(context),
                    ),
                    const SocialLoginWidget(svgSource: LetTutorSvg.smartPhone),
                    const SocialLoginWidget(svgSource: LetTutorSvg.apple),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 25),
                  child: Text.rich(
                    TextSpan(
                      text: lang.alreadyHaveAccount,
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px12,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: lang.login,
                          style: const TextStyle(
                            fontSize: LetTutorFontSizes.px14,
                            color: LetTutorColors.primaryBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
                            },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
