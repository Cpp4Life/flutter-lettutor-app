import 'package:flutter/material.dart';

import '../../core/styles/index.dart';
import '../../screens/tutor/tutor_detail_screen.dart';
import '../index.dart';

class TutorCardWidget extends StatelessWidget {
  final String id;
  final String name;
  final String bio;
  final List<String> specialties;
  final String? avatar;
  final double? rating;

  const TutorCardWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.bio,
    required this.avatar,
    required this.specialties,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            TutorDetailScreen.routeName,
            arguments: id,
          );
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedImageNetworkWidget(avatar),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: LetTutorFontSizes.px16,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  rating == null ? '0' : rating!.round().toString(),
                                  style: const TextStyle(
                                    fontSize: LetTutorFontSizes.px16,
                                    color: LetTutorColors.primaryRed,
                                    fontWeight: LetTutorFontWeights.medium,
                                  ),
                                ),
                                const StarWidget(
                                  isFilled: true,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: specialties.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: ChipTagWidget(specialties[index]),
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
                  bio,
                  textAlign: TextAlign.left,
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
