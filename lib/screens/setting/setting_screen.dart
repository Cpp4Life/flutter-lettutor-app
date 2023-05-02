import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../providers/index.dart';
import '../../widgets/index.dart';
import '../index.dart';

class SettingScreen extends StatelessWidget {
  final EdgeInsets _margin = const EdgeInsets.only(bottom: 10);

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  child: Image.asset(
                    LetTutorImages.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Dat Truong Gia',
                ),
                subtitle: const Text(
                  'tgdat19@clc.fitus.edu.vn',
                ),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: 'View Feedbacks',
                iconPath: LetTutorSvg.user,
                onPressed: () =>
                    Navigator.of(context).pushNamed(ViewFeedbacksScreen.routeName),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: 'Booking History',
                iconPath: LetTutorSvg.list,
                onPressed: () =>
                    Navigator.of(context).pushNamed(BookingHistoryScreen.routeName),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: 'Session History',
                iconPath: LetTutorSvg.history,
                onPressed: () =>
                    Navigator.of(context).pushNamed(SessionHistoryScreen.routeName),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: 'Advanced Settings',
                iconPath: LetTutorSvg.settingProfile,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AdvancedSettingsScreen.routeName),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: 'Our Website',
                iconPath: LetTutorSvg.network,
                onPressed: () => launchUrl(Uri.parse('https://lettutor.com')),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: 'Facebook',
                iconPath: LetTutorSvg.facebookSetting,
                onPressed: () =>
                    launchUrl(Uri.parse('https://www.facebook.com/lettutor.edu.vn/')),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 40),
              child: const Text.rich(
                TextSpan(
                  text: 'Version',
                  style: TextStyle(
                    color: LetTutorColors.greyScaleDarkGrey,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: ' 1.0.0',
                      style: TextStyle(
                        color: LetTutorColors.secondaryDarkBlue,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(OnboardScreen.routeName);
                Provider.of<AuthProvider>(context, listen: false).logout();
                final navigationProvider =
                    Provider.of<NavigationProvider>(context, listen: false);
                navigationProvider.index = 0;
              },
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.all(10),
                backgroundColor: LetTutorColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Log out',
                style: TextStyle(
                  fontWeight: LetTutorFontWeights.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
