import 'package:flutter/material.dart';

import '../../widgets/index.dart';

class TutorsScreen extends StatelessWidget {
  static const routeName = '/tutors';

  static const List<String> _tags = [
    'All',
    'English for Kids',
    'Business English',
    'Conversational English',
    'STARTERS',
    'FLYERS',
    'KEY',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC',
  ];

  const TutorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarWidget('Search Tutors'),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SizedBox(
            height: 35,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: _tags.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: ChipTagWidget(_tags[index]),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ListView.builder(
              itemCount: tutors.length,
              itemBuilder: (context, index) {
                return TutorCardWidget(
                  name: tutors[index]['name'] as String,
                  avatar: '',
                  intro: tutors[index]['intro'] as String,
                  tags: tutors[index]['tags'] as List<String>,
                );
              },
              shrinkWrap: true,
            ),
          ),
        )
      ],
    );
  }
}

const tutors = [
  {
    "name": "Abby",
    "tags": ["english"],
    "intro":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Selena Phan",
    "tags": ["english", "Vietnamese"],
    "intro":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
  {
    "name": "Kathy Huynh",
    "tags": ["English", "Vietnamese"],
    "intro":
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
    "intro":
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
    "intro":
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
    "intro":
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
  },
];
