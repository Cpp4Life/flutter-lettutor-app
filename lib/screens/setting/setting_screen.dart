import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';
import '../index.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final EdgeInsets _margin = const EdgeInsets.only(bottom: 10);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('SETTING_SCREEN');
    final lang = Provider.of<AppProvider>(context).language;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false).getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.error != null) {
                  return Container();
                }
                return Consumer<UserProvider>(
                  builder: (context, provider, child) => Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          imageUrl:
                              provider.user.avatar ?? 'https://picsum.photos/200/300',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Image.asset(
                            LetTutorImages.avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        provider.user.name ?? '',
                      ),
                      subtitle: Text(
                        provider.user.email ?? '',
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: lang.changePassword,
                iconPath: LetTutorSvg.key,
                onPressed: () =>
                    Navigator.of(context).pushNamed(ChangePasswordScreen.routeName),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: lang.sessionHistory,
                iconPath: LetTutorSvg.history,
                onPressed: () =>
                    Navigator.of(context).pushNamed(SessionHistoryScreen.routeName),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: lang.advancedSettings,
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
                title: lang.ourWebsite,
                iconPath: LetTutorSvg.network,
                onPressed: () => launchUrl(Uri.parse('https://lettutor.com')),
              ),
            ),
            Container(
              margin: _margin,
              child: SettingButtonWidget(
                title: lang.facebook,
                iconPath: LetTutorSvg.facebookSetting,
                onPressed: () =>
                    launchUrl(Uri.parse('https://www.facebook.com/lettutor.edu.vn/')),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 40),
              child: Text.rich(
                TextSpan(
                  text: lang.version,
                  style: const TextStyle(
                    color: LetTutorColors.greyScaleDarkGrey,
                  ),
                  children: const <InlineSpan>[
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                  OnboardScreen.routeName,
                  (Route<dynamic> route) => false,
                );
                Provider.of<AuthProvider>(context, listen: false).logout();
                final navigationProvider =
                    Provider.of<NavigationProvider>(context, listen: false);
                navigationProvider.moveToTab(0, isLogout: true);
              },
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.all(10),
                backgroundColor: LetTutorColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                lang.logout,
                style: const TextStyle(
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
