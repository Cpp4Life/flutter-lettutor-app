import 'package:flutter/material.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';

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
            child: Image.asset(
              LetTutorImages.folder,
              fit: BoxFit.cover,
            ),
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
