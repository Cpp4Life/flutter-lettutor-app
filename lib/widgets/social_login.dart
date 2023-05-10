import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/styles/index.dart';

class SocialLoginWidget extends StatelessWidget {
  final String svgSource;
  final VoidCallback? onPressed;

  const SocialLoginWidget({
    required this.svgSource,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.white,
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
