import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../helpers/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void handleForgetPassword() async {
    final email = _emailCtrl.value.text;

    // empty validation
    if (email.isEmpty) {
      TopSnackBar.show(
        context: context,
        message: 'Please enter your email',
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

    try {
      Provider.of<AuthProvider>(context, listen: false).forgetPassword(
        email,
        () {
          TopSnackBar.show(
            context: context,
            message: 'Email sent successfully',
            isSuccess: true,
          );
          Navigator.of(context).pop();
        },
      );
    } on HttpException catch (error) {
      TopSnackBar.show(
        context: context,
        message: error.toString(),
        isSuccess: false,
      );
      await Analytics.crashEvent(
        'handleForgetPassword',
        exception: error.toString(),
      );
    } catch (error) {
      debugPrint(error.toString());
      TopSnackBar.show(
        context: context,
        message: 'Failed to sign you up! Please try again later',
        isSuccess: false,
      );
      await Analytics.crashEvent(
        'handleForgetPassword',
        exception: error.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('FORGET_PASSWORD_SCREEN');
    final lang = Provider.of<AppProvider>(context).language;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(lang.forgotPasswordTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  height: 80,
                ),
                Text(
                  lang.instruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: LetTutorFontSizes.px14,
                    color: LetTutorColors.greyScaleDarkGrey,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextFieldWidget(
                  controller: _emailCtrl,
                  hintText: lang.emailHint,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: handleForgetPassword,
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(10),
                    backgroundColor: LetTutorColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    lang.send,
                    style: const TextStyle(
                      fontSize: LetTutorFontSizes.px14,
                      fontWeight: LetTutorFontWeights.medium,
                      color: Colors.white,
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
