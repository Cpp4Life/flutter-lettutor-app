import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/assets.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          LetTutorSvg.filledStar,
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ),
        SvgPicture.asset(
          LetTutorSvg.filledStar,
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ),
        SvgPicture.asset(
          LetTutorSvg.filledStar,
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ),
        SvgPicture.asset(
          LetTutorSvg.filledStar,
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ),
        SvgPicture.asset(
          LetTutorSvg.filledStar,
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ),
      ],
    );
  }
}
