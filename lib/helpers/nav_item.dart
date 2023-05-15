import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/styles/index.dart';

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
        colorFilter: const ColorFilter.mode(
          LetTutorColors.primaryBlue,
          BlendMode.srcIn,
        ),
      ),
      icon: SvgPicture.asset(
        svgSource,
        height: 20,
        width: 20,
        colorFilter: const ColorFilter.mode(
          LetTutorColors.greyScaleDarkGrey,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
