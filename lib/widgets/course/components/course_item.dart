import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/index.dart';
import '../../../core/styles/index.dart';
import '../../../screens/index.dart';

class CourseItemWidget extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String level;
  final int numberOfTopics;

  const CourseItemWidget({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.level,
    required this.numberOfTopics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          CourseDetailScreen.routeName,
          arguments: id,
        );
      },
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: SizedBox(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                  LetTutorImages.course,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px16,
                        fontWeight: LetTutorFontWeights.medium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            level,
                            style: const TextStyle(
                              fontSize: LetTutorFontSizes.px14,
                              color: LetTutorColors.greyScaleDarkGrey,
                            ),
                          ),
                          Text(
                            '${numberOfTopics.toString()} Lessons',
                            style: const TextStyle(
                              fontSize: LetTutorFontSizes.px14,
                              color: LetTutorColors.greyScaleDarkGrey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
