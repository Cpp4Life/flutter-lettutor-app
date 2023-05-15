import 'package:flutter/material.dart';

import '../../core/styles/index.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBarWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: LetTutorColors.secondaryDarkBlue,
        size: 16,
      ),
      centerTitle: false,
      titleSpacing: -10,
      title: Text(
        title,
        style: const TextStyle(
          color: LetTutorColors.secondaryDarkBlue,
          fontSize: LetTutorFontSizes.px16,
          fontWeight: LetTutorFontWeights.semiBold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
