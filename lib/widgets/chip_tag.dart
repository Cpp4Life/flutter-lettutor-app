import 'package:flutter/material.dart';

import '../core/styles/styles.dart';

class ChipTagWidget extends StatelessWidget {
  final String tag;

  const ChipTagWidget(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: LetTutorColors.softBlue,
      side: BorderSide(
        color: Colors.blue[100] as Color,
      ),
      label: Text(
        tag,
        style: const TextStyle(
          fontSize: LetTutorFontSizes.px12,
          color: LetTutorColors.primaryBlue,
        ),
      ),
    );
  }
}
