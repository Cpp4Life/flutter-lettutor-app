import 'package:flutter/material.dart';

import '../../../core/styles/index.dart';
import '../../../widgets/index.dart';

class ViewFeedbacksScreen extends StatelessWidget {
  static const routeName = '/view-feedbacks';

  const ViewFeedbacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget('Feedback List'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '5.0',
                        style: TextStyle(
                          fontSize: LetTutorFontSizes.px26,
                          fontWeight: FontWeight.bold,
                          color: LetTutorColors.primaryRed,
                        ),
                      ),
                      StarWidget(),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    return FeedbackCardWidget(
                      name: feedbacks[index]['name'] as String,
                      avatar: '',
                      date: DateTime.now(),
                      feedback: feedbacks[index]['feedback'] as String,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const feedbacks = [
  {
    "name": "Abby",
    "tags": ["english"],
    "feedback":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Selena Phan",
    "tags": ["english", "Vietnamese"],
    "feedback":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Kathy Huynh",
    "tags": ["English", "Vietnamese"],
    "feedback":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Jovieline",
    "tags": [
      "english",
      "Vietnamese",
      "Basic French",
      "Basic German",
      "Basic Mandarin Chinese"
    ],
    "feedback":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Jovieline",
    "tags": [
      "english",
      "Vietnamese",
      "Basic French",
      "Basic German",
      "Basic Mandarin Chinese"
    ],
    "feedback":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Jovieline",
    "tags": [
      "english",
      "Vietnamese",
      "Basic French",
      "Basic German",
      "Basic Mandarin Chinese"
    ],
    "feedback":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
];
