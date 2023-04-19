import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../index.dart';

class EbookTabWidget extends StatefulWidget {
  final List<CourseCategory> categories;

  const EbookTabWidget(this.categories, {super.key});

  @override
  State<EbookTabWidget> createState() => _EbookTabWidgetState();
}

class _EbookTabWidgetState extends State<EbookTabWidget> {
  final TextEditingController _ebookCtrl = TextEditingController();
  String _selectedCategory = '';

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
            title: 'Search ebook',
            controller: _ebookCtrl,
          ),
        ),
        CourseCategoryChipWidget(widget.categories, _selectedCategory, onSelect)
      ],
    );
  }
}
