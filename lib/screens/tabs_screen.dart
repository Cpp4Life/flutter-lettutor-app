import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/assets/index.dart';
import '../core/styles/index.dart';
import '../helpers/index.dart';
import '../providers/index.dart';
import 'index.dart';

class TabsScreen extends StatelessWidget {
  static const routeName = '/home';

  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user;
    final provider = Provider.of<NavigationProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;

    final pages = [
      {'page': const HomeScreen(), 'title': lang.homeTitle},
      {'page': const CourseScreen(), 'title': lang.courseTitle},
      {'page': const UpcomingScreen(), 'title': lang.upcomingTitle},
      {'page': const TutorsScreen(), 'title': lang.tutorList},
      {'page': const ChatGPTScreen(), 'title': lang.chatGPTTitle},
      {'page': const SettingScreen(), 'title': lang.settingsTitle},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          pages[provider.index]['title'] as String,
          style: const TextStyle(
            color: LetTutorColors.secondaryDarkBlue,
            fontSize: LetTutorFontSizes.px16,
            fontWeight: LetTutorFontWeights.semiBold,
          ),
        ),
        actions: provider.index == 0
            ? [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                  icon: CachedNetworkImage(
                    imageUrl: user.avatar ?? 'https://picsum.photos/200/300',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Image.asset(
                      LetTutorImages.avatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ]
            : [],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(child: pages[provider.index]['page'] as Widget),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => provider.moveToTab(value),
        selectedItemColor: LetTutorColors.primaryBlue,
        unselectedItemColor: LetTutorColors.greyScaleDarkGrey,
        currentIndex: provider.index,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: LetTutorFontSizes.px12,
        items: [
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.home,
            label: lang.homeTitle,
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.course,
            label: lang.courseTitle,
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.upcoming,
            label: lang.upcomingTitle,
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.tutor,
            label: lang.tutorTitle,
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.chatgpt,
            label: lang.chatGPTTitle,
          ),
          NavItem.generateItem(
            context,
            svgSource: LetTutorSvg.settingNav,
            label: lang.settingsTitle,
          ),
        ],
      ),
    );
  }
}
