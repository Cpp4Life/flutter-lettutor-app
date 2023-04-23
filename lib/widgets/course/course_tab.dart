import 'package:flutter/material.dart';
import 'package:lettutor_app/providers/course.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../index.dart';

class CourseTabWidget extends StatefulWidget {
  final List<CourseCategory> categories;
  final Map<String, String> levels;

  const CourseTabWidget(this.categories, this.levels, {super.key});

  @override
  State<CourseTabWidget> createState() => _CourseTabWidgetState();
}

class _CourseTabWidgetState extends State<CourseTabWidget> {
  String _selectedCategory = '';
  String _searchResult = '';
  final TextEditingController _courseCtrl = TextEditingController();
  final int _page = 1;
  final int _perPage = 10;

  void onSelect(String id) {
    _selectedCategory == id
        ? setState(() {
            _selectedCategory = '';
          })
        : setState(() {
            _selectedCategory = id;
          });
  }

  void onChanged(String value) {
    setState(() {
      _searchResult = value;
    });
  }

  @override
  void dispose() {
    _courseCtrl.dispose();
    super.dispose();
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
            onChanged: onChanged,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: CourseCategoryChipWidget(widget.categories, _selectedCategory, onSelect),
        ),
        FutureBuilder(
          future: Provider.of<CourseProvider>(context, listen: false).fetchAndSetCourses(
            page: _page,
            size: _perPage,
            q: _searchResult,
            categoryId: _selectedCategory,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.error != null) {
              return const FreeContentWidget('No available tutors');
            }
            return Consumer<CourseProvider>(
              builder: (context, value, child) => value.courses.isEmpty
                  ? const FreeContentWidget('No available courses')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: value.courses.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: CourseItemWidget(
                            id: value.courses[index].id,
                            imageUrl: value.courses[index].imageUrl as String,
                            name: value.courses[index].name as String,
                            level: widget.levels[value.courses[index].level] as String,
                            numberOfTopics: value.courses[index].topics?.length ?? 0,
                          ),
                        ),
                      ),
                    ),
            );
          },
        )
      ],
    );
  }
}
