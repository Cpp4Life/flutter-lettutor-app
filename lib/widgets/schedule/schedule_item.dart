import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/styles/index.dart';
import '../../helpers/index.dart';
import '../../models/index.dart';
import '../index.dart';

class ScheduleItemWidget extends StatelessWidget {
  final int startTimeStamp;
  final List<ScheduleDetails> details;

  const ScheduleItemWidget(
    this.startTimeStamp,
    this.details,
    Key? key,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BottomModalSheet.show(
          context: context,
          title: 'Choose available time',
          widget: PeriodGridWidget(details),
        );
      },
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
          DateFormat.yMMMEd().format(
            DateTime.fromMillisecondsSinceEpoch(startTimeStamp),
          ),
          style: const TextStyle(color: LetTutorColors.primaryBlue),
        ),
      ),
    );
  }
}
