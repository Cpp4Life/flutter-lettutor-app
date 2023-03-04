import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = "/introduction";

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: const Text(
                  'LET\nTUTOR',
                  style: TextStyle(
                    color: LetTutorColors.primaryBlue,
                    fontWeight: LetTutorFontWeights.semiBold,
                    fontSize: LetTutorFontSizes.px24,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: const Text(
                  'English\nLanguage Teaching',
                  style: TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                    fontWeight: LetTutorFontWeights.medium,
                    fontSize: LetTutorFontSizes.px20,
                  ),
                ),
              ),
              Image.asset(
                LetTutorImages.banner,
                fit: BoxFit.cover,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.centerRight,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LetTutorColors.primaryBlue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      LetTutorSvg.leftArrow,
                      color: Colors.white,
                    ),
                    label: const Text("Get Started"),
                    //.........
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
