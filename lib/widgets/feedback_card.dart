import 'package:flutter/material.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';
import 'index.dart';

class FeedbackCardWidget extends StatelessWidget {
  final String name;
  final String avatar;
  final DateTime date;
  final String feedback;

  const FeedbackCardWidget({
    required this.name,
    required this.avatar,
    required this.date,
    required this.feedback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10, top: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          child: Image.asset(
                            LetTutorImages.avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: LetTutorFontSizes.px16,
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        date.toString(),
                                        style: const TextStyle(
                                          fontSize: LetTutorFontSizes.px12,
                                          color: LetTutorColors.secondaryDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Text(
                                  '5.00',
                                  style: TextStyle(
                                    fontSize: LetTutorFontSizes.px16,
                                    color: LetTutorColors.primaryRed,
                                    fontWeight: LetTutorFontWeights.medium,
                                  ),
                                ),
                                const StarWidget(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: LetTutorColors.greyScaleMediumGrey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
