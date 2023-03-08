import 'package:flutter/material.dart';

import '../core/assets/assets.dart';
import '../core/styles/styles.dart';
import '../widgets/nav_item.dart';
import 'home/home_screen.dart';

class LetTutorTabsScreen extends StatefulWidget {
  static const routeName = '/home';

  const LetTutorTabsScreen({super.key});

  @override
  State<LetTutorTabsScreen> createState() => _LetTutorTabsScreenState();
}

class _LetTutorTabsScreenState extends State<LetTutorTabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': const LetTutorHomeScreen(), 'title': 'Home'},
      {'page': const Center(child: Text('Message')), 'title': 'Message'},
      {'page': const Center(child: Text('Upcoming')), 'title': 'Upcoming'},
      {'page': const Center(child: Text('Tutors')), 'title': 'Tutors'},
      {'page': const Center(child: Text('Settings')), 'title': 'Settings'},
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
                  onPressed: () {},
                  icon: Image.asset(LetTutorImages.avatar),
                ),
              ]
            : [],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: _pages[_selectedPageIndex]['page'] as Widget,
      ),
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
            svgSource: LetTutorSvg.message,
            label: 'Message',
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
