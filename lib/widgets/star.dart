import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/assets.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      LetTutorSvg.filledStar,
      width: 20,
      height: 20,
      color: Colors.yellow[700],
    );
  }
}
