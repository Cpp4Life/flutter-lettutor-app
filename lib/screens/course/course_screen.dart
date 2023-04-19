import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_app/widgets/index.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';

class CourseScreen extends StatefulWidget {
  static const routeName = '/course';

  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final List<CourseCategory> _categories = [];

  @override
  void initState() {
    Provider.of<CourseProvider>(context, listen: false)
        .fetchAndSetCourseCategory()
        .then((value) {
      setState(() {
        _categories.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TabBar(
              tabs: [
                _initTab(tabName: 'Course', icon: LetTutorSvg.course),
                _initTab(tabName: 'Ebook', icon: LetTutorSvg.ebook),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CourseTabWidget(_categories),
                  EbookTabWidget(_categories),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _initTab({required String tabName, required String icon}) {
    return Tab(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: LetTutorColors.greyScaleDarkGrey,
            ),
          ),
          Text(
            tabName,
            style: const TextStyle(
              color: LetTutorColors.greyScaleDarkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
