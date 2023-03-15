import 'package:flutter/material.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';
import '../screens/tutor/tutor_detail_screen.dart';
import 'index.dart';

class TutorCardWidget extends StatelessWidget {
  final String name;
  final String intro;
  final String avatar;
  final List<String> tags;

  const TutorCardWidget({
    required this.name,
    required this.intro,
    required this.avatar,
    required this.tags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(TutorDetailScreen.routeName);
        },
        child: Card(
          elevation: 4,
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
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: LetTutorFontSizes.px16,
                                  ),
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
                            SizedBox(
                              height: 35,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: tags.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: ChipTagWidget(tags[index]),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  intro,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: LetTutorFontSizes.px12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
