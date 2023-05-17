import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../helpers/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
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
      TopSnackBar.showError(context, 'Please fill in all fields');
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
      TopSnackBar.showError(context, error.toString());
      await Analytics.crashEvent(
        'handleLogin',
        exception: error.toString(),
      );
    } catch (error) {
      debugPrint(error.toString());
      TopSnackBar.showError(context, 'Failed to login! Please try again later');
      await Analytics.crashEvent(
        'handleLogin',
        exception: error.toString(),
      );
    }
  }

  void handleGoogleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) return;

    try {
      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (!mounted) return;
      await Provider.of<AuthProvider>(context, listen: false).googleLogin(
        authCredential.accessToken!,
        () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
        },
      );
    } on HttpException catch (error) {
      if (!mounted) return;
      TopSnackBar.showError(context, error.toString());
      await Analytics.crashEvent(
        'handleGoogleLogin',
        exception: error.toString(),
      );
    } catch (error) {
      if (!mounted) return;
      TopSnackBar.showError(
          context, 'Failed to login with Google! Please try again later');
      await Analytics.crashEvent(
        'handleGoogleLogin',
        exception: error.toString(),
      );
    }
  }

  void handleFacebookLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status != LoginStatus.success) return;

    final AccessToken? accessToken = loginResult.accessToken;
    if (accessToken == null) return;

    try {
      if (!mounted) return;
      await Provider.of<AuthProvider>(context, listen: false).facebookLogin(
        accessToken.token,
        () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
        },
      );
    } on HttpException catch (error) {
      if (!mounted) return;
      TopSnackBar.showError(context, error.toString());
      await Analytics.crashEvent(
        'handleFacebookLogin',
        exception: error.toString(),
      );
    } catch (error) {
      if (!mounted) return;
      TopSnackBar.showError(
          context, 'Failed to login with Facebook! Please try again later');
      await Analytics.crashEvent(
        'handleFacebookLogin',
        exception: error.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('LOGIN_SCREEN');
    final lang = Provider.of<AppProvider>(context).language;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(lang.loginScreenTitle),
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
                Text(lang.email),
                RoundedTextFieldWidget(
                  controller: _emailCtrl,
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                Text(lang.password),
                RoundedTextFieldWidget(
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
                    child: Text(
                      lang.forgotPassword,
                      style: const TextStyle(
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
                  child: Text(
                    lang.login,
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
                    lang.continueWith,
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
                      onPressed: handleFacebookLogin,
                    ),
                    SocialLoginWidget(
                      svgSource: LetTutorSvg.google,
                      onPressed: handleGoogleLogin,
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
                      text: lang.doNotHaveAccount,
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px12,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: lang.signUp,
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
