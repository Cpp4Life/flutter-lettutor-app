import 'package:flutter/material.dart';

import '../../core/styles/index.dart';

class CourseDetailScreen extends StatelessWidget {
  static const routeName = '/course-detail';

  static const List<String> _topicName = [
    "You Are What You Eat",
    "Health and Fitness",
    "Drink Up",
    "Getting Some Zizz",
    "Calm and RnB",
    "Look On The Bright Side",
    "Childhood Memories",
    "Your Family Members",
    "Urbanization",
    "Shopping Habits",
  ];

  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final width = size.width - padding.left - padding.right;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  'https://picsum.photos/536/354',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.black26,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.fromLTRB(15, 65, 15, 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "About Course",
                                style: TextStyle(
                                  fontSize: LetTutorFontSizes.px26,
                                  fontWeight: LetTutorFontWeights.bold,
                                ),
                              ),
                              Text(
                                "The English you need for your work and career",
                                style: TextStyle(
                                  fontSize: LetTutorFontSizes.px14,
                                  color: LetTutorColors.greyScaleDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Text(
                                  "Overview",
                                  style: TextStyle(
                                    fontSize: LetTutorFontSizes.px26,
                                    fontWeight: LetTutorFontWeights.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.help_outline),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10, bottom: 10),
                                          child: const Text(
                                            "Why take this course?",
                                            style: TextStyle(
                                              fontSize: LetTutorFontSizes.px16,
                                              color: LetTutorColors.secondaryDarkBlue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Text(
                                      "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.",
                                      style: TextStyle(
                                        fontSize: LetTutorFontSizes.px14,
                                        color: LetTutorColors.greyScaleDarkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.help_outline),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10, bottom: 10),
                                          child: const Text(
                                            "What will you be able to do?",
                                            style: TextStyle(
                                              fontSize: LetTutorFontSizes.px16,
                                              color: LetTutorColors.secondaryDarkBlue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Text(
                                      "Discuss topics related to physical, mental and emotional health. Learn about other cultures along the the way in friendly conversations with tutors.",
                                      style: TextStyle(
                                        fontSize: LetTutorFontSizes.px14,
                                        color: LetTutorColors.greyScaleDarkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Level",
                                style: TextStyle(
                                  fontSize: LetTutorFontSizes.px26,
                                  fontWeight: LetTutorFontWeights.bold,
                                ),
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                  fontSize: LetTutorFontSizes.px16,
                                  color: LetTutorColors.greyScaleDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 7),
                                child: const Text(
                                  "Topic",
                                  style: TextStyle(
                                    fontSize: LetTutorFontSizes.px26,
                                    fontWeight: LetTutorFontWeights.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) => Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: LetTutorColors.greyScaleLightGrey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            margin: const EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.indigo[200],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              (index + 1).toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: LetTutorFontSizes.px24,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              _topicName[index],
                                              style: const TextStyle(
                                                fontSize: LetTutorFontSizes.px16,
                                                fontWeight: LetTutorFontWeights.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 126,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: LetTutorColors.greyScaleDarkGrey,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: const [
                            Text(
                              "10",
                              style: TextStyle(
                                fontSize: LetTutorFontSizes.px24,
                                fontWeight: FontWeight.bold,
                                color: LetTutorColors.primaryBlue,
                              ),
                            ),
                            Text(
                              "topics",
                              style: TextStyle(
                                fontSize: LetTutorFontSizes.px20,
                                color: LetTutorColors.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: const [
                            Text(
                              "2",
                              style: TextStyle(
                                fontSize: LetTutorFontSizes.px24,
                                fontWeight: FontWeight.bold,
                                color: LetTutorColors.secondaryDarkBlue,
                              ),
                            ),
                            Text(
                              "tutors",
                              style: TextStyle(
                                fontSize: LetTutorFontSizes.px16,
                                color: LetTutorColors.secondaryDarkBlue,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
