import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/assets/assets.dart';
import '../../core/styles/styles.dart';
import '../../helpers/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../widgets/index.dart';
import '../index.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void handleLogin() async {
    final email = _emailCtrl.value.text;
    final password = _passwordCtrl.value.text;

    // empty validation
    if (email.isEmpty || password.isEmpty) {
      TopSnackBar.show(
        context: context,
        message: 'Please fill in all fields',
        isSuccess: false,
      );
      return;
    }

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        email,
        password,
        () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
        },
      );
    } on HttpException catch (error) {
      TopSnackBar.show(
        context: context,
        message: error.toString(),
        isSuccess: false,
      );
    } catch (error) {
      debugPrint(error.toString());
      TopSnackBar.show(
        context: context,
        message: 'Failed to login! Please try again later',
        isSuccess: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget('Sign in'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 85,
                  child: Image.asset(
                    LetTutorImages.logo,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    'LET TUTOR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px24,
                      color: LetTutorColors.primaryBlue,
                      fontWeight: LetTutorFontWeights.semiBold,
                    ),
                  ),
                ),
                const Text('Email'),
                TextFieldWidget(
                  controller: _emailCtrl,
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const Text('Password'),
                TextFieldWidget(
                  obscureText: true,
                  controller: _passwordCtrl,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: LetTutorColors.primaryBlue,
                        fontSize: LetTutorFontSizes.px12,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(10),
                    backgroundColor: LetTutorColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Log In',
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
                      text: 'Don\'t have account? ',
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px12,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            fontSize: LetTutorFontSizes.px14,
                            color: LetTutorColors.primaryBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
