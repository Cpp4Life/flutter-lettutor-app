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
                            ? 'Upcoming lesson'
                            : 'Welcome to LetTutor!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: LetTutorFontSizes.px20,
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
                          if (_upcomingClass == null) {
                            navigationProvider.index = 3;
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
                          _upcomingClass == null ? 'Book a lesson' : 'Enter lesson room',
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
                        onPressed: () {
                          navigationProvider.index = 3;
                        },
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
                    builder: (context, provider, child) => provider.favoriteTutors.isEmpty
                        ? const FreeContentWidget('No available tutors')
                        : Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: ListView.builder(
                              itemCount: provider.favoriteTutors.length,
                              itemBuilder: (context, index) {
                                return RecommendedTutorCardWidget(
                                  id: provider.favoriteTutors[index].secondInfo!.id,
                                  key: ValueKey(
                                      provider.favoriteTutors[index].secondInfo!.id),
                                  name: provider.favoriteTutors[index].secondInfo!.name
                                      as String,
                                  avatar:
                                      provider.favoriteTutors[index].secondInfo!.avatar,
                                  bio: provider.favoriteTutors[index].tutorInfo!.bio
                                      as String,
                                  specialties: provider
                                      .favoriteTutors[index].tutorInfo!.specialties
                                      ?.split(',') as List<String>,
                                  rating:
                                      provider.favoriteTutors[index].tutorInfo!.rating,
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

class CountdownTimer extends StatefulWidget {
  final DateTime start;

  const CountdownTimer(this.start, {super.key});

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

    return Text(
      'starts in $days (d) $hours (h) $minutes (m) $seconds (s)',
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: LetTutorFontSizes.px14,
        fontWeight: LetTutorFontWeights.medium,
      ),
    );
  }
}
