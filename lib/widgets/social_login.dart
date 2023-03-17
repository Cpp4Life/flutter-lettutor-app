import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/styles/styles.dart';

class SocialLoginWidget extends StatelessWidget {
  final String svgSource;

  const SocialLoginWidget({
    required this.svgSource,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(
              width: 1,
              color: LetTutorColors.primaryBlue,
            ),
          ),
          padding: const EdgeInsets.all(5)),
      child: SvgPicture.asset(
        svgSource,
        width: 30,
        height: 30,
      ),
    );
  }
}
