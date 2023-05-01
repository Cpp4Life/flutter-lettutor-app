import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalTimeInMinutes = 0;
  BookingInfo? _upcomingClass;
  bool _isLoading = true;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchTotalLessonTimeAndUpcomingClass();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void fetchTotalLessonTimeAndUpcomingClass() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final totalTime = await userProvider.getTotalLessonTime();
    final upcoming = await userProvider.getUpcoming();
    if (mounted) {
      setState(() {
        _totalTimeInMinutes = totalTime;
        _upcomingClass = upcoming;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: LetTutorColors.primaryBlue,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Upcoming lesson',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: LetTutorFontSizes.px20,
                        ),
                      ),
                      Text(
                        _upcomingClass == null
                            ? 'There is no upcoming class'
                            : intl.DateFormat('E, dd MMM yyyy, HH:mm - ').format(
                                  DateTime.fromMillisecondsSinceEpoch(_upcomingClass!
                                      .scheduleDetailInfo!.startPeriodTimestamp!),
                                ) +
                                intl.DateFormat('HH:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(_upcomingClass!
                                      .scheduleDetailInfo!.endPeriodTimestamp!),
                                ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                      Text(
                        'Total lesson time is ${durationToString(_totalTimeInMinutes)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_upcomingClass != null) {
                            final base64Decoded = base64.decode(
                              base64.normalize(
                                _upcomingClass!.studentMeetingLink!
                                    .split('token=')[1]
                                    .split(".")[1],
                              ),
                            );
                            final urlObject = utf8.decode(base64Decoded);
                            final jsonRes = json.decode(urlObject);
                            final String roomId = jsonRes['room'];
                            final String tokenMeeting =
                                _upcomingClass!.studentMeetingLink!.split('token=')[1];

                            final options = JitsiMeetingOptions(room: roomId)
                              ..serverURL = 'https://meet.lettutor.com'
                              ..audioOnly = true
                              ..audioMuted = true
                              ..token = tokenMeeting
                              ..videoMuted = true;

                            await JitsiMeet.joinMeeting(options);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          side: const BorderSide(color: LetTutorColors.primaryBlue),
                        ),
                        child: const Text(
                          'Enter lesson room',
                          style: TextStyle(
                            color: LetTutorColors.primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.5, // Underline thickness
                          ),
                        ),
                      ),
                      child: const Text(
                        'Recommended Tutors',
                        style: TextStyle(
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        icon: SvgPicture.asset(
                          LetTutorSvg.next,
                          color: LetTutorColors.primaryBlue,
                        ),
                        label: const Text(
                          'See all',
                          style: TextStyle(
                            color: LetTutorColors.primaryBlue,
                            fontSize: LetTutorFontSizes.px14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: Provider.of<TutorProvider>(context, listen: false)
                    .fetchAndSetTutors(page: 1, perPage: 9),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.error != null) {
                    return const FreeContentWidget('No available tutors');
                  }
                  return Consumer<TutorProvider>(
                    builder: (context, tutorsData, child) => tutorsData.tutors.isEmpty
                        ? const FreeContentWidget('No available tutors')
                        : Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: ListView.builder(
                              itemCount: tutorsData.tutors.length,
                              itemBuilder: (context, index) {
                                return RecommendedTutorCardWidget(
                                  id: tutorsData.tutors[index].userId as String,
                                  key: ValueKey(tutorsData.tutors[index].id),
                                  name: tutorsData.tutors[index].name as String,
                                  avatar: tutorsData.tutors[index].avatar,
                                  bio: tutorsData.tutors[index].bio as String,
                                  specialties: tutorsData.tutors[index].specialties
                                      ?.split(',') as List<String>,
                                  rating: tutorsData.tutors[index].rating,
                                );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  String durationToString(int minutes) {
    final d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} hour(s) ${parts[1].padLeft(2, '0')} minutes';
  }
}
