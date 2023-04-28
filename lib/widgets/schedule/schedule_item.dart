import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/styles/index.dart';

class ScheduleItemWidget extends StatelessWidget {
  final int startTimeStamp;

  const ScheduleItemWidget(
    this.startTimeStamp,
    Key? key,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
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
        child: Text(
          DateFormat.MMMEd().format(
            DateTime.fromMillisecondsSinceEpoch(startTimeStamp),
          ),
          style: const TextStyle(color: LetTutorColors.primaryBlue),
        ),
      ),
    );
  }
}
