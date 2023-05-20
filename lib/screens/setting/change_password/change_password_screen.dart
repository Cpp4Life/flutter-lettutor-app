import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/index.dart';
import '../../../helpers/index.dart';
import '../../../models/index.dart';
import '../../../providers/index.dart';
import '../../../services/index.dart';
import '../../../widgets/index.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordCtrl = TextEditingController();
  final TextEditingController _newPasswordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();
  final FocusNode _currentPasswordNode = FocusNode();

  @override
  void dispose() {
    _currentPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _currentPasswordNode.dispose();
    super.dispose();
  }

  void _handleChangePassword() async {
    final String currentPassword = _currentPasswordCtrl.text;
    final String newPassword = _newPasswordCtrl.text;
    final String confirmPassword = _confirmPasswordCtrl.text;

    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      TopSnackBar.showError(context, 'Please enter all fields');
      return;
    }

    if (newPassword.compareTo(confirmPassword) != 0) {
      TopSnackBar.showError(context, 'New passwords do not match');
      return;
    }

    try {
      await Provider.of<UserProvider>(context, listen: false).changePassword(
        currentPassword,
        newPassword,
        () => TopSnackBar.showSuccess(context, 'Change password successfully'),
      );
      _resetInputFields();
    } on HttpException catch (error) {
      TopSnackBar.showError(context, error.toString());
      await Analytics.crashEvent(
        'handleChangePasswordHttpExceptionCatch',
        exception: error.toString(),
        fatal: true,
      );
    } catch (error) {
      TopSnackBar.showError(context, error.toString());
      await Analytics.crashEvent(
        'handleChangePasswordCatch',
        exception: error.toString(),
        fatal: true,
      );
    }
  }

  void _resetInputFields() {
    _currentPasswordCtrl.clear();
    _newPasswordCtrl.clear();
    _confirmPasswordCtrl.clear();
    _currentPasswordNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('CHANGE_PASSWORD_SCREEN');
    final lang = Provider.of<AppProvider>(context).language;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(lang.changePassword),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(lang.password),
                RoundedTextFieldWidget(
                  obscureText: true,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                  controller: _currentPasswordCtrl,
                  focusNode: _currentPasswordNode,
                ),
                Text(lang.newPassword),
                RoundedTextFieldWidget(
                  obscureText: true,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                  controller: _newPasswordCtrl,
                ),
                Text(lang.confirmPassword),
                RoundedTextFieldWidget(
                  obscureText: true,
                  hintText: '********',
                  keyboardType: TextInputType.text,
                  controller: _confirmPasswordCtrl,
                ),
                const SizedBox(
                  height: 36,
                ),
                ElevatedButton(
                  onPressed: _handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(10),
                    backgroundColor: LetTutorColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    lang.changePassword,
                    style: const TextStyle(
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
