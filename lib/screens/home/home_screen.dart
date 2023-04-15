import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../providers/index.dart';
import '../../widgets/index.dart';
import '../index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: LetTutorColors.primaryBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Upcoming lesson',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: LetTutorFontSizes.px20,
                  ),
                ),
                const Text(
                  'Fri, 17 Mar 23 10:00 - 12:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: LetTutorFontSizes.px14,
                  ),
                ),
                const Text(
                  'Total lesson time is 11 hours 45 minutes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: LetTutorFontSizes.px14,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MeetingScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(color: LetTutorColors.primaryBlue),
                  ),
                  child: const Text(
                    'Enter lesson room',
                    style: TextStyle(
                      color: LetTutorColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.5, // Underline thickness
                          ),
                        ),
                      ),
                      child: const Text(
                        'Recommended Tutors',
                        style: TextStyle(
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        icon: SvgPicture.asset(
                          LetTutorSvg.next,
                          color: LetTutorColors.primaryBlue,
                        ),
                        label: const Text(
                          'See all',
                          style: TextStyle(
                            color: LetTutorColors.primaryBlue,
                            fontSize: LetTutorFontSizes.px14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: Provider.of<TutorProvider>(context, listen: false)
                    .fetchAndSetTutors(page: 1, perPage: 9),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.error != null) {
                    return const FreeContentWidget('No available tutors');
                  }
                  return Consumer<TutorProvider>(
                    builder: (context, tutorsData, child) => tutorsData.tutors.isEmpty
                        ? const FreeContentWidget('No available tutors')
                        : Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: ListView.builder(
                              itemCount: tutorsData.tutors.length,
                              itemBuilder: (context, index) {
                                return RecommendedTutorCardWidget(
                                  key: ValueKey(tutorsData.tutors[index].id),
                                  name: tutorsData.tutors[index].name as String,
                                  avatar: tutorsData.tutors[index].avatar,
                                  bio: tutorsData.tutors[index].bio as String,
                                  specialties: tutorsData.tutors[index].specialties
                                      ?.split(',') as List<String>,
                                  rating: tutorsData.tutors[index].rating,
                                );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
