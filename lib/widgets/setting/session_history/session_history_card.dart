import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/assets/index.dart';
import '../../../core/styles/index.dart';
import '../../../models/index.dart';
import '../../../providers/index.dart';
import '../../index.dart';

class SessionHistoryCardWidget extends StatelessWidget {
  final BookingInfo booking;

  const SessionHistoryCardWidget({
    required this.booking,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CachedImageNetworkWidget(
              booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar,
            ),
            title: Text(
              booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name as String,
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
                        DateFormat('E, dd/MM/yyyy').add_jm().format(
                              DateTime.fromMillisecondsSinceEpoch(booking
                                  .scheduleDetailInfo!.startPeriodTimestamp as int),
                            ),
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
                        '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(booking.scheduleDetailInfo!.startPeriodTimestamp as int))} - ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(booking.scheduleDetailInfo!.startPeriodTimestamp as int))}',
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
                        '${lang.mark} ${booking.scoreByTutor != null ? booking.scoreByTutor.toString() : lang.noMarking}',
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: LetTutorColors.primaryBlue,
                      border: Border.all(
                        color: LetTutorColors.primaryBlue,
                      ),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      lang.feedback,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: LetTutorFontSizes.px14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: LetTutorColors.primaryBlue,
                      ),
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      lang.sessionRecord,
                      style: const TextStyle(
                        color: LetTutorColors.primaryBlue,
                        fontSize: LetTutorFontSizes.px14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
