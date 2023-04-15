import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';

class SessionHistoryCardWidget extends StatelessWidget {
  final String name;
  final String date;
  final String duration;
  final String review;

  const SessionHistoryCardWidget({
    required this.name,
    required this.date,
    required this.duration,
    required this.review,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(
          LetTutorImages.banner,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: LetTutorFontSizes.px16,
          fontWeight: LetTutorFontWeights.medium,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: SvgPicture.asset(
                    LetTutorSvg.calendar,
                    fit: BoxFit.cover,
                    width: 20,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                    fontSize: LetTutorFontSizes.px12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: SvgPicture.asset(
                    LetTutorSvg.clock,
                    fit: BoxFit.cover,
                    width: 20,
                  ),
                ),
                Text(
                  duration,
                  style: const TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                    fontSize: LetTutorFontSizes.px12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: SvgPicture.asset(
                    LetTutorSvg.borderStar,
                    fit: BoxFit.cover,
                    width: 20,
                  ),
                ),
                Text(
                  review,
                  style: const TextStyle(
                    color: LetTutorColors.secondaryDarkBlue,
                    fontSize: LetTutorFontSizes.px12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
