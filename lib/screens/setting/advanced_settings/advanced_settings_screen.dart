import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/assets/assets.dart';
import '../../../core/styles/styles.dart';
import '../../../widgets/index.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  static const routeName = '/advanced-settings';

  const AdvancedSettingsScreen({super.key});

  @override
  State<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  int _selected = 0;

  void handleSelected(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget('Advanced Settings'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PopupMenuButton(
            elevation: 0,
            onSelected: handleSelected,
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
                  _selected == 0 ? 'English' : 'Tiếng Việt',
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
