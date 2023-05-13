import 'dart:async';
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
import '../../services/index.dart';
import '../../widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Language _lang;
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
    context.read<Analytics>().setTrackingScreen('HOME_SCREEN');
    final navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
    _lang = Provider.of<AppProvider>(context).language;

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
                      Text(
                        _upcomingClass != null
                            ? _lang.upcomingLesson
                            : _lang.welcomeMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: LetTutorFontSizes.px18,
                        ),
                      ),
                      if (_upcomingClass != null)
                        Text(
                          intl.DateFormat('E, dd MMM yyyy, HH:mm - ').format(
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
                      if (_upcomingClass != null)
                        CountdownTimer(
                          DateTime.fromMillisecondsSinceEpoch(
                              _upcomingClass!.scheduleDetailInfo!.startPeriodTimestamp!),
                          _lang,
                        ),
                      Text(
                        '${_lang.totalLessonTime} ${durationToString(_totalTimeInMinutes)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_upcomingClass == null) {
                            navigationProvider.moveToTab(3);
                            return;
                          }

                          final base64Decoded = base64.decode(
                            base64.normalize(
                              _upcomingClass!.studentMeetingLink!
                                  .split('token=')[1]
                                  .split(".")[1],
                            ),
                          );
                          final url = utf8.decode(base64Decoded);
                          final decodedResponse = json.decode(url);
                          final String roomId = decodedResponse['room'];
                          final String token =
                              _upcomingClass!.studentMeetingLink!.split('token=')[1];

                          final options = JitsiMeetingOptions(room: roomId)
                            ..serverURL = 'https://meet.lettutor.com'
                            ..audioOnly = true
                            ..audioMuted = true
                            ..token = token
                            ..videoMuted = true;

                          await JitsiMeet.joinMeeting(options);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          side: const BorderSide(color: LetTutorColors.primaryBlue),
                        ),
                        child: Text(
                          _upcomingClass == null
                              ? _lang.bookButtonTitle
                              : 'Enter lesson room',
                          style: const TextStyle(
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
                padding: const EdgeInsets.only(left: 20, right: 15),
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
                      child: Text(
                        _lang.recommendedTutor,
                        style: const TextStyle(
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        onPressed: () {
                          navigationProvider.moveToTab(3);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        icon: SvgPicture.asset(
                          LetTutorSvg.next,
                          color: LetTutorColors.primaryBlue,
                        ),
                        label: Text(
                          _lang.seeAll,
                          style: const TextStyle(
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
                    builder: (context, provider, child) => provider.tutors.isEmpty
                        ? const FreeContentWidget('No available tutors')
                        : Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: ListView.builder(
                              itemCount: provider.tutors.length,
                              itemBuilder: (context, index) {
                                return RecommendedTutorCardWidget(
                                  id: provider.tutors[index].userId!,
                                  key: ValueKey(provider.tutors[index].userId!),
                                  name: provider.tutors[index].name as String,
                                  avatar: provider.tutors[index].avatar,
                                  bio: provider.tutors[index].bio as String,
                                  specialties: provider.tutors[index].specialties
                                      ?.split(',') as List<String>,
                                  rating: provider.tutors[index].rating,
                                  isFavorite: provider.tutors[index].isFavorite,
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
    final hourText = _lang is Vietnamese ? 'giờ' : 'hour(s)';
    final minText = _lang is Vietnamese ? 'phút' : 'minute(s)';
    return '${parts[0].padLeft(2, '0')} $hourText ${parts[1].padLeft(2, '0')} $minText';
  }
}

class CountdownTimer extends StatefulWidget {
  final DateTime start;
  final Language lang;

  const CountdownTimer(this.start, this.lang, {super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _remaining = widget.start.difference(now);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = _remaining.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          _timer!.cancel();
        } else {
          _remaining = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(_remaining.inDays);
    final hours = strDigits(_remaining.inHours.remainder(24));
    final minutes = strDigits(_remaining.inMinutes.remainder(60));
    final seconds = strDigits(_remaining.inSeconds.remainder(60));

    final startText = widget.lang is Vietnamese ? 'bắt đầu trong' : 'starts in';

    return Text(
      '$startText $days (d) $hours (h) $minutes (m) $seconds (s)',
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: LetTutorFontSizes.px14,
        fontWeight: LetTutorFontWeights.medium,
      ),
    );
  }
}
