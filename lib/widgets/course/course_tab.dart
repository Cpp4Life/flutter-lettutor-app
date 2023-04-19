import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../index.dart';

class CourseTabWidget extends StatefulWidget {
  final List<CourseCategory> categories;

  const CourseTabWidget(this.categories, {super.key});

  @override
  State<CourseTabWidget> createState() => _CourseTabWidgetState();
}

class _CourseTabWidgetState extends State<CourseTabWidget> {
  String _selectedCategory = '';
  final TextEditingController _courseCtrl = TextEditingController();

  void onSelect(String id) {
    _selectedCategory == id
        ? setState(() {
            _selectedCategory = '';
          })
        : setState(() {
            _selectedCategory = id;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: SearchBarWidget(
            title: 'Search course',
            controller: _courseCtrl,
          ),
        ),
        CourseCategoryChipWidget(widget.categories, _selectedCategory, onSelect)
      ],
    );
  }
}
