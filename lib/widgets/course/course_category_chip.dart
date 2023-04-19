import 'package:flutter/material.dart';

import '../../core/styles/index.dart';
import '../../models/index.dart';

class CourseCategoryChipWidget extends StatelessWidget {
  final List<CourseCategory> categories;
  final String selectedCategory;
  final Function onSelect;

  const CourseCategoryChipWidget(
    this.categories,
    this.selectedCategory,
    this.onSelect, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: () {
                  onSelect(categories[index].id);
                },
                child: Chip(
                  backgroundColor: selectedCategory == categories[index].id
                      ? LetTutorColors.softBlue
                      : LetTutorColors.paleGrey,
                  side: BorderSide(
                    color: selectedCategory == categories[index].id
                        ? Colors.blue[100] as Color
                        : Colors.grey[300] as Color,
                  ),
                  label: Text(
                    categories[index].title as String,
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px12,
                      color: selectedCategory == categories[index].id
                          ? LetTutorColors.primaryBlue
                          : LetTutorColors.greyScaleDarkGrey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
