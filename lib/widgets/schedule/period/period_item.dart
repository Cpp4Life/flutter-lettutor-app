import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/styles/index.dart';

class PeriodItemWidget extends StatelessWidget {
  final String scheduleId;
  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final bool isBooked;

  const PeriodItemWidget({
    required this.scheduleId,
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.isBooked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('scheduleID: $scheduleId - isBooked: $isBooked');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isBooked ? LetTutorColors.paleGrey : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            color: LetTutorColors.primaryBlue,
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(startPeriodTimestamp),
              )} - ",
              style: const TextStyle(
                color: LetTutorColors.primaryBlue,
              ),
            ),
            Text(
              DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(endPeriodTimestamp),
              ),
              style: const TextStyle(
                color: LetTutorColors.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
