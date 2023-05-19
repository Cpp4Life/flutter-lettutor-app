import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../helpers/index.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../screens/index.dart';
import 'index.dart';

class OAuth {
  static Future<void> googleLogin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) return;

    try {
      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (context.mounted) {
        await Provider.of<AuthProvider>(context, listen: false).googleLogin(
          authCredential.accessToken!,
          () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
          },
        );
      }
    } on HttpException catch (error) {
      if (context.mounted) {
        TopSnackBar.showError(
            context, 'Failed to login with Google! Please try again later');
      }
      await Analytics.crashEvent(
        'handleGoogleLogin',
        exception: error.toString(),
      );
    } catch (error) {
      if (context.mounted) {
        TopSnackBar.showError(context, error.toString());
      }
      await Analytics.crashEvent(
        'handleGoogleLogin',
        exception: error.toString(),
      );
    }
  }

  static Future<void> facebookLogin(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status != LoginStatus.success) return;

    final AccessToken? accessToken = loginResult.accessToken;
    if (accessToken == null) return;

    try {
      if (context.mounted) {
        await Provider.of<AuthProvider>(context, listen: false).facebookLogin(
          accessToken.token,
          () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(TabsScreen.routeName, (route) => false);
          },
        );
      }
    } on HttpException catch (error) {
      if (context.mounted) {
        TopSnackBar.showError(
            context, 'Failed to login with Facebook! Please try again later');
      }
      await Analytics.crashEvent(
        'handleFacebookLogin',
        exception: error.toString(),
      );
    } catch (error) {
      if (context.mounted) {
        TopSnackBar.showError(context, error.toString());
      }
      await Analytics.crashEvent(
        'handleFacebookLogin',
        exception: error.toString(),
      );
    }
  }
}
