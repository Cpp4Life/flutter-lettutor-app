import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';
import '../helpers/index.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../services/index.dart';

class BookingCardWidget extends StatelessWidget {
  final BookingInfo booking;
  final Function(String) onRemove;

  const BookingCardWidget({
    required this.booking,
    required this.onRemove,
    super.key,
  });

  bool isEnabledMeetingBtn() {
    final now = DateTime.now();
    final start = DateTime.fromMillisecondsSinceEpoch(
        booking.scheduleDetailInfo!.startPeriodTimestamp as int);
    final end = DateTime.fromMillisecondsSinceEpoch(
        booking.scheduleDetailInfo!.endPeriodTimestamp as int);
    return now.isAfter(start) && now.isBefore(end);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return Column(
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: 50,
              height: 50,
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
                      title: lang.cancelConfirmMessage,
                      actionTitle: 'Yes',
                      callback: () async {
                        try {
                          await Provider.of<ScheduleProvider>(context, listen: false)
                              .cancelBooking(
                            booking.id,
                            () =>
                                TopSnackBar.showSuccess(context, lang.cancelSuccessfully),
                          );
                          onRemove(booking.id);
                        } on HttpException catch (e) {
                          TopSnackBar.showError(context, e.toString());
                          await Analytics.crashEvent(
                            'bookingCardCatch',
                            exception: e.toString(),
                          );
                        }
                      },
                    );
                  } else {
                    TopSnackBar.showError(context, lang.cancelFailed);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: LetTutorColors.paleGrey,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    lang.cancel,
                    style: const TextStyle(
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
                    color: isEnabledMeetingBtn()
                        ? LetTutorColors.primaryBlue
                        : LetTutorColors.greyScaleMediumGrey,
                  ),
                  color: isEnabledMeetingBtn()
                      ? LetTutorColors.primaryBlue
                      : LetTutorColors.greyScaleMediumGrey,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: !isEnabledMeetingBtn()
                      ? null
                      : () async {
                          final base64Decoded = base64.decode(
                            base64.normalize(
                              booking.studentMeetingLink!
                                  .split('token=')[1]
                                  .split(".")[1],
                            ),
                          );
                          final url = utf8.decode(base64Decoded);
                          final decodedResponse = json.decode(url);
                          final String roomId = decodedResponse['room'];
                          final String token =
                              booking.studentMeetingLink!.split('token=')[1];

                          final options = JitsiMeetingOptions(room: roomId)
                            ..serverURL = 'https://meet.lettutor.com'
                            ..audioOnly = true
                            ..audioMuted = true
                            ..token = token
                            ..videoMuted = true;

                          await JitsiMeet.joinMeeting(options);
                        },
                  child: Text(
                    lang.goToMeeting,
                    style: const TextStyle(
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
