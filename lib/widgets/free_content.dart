import 'package:flutter/material.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';

class FreeContentWidget extends StatelessWidget {
  final String title;

  const FreeContentWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(LetTutorImages.folder),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: LetTutorFontSizes.px14,
            fontWeight: LetTutorFontWeights.medium,
          ),
        ),
      ],
    );
  }
}
