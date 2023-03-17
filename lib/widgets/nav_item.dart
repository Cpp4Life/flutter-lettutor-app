import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/styles/styles.dart';

class NavItem {
  static BottomNavigationBarItem generateItem(
    context, {
    required svgSource,
    required label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        svgSource,
        height: 20,
        width: 20,
        color: LetTutorColors.primaryBlue,
      ),
      icon: SvgPicture.asset(
        svgSource,
        height: 20,
        width: 20,
        color: LetTutorColors.greyScaleDarkGrey,
      ),
      label: label,
    );
  }
}
