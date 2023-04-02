import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/assets/assets.dart';
import '../../core/styles/styles.dart';
import '../../helpers/index.dart';
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
  Widget build(BuildContext context) {
    void handleRegister() {
      final email = _emailCtrl.value.text;
      final password = _passwordCtrl.value.text;
      final confirmPassword = _confirmPasswordCtrl.value.text;

      // empty validation
      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        TopSnackBar.show(
          context: context,
          message: 'Please fill in all fields',
          isSuccess: false,
        );
        return;
      }

      // email validation
      if (!RegEx.isValidEmail(email)) {
        TopSnackBar.show(
          context: context,
          message: 'Please enter a valid email',
          isSuccess: false,
        );
        return;
      }

      // password validation
      if (password.length < 8) {
        TopSnackBar.show(
          context: context,
          message: 'Password must be at least 8 characters',
          isSuccess: false,
        );
        return;
      }

      // confirm password validation
      if (confirmPassword != password) {
        TopSnackBar.show(
          context: context,
          message: 'Passwords do not match',
          isSuccess: false,
        );
        return;
      }

      TopSnackBar.show(
        context: context,
        message: 'Successfully registered new account!',
        isSuccess: true,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget('Sign up'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Full name *'),
                const TextFieldWidget(
                  hintText: 'Name',
                  keyboardType: TextInputType.text,
                ),
                const Text('Email'),
                TextFieldWidget(
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailCtrl,
                ),
                const Text('Password'),
                TextFieldWidget(
                  obscureText: true,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                  controller: _passwordCtrl,
                ),
                const Text('Confirm password *'),
                TextFieldWidget(
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
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: LetTutorFontWeights.medium,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Or continue with',
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px12,
                      color: LetTutorColors.greyScaleDarkGrey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SocialLoginWidget(svgSource: LetTutorSvg.facebookAuth),
                    SocialLoginWidget(svgSource: LetTutorSvg.google),
                    SocialLoginWidget(svgSource: LetTutorSvg.smartPhone),
                    SocialLoginWidget(svgSource: LetTutorSvg.apple),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 25),
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px12,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Log In',
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
