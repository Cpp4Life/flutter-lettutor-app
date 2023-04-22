import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../index.dart';

class EbookTabWidget extends StatefulWidget {
  final List<CourseCategory> categories;
  final Map<String, String> levels;

  const EbookTabWidget(this.categories, this.levels, {super.key});

  @override
  State<EbookTabWidget> createState() => _EbookTabWidgetState();
}

class _EbookTabWidgetState extends State<EbookTabWidget> {
  String _selectedCategory = '';
  String _searchResult = '';
  final TextEditingController _ebookCtrl = TextEditingController();
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
    _ebookCtrl.dispose();
    super.dispose();
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
            onChanged: onChanged,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: CourseCategoryChipWidget(widget.categories, _selectedCategory, onSelect),
        ),
        FutureBuilder(
          future: Provider.of<EbookProvider>(context, listen: false).fetchAndSetEbooks(
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
            return Consumer<EbookProvider>(
              builder: (context, value, child) => value.ebooks.isEmpty
                  ? const FreeContentWidget('No available ebooks')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: value.ebooks.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: EbookItemWidget(
                            id: value.ebooks[index].id,
                            name: value.ebooks[index].name as String,
                            description: value.ebooks[index].description as String,
                            imageUrl: value.ebooks[index].imageUrl as String,
                            level: widget.levels[value.ebooks[index].level] as String,
                            fileUrl: value.ebooks[index].fileUrl as String,
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
