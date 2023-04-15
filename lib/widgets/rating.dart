import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_app/widgets/star.dart';

import '../core/assets/index.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        StarWidget(),
        StarWidget(),
        StarWidget(),
        StarWidget(),
        StarWidget(),
      ],
    );
  }
}
