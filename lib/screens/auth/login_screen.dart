import 'package:flutter/material.dart';

import '../../core/assets/assets.dart';
import '../../core/styles/styles.dart';
import '../../widgets/social_login.dart';
import '../../widgets/text_input.dart';

class LetTutorLoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LetTutorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: LetTutorColors.secondaryDarkBlue,
          size: 16,
        ),
        centerTitle: false,
        titleSpacing: -10,
        title: const Text(
          'Sign in',
          style: TextStyle(
            color: LetTutorColors.secondaryDarkBlue,
            fontSize: LetTutorFontSizes.px16,
            fontWeight: LetTutorFontWeights.semiBold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      LetTutorImages.logo,
                      fit: BoxFit.cover,
                      // height: 50,
                    ),
                  ),
                  const Text(
                    'LET TUTOR',
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px24,
                      color: LetTutorColors.primaryBlue,
                      fontWeight: LetTutorFontWeights.semiBold,
                    ),
                  ),
                ],
              ),
              const Text('Email'),
              const TextFieldWidget(
                hintText: 'example@email.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const Text('Password'),
              const TextFieldWidget(
                obscureText: true,
                hintText: '********',
                keyboardType: TextInputType.text,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(bottom: 5),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: LetTutorColors.primaryBlue,
                    fontSize: LetTutorFontSizes.px12,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
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
                child: const Text.rich(
                  TextSpan(
                    text: 'Don\'t have account? ',
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px12,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontSize: LetTutorFontSizes.px14,
                          color: LetTutorColors.primaryBlue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
