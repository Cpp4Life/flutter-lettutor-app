import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';
import '../helpers/index.dart';
import '../models/index.dart';
import '../providers/index.dart';

class BookingCardWidget extends StatelessWidget {
  final BookingInfo booking;

  const BookingCardWidget({
    required this.booking,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl:
                  booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar as String,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Image.asset(
                LetTutorImages.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name as String,
            style: const TextStyle(
              fontSize: LetTutorFontSizes.px14,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                DateFormat('E, dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(
                    booking.scheduleDetailInfo!.startPeriodTimestamp as int)),
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
                  DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      booking.scheduleDetailInfo!.startPeriodTimestamp as int)),
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
                  DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                      booking.scheduleDetailInfo!.endPeriodTimestamp as int)),
                  style: const TextStyle(
                    fontSize: LetTutorFontSizes.px10,
                    color: Colors.orange,
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final now = DateTime.now();
                  final start = DateTime.fromMillisecondsSinceEpoch(
                      booking.scheduleDetailInfo!.startPeriodTimestamp as int);
                  if (start.isAfter(now) && now.difference(start).inHours.abs() >= 2) {
                    ConfirmModal.show(
                      context: context,
                      title: 'Are you sure to cancel meeting?',
                      actionTitle: 'Yes',
                      callback: () async {
                        try {
                          await Provider.of<ScheduleProvider>(context, listen: false)
                              .cancelBooking(
                            booking.id,
                            () {
                              TopSnackBar.show(
                                context: context,
                                message: 'Cancel meeting successfully',
                                isSuccess: true,
                              );
                            },
                          );
                        } on HttpException catch (e) {
                          TopSnackBar.show(
                            context: context,
                            message: e.toString(),
                            isSuccess: false,
                          );
                        }
                      },
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: LetTutorColors.greyScaleMediumGrey,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: LetTutorColors.primaryRed,
                      fontSize: LetTutorFontSizes.px14,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: LetTutorColors.greyScaleMediumGrey,
                  ),
                  color: LetTutorColors.greyScaleMediumGrey,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Go to meeting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: LetTutorFontSizes.px14,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
