import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/assets/index.dart';
import 'index.dart';

class MeetingBarWidget extends StatelessWidget {
  const MeetingBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MeetingButtonWidget(iconPath: LetTutorSvg.microOn),
          const MeetingButtonWidget(iconPath: LetTutorSvg.microOff),
          const MeetingButtonWidget(iconPath: LetTutorSvg.meetingChat),
          const MeetingButtonWidget(iconPath: LetTutorSvg.shareScreen),
          const MeetingButtonWidget(iconPath: LetTutorSvg.threeDot),
          InkWell(
            onTap: () {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.dark.copyWith(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
              );
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red,
              ),
              child: const MeetingButtonWidget(
                iconPath: LetTutorSvg.phone,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
