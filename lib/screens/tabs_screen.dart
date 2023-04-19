import 'package:flutter/material.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/home';

  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': const HomeScreen(), 'title': 'Home'},
      {'page': const CourseScreen(), 'title': 'Course'},
      {'page': const UpcomingScreen(), 'title': 'Upcoming'},
      {'page': const TutorsScreen(), 'title': 'Tutors'},
      {'page': const SettingScreen(), 'title': 'Settings'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: const TextStyle(
            color: LetTutorColors.secondaryDarkBlue,
            fontSize: LetTutorFontSizes.px16,
            fontWeight: LetTutorFontWeights.semiBold,
          ),
        ),
        actions: _selectedPageIndex == 0
            ? [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Image.asset(
                    LetTutorImages.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ]
            : [],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(child: _pages[_selectedPageIndex]['page'] as Widget),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: LetTutorColors.primaryBlue,
        unselectedItemColor: LetTutorColors.greyScaleDarkGrey,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: LetTutorFontSizes.px12,
        items: [
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.home,
            label: 'Home',
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.course,
            label: 'Course',
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.upcoming,
            label: 'Upcoming',
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.tutor,
            label: 'Tutors',
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.settingNav,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
