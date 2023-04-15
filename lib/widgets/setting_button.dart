import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';

class SettingButtonWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final String routeName;

  const SettingButtonWidget({
    required this.title,
    required this.iconPath,
    required this.routeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(routeName);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        backgroundColor: Colors.white,
        shadowColor: LetTutorColors.greyScaleDarkGrey,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 0.5,
            color: LetTutorColors.greyScaleLightGrey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              LetTutorSvg.next,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
