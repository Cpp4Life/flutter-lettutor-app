import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/styles/styles.dart';
import '../../widgets/index.dart';

class MeetingScreen extends StatefulWidget {
  static const routeName = '/meeting';

  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Timer _timerInRoom;
  late Timer _timerToStart;

  int _countTimeInRoom = 0;
  int _countTimeToStart = 15 * 60 * 60;

  @override
  void initState() {
    _timerInRoom = Timer.periodic(
      const Duration(seconds: 1),
      (_) => increase(_),
    );

    _timerToStart = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => decrease(timer),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timerInRoom.cancel();
    _timerToStart.cancel();
  }

  void increase(Timer timer) {
    setState(() {
      _countTimeInRoom++;
    });
  }

  void decrease(Timer timer) {
    setState(() {
      if (_countTimeToStart <= 0) {
        return;
      }
      _countTimeToStart--;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Tutorial Meeting Room ${_printDuration(Duration(seconds: _countTimeInRoom))}',
                        style: const TextStyle(
                          color: LetTutorColors.greyScaleLightGrey,
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: LetTutorColors.primaryBlue,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Lesson will be started after",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: LetTutorFontSizes.px16,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              _printDuration(
                                Duration(seconds: _countTimeToStart),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: LetTutorFontSizes.px20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        'You are the only one in the meeting',
                        style: TextStyle(
                          color: LetTutorColors.greyScaleLightGrey,
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const MeetingBarWidget(),
          ],
        ),
      ),
    );
  }
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)} : $twoDigitMinutes : $twoDigitSeconds";
}
