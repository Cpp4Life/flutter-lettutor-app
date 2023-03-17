import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeetingButtonWidget extends StatelessWidget {
  final String iconPath;

  const MeetingButtonWidget({
    required this.iconPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      child: SvgPicture.asset(
        iconPath,
        color: Colors.grey[100],
      ),
    );
  }
}
