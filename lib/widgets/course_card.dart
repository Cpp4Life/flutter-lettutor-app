import 'package:flutter/material.dart';

import '../core/styles/index.dart';
import '../models/course.dart';
import '../screens/index.dart';

class CourseCardWidget extends StatelessWidget {
  final Course course;

  const CourseCardWidget(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CourseScreen.routeName);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: SizedBox(
                  height: 150,
                  child: Image.asset(
                    course.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px16,
                        fontWeight: LetTutorFontWeights.semiBold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            course.level,
                            style: const TextStyle(
                              fontSize: LetTutorFontSizes.px12,
                              color: LetTutorColors.secondaryDarkBlue,
                            ),
                          ),
                          Text(
                            '${course.lessons} Lessons',
                            style: const TextStyle(
                              fontSize: LetTutorFontSizes.px12,
                              color: LetTutorColors.secondaryDarkBlue,
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
