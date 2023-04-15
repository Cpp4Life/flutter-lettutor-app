import 'package:flutter/material.dart';

import '../core/styles/index.dart';

class InfoTextWidget extends StatelessWidget {
  final String title;
  final String content;

  const InfoTextWidget({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: LetTutorColors.primaryBlue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: LetTutorFontSizes.px12,
              color: LetTutorColors.greyScaleDarkGrey,
            ),
          ),
        )
      ],
    );
  }
}
