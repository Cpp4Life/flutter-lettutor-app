import 'package:flutter/material.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';

class BookingCardWidget extends StatelessWidget {
  final String name;
  final String date;
  final String startTime;
  final String endTime;

  const BookingCardWidget({
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
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
            fontSize: LetTutorFontSizes.px14,
          ),
        ),
        subtitle: Row(
          children: <Widget>[
            Text(
              date,
              style: const TextStyle(
                fontSize: LetTutorFontSizes.px12,
                color: LetTutorColors.greyScaleDarkGrey,
              ),
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 3),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: LetTutorColors.primaryBlue,
                  width: 1,
                ),
                color: LetTutorColors.softBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                startTime,
                style: const TextStyle(
                  fontSize: LetTutorFontSizes.px10,
                  color: LetTutorColors.primaryBlue,
                ),
              ),
            ),
            const Text(
              '-',
              style: TextStyle(
                color: LetTutorColors.secondaryDarkBlue,
              ),
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 3),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                  width: 1,
                ),
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                endTime,
                style: const TextStyle(
                  fontSize: LetTutorFontSizes.px10,
                  color: Colors.orange,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
