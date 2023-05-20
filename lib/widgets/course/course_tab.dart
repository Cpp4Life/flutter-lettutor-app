import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../index.dart';

class CourseTabWidget extends StatefulWidget {
  final List<CourseCategory> categories;
  final Map<String, String> levels;
  final Language lang;

  const CourseTabWidget(this.categories, this.levels, this.lang, {super.key});

  @override
  State<CourseTabWidget> createState() => _CourseTabWidgetState();
}

class _CourseTabWidgetState extends State<CourseTabWidget> {
  final TextEditingController _courseCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final int _perPage = 10;
  int _page = 1;
  String _selectedCategory = '';
  String _searchResult = '';
  List<Course> _courses = [];
  bool _isLoadMore = false;
  bool _isLoading = true;
  Timer? _debounce;

  @override
  void initState() {
    _scrollController.addListener(loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _courseCtrl.dispose();
    _scrollController.removeListener(loadMore);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void onSelect(String id) {
    setState(() {
      _selectedCategory = (_selectedCategory == id ? '' : id);
      _isLoading = true;
      _page = 1;
      _courses = [];
    });
  }

  void handleSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchResult = value;
        _page = 1;
        _isLoading = true;
        _courses = [];
      });
    });
  }

  void loadMore() {
    if (_scrollController.position.extentAfter < _page * _perPage) {
      setState(() {
        _isLoadMore = true;
      });
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 100), () {
        _page++;
        fetchCourses();
      });
    }
  }

  void fetchCourses() async {
    try {
      final courseProvider = Provider.of<CourseProvider>(context, listen: false);
      await courseProvider.fetchAndSetCoursesWithPagination(
        page: _page,
        size: _perPage,
        q: _searchResult,
        categoryId: _selectedCategory,
      );

      final courseResult = courseProvider.courses;
      if (mounted) {
        setState(() {
          _courses.addAll(courseResult);
          _courses = _courses.toSet().toList(); // remove duplicates
          _isLoadMore = false;
          _isLoading = false;
        });
      }
    } on HttpException catch (error) {
      await Analytics.crashEvent(
        'fetchCoursesHttpExceptionCatch',
        exception: error.toString(),
        fatal: true,
      );
    } catch (error) {
      await Analytics.crashEvent(
        'fetchCoursesCatch',
        exception: error.toString(),
        fatal: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) fetchCourses();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: SearchBarWidget(
            title: widget.lang.courseSearchHint,
            controller: _courseCtrl,
            onChanged: handleSearch,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: CourseCategoryChipWidget(widget.categories, _selectedCategory, onSelect),
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: _courses.isEmpty
                    ? const FreeContentWidget('No available courses')
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _courses.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: CourseItemWidget(
                            id: _courses[index].id,
                            imageUrl: _courses[index].imageUrl as String,
                            name: _courses[index].name as String,
                            level: widget.levels[_courses[index].level] as String,
                            numberOfTopics: _courses[index].topics?.length ?? 0,
                          ),
                        ),
                      ),
              ),
        if (_isLoadMore)
          const SizedBox(
            height: 48,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
