import 'package:flutter/material.dart';

import '../core/styles/index.dart';
import '../models/course.dart';
import 'index.dart';

class InfoCourseWidget extends StatelessWidget {
  final String title;
  final List<Course> courses;

  const InfoCourseWidget({
    required this.title,
    required this.courses,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: LetTutorColors.primaryBlue,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 250,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CourseCardWidget(courses[index]),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
