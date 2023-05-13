import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../index.dart';

class OnboardScreen extends StatelessWidget {
  static const routeName = "/onboard";

  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    context.read<Analytics>().setTrackingScreen('ONBOARD_SCREEN');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: const SizedBox(
                      height: 50,
                      width: 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: LetTutorColors.primaryBlue),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      'LET\nTUTOR',
                      softWrap: true,
                      style: TextStyle(
                        color: LetTutorColors.primaryBlue,
                        fontWeight: LetTutorFontWeights.medium,
                        fontSize: LetTutorFontSizes.px24,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  lang.intro,
                  style: const TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                    fontWeight: LetTutorFontWeights.regular,
                    fontSize: LetTutorFontSizes.px24,
                  ),
                ),
              ),
              Image.asset(
                LetTutorImages.banner,
                fit: BoxFit.cover,
              ),
              Container(
                margin: const EdgeInsets.only(top: 45),
                alignment: Alignment.centerRight,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
                      backgroundColor: LetTutorColors.primaryBlue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    icon: SvgPicture.asset(
                      LetTutorSvg.leftArrow,
                      color: Colors.white,
                    ),
                    label: Text(lang.nextButton),
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
