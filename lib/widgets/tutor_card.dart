import 'package:flutter/material.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';
import 'rating.dart';

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
        onTap: () {},
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: LetTutorFontSizes.px16,
                                  ),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.only(top: 5, right: 5),
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                  splashColor: Colors.transparent,
                                  icon: const Icon(
                                    Icons.favorite_border_outlined,
                                    color: LetTutorColors.primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: const RatingWidget(),
                            ),
                            SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: tags.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Chip(
                                      backgroundColor: LetTutorColors.softBlue,
                                      side: const BorderSide(
                                        color: LetTutorColors.primaryBlue,
                                      ),
                                      label: Text(
                                        tags[index],
                                        style: const TextStyle(
                                          fontSize: LetTutorFontSizes.px12,
                                          color: LetTutorColors.primaryBlue,
                                        ),
                                      ),
                                    ),
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
  }
}
