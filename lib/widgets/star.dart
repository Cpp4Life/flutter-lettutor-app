import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/index.dart';

class StarWidget extends StatelessWidget {
  final bool isFilled;

  const StarWidget({this.isFilled = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isFilled ? LetTutorSvg.filledStar : LetTutorSvg.borderStar,
      width: 20,
      height: 20,
      color: Colors.yellow[700],
    );
  }
}
