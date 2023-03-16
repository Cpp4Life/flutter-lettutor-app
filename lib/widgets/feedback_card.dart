import 'package:flutter/material.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';
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
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
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
