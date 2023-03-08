import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';
import 'auth/login_screen.dart';

class LetTutorIntroScreen extends StatelessWidget {
  static const routeName = "/introduction";

  const LetTutorIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const Text(
                  'English\nLanguage Teaching',
                  style: TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                    fontWeight: LetTutorFontWeights.medium,
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
                      backgroundColor: LetTutorColors.primaryBlue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LetTutorLoginScreen.routeName);
                    },
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
