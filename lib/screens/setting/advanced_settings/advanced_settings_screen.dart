import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/assets/index.dart';
import '../../../core/styles/index.dart';
import '../../../models/index.dart';
import '../../../providers/index.dart';
import '../../../services/index.dart';
import '../../../widgets/index.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  static const routeName = '/advanced-settings';

  const AdvancedSettingsScreen({super.key});

  @override
  State<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('ADVANCED_SETTING_SCREEN');
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(lang.advancedSettings),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PopupMenuButton(
            elevation: 0,
            onSelected: (value) async {
              final prefs = await SharedPreferences.getInstance();
              if (value == 0) {
                appProvider.setLanguageTo = English();
                prefs.setString('language', Locale.en.name);
              } else {
                appProvider.setLanguageTo = Vietnamese();
                prefs.setString('language', Locale.vi.name);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        LetTutorSvg.ukFlag,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const Text('English'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        LetTutorSvg.vnFlag,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const Text('Tiếng Việt'),
                  ],
                ),
              ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Language",
                  style: TextStyle(fontSize: LetTutorFontSizes.px16),
                ),
                Text(
                  lang.locale == Locale.en ? 'English' : 'Tiếng Việt',
                  style: const TextStyle(
                    fontSize: LetTutorFontSizes.px14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
