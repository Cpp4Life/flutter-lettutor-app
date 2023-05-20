import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/styles/index.dart';
import '../../../helpers/index.dart';
import '../../../models/index.dart';
import '../../../providers/index.dart';
import '../../../services/index.dart';

class PeriodItemWidget extends StatefulWidget {
  final String id;
  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final bool isBooked;

  const PeriodItemWidget({
    required this.id,
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.isBooked,
    Key? key,
  }) : super(key: key);

  @override
  State<PeriodItemWidget> createState() => _PeriodItemWidgetState();
}

class _PeriodItemWidgetState extends State<PeriodItemWidget> {
  late bool _isBooked = widget.isBooked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isBooked
          ? null
          : () {
              ConfirmModal.show(
                context: context,
                title: 'Are you sure to book this class?',
                actionTitle: 'Book',
                callback: () async {
                  try {
                    await Provider.of<ScheduleProvider>(context, listen: false).bookClass(
                      widget.id,
                      () {
                        TopSnackBar.showSuccess(context, 'Booked class successfully');
                      },
                    );
                    setState(() {
                      _isBooked = true;
                    });
                  } on HttpException catch (e) {
                    TopSnackBar.showError(context, e.toString());
                    await Analytics.crashEvent(
                      'periodItemCatch',
                      exception: e.toString(),
                    );
                  } catch (e) {
                    TopSnackBar.showError(context, 'Oops! Something went wrong');
                    await Analytics.crashEvent(
                      'periodItemCatch',
                      exception: e.toString(),
                    );
                  }
                },
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(widget.startPeriodTimestamp),
              )} - ",
              style: const TextStyle(
                color: LetTutorColors.primaryBlue,
              ),
            ),
            Text(
              DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(widget.endPeriodTimestamp),
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
