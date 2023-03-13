import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/assets/assets.dart';
import '../../core/styles/styles.dart';
import '../../models/course.dart';
import '../../widgets/index.dart';

class TutorDetailScreen extends StatelessWidget {
  static const routeName = '/tutor-detail';

  const TutorDetailScreen({super.key});

  final EdgeInsetsGeometry _margin = const EdgeInsets.only(left: 20, right: 20, top: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              expandedHeight: 175,
              pinned: true,
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 16,
              ),
              titleSpacing: -10,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://fastly.picsum.photos/id/795/536/354.jpg?hmac=RRoarvJYI4QeP2PEwjTqTgzyFgT53Lo9Pq-IFSiqv4k',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Image.asset(
                            LetTutorImages.avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Abby',
                                  style: TextStyle(
                                    fontSize: LetTutorFontSizes.px14,
                                    fontWeight: LetTutorFontWeights.medium,
                                  ),
                                ),
                                Text(
                                  'Teacher',
                                  style: TextStyle(
                                    fontSize: LetTutorFontSizes.px12,
                                    color: LetTutorColors.greyScaleDarkGrey,
                                  ),
                                ),
                                Text(
                                  'Phillipines (the)',
                                  style: TextStyle(
                                    fontSize: LetTutorFontSizes.px14,
                                    fontWeight: LetTutorFontWeights.light,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const RatingWidget(),
                            IconButton(
                              padding: const EdgeInsets.only(top: 5),
                              constraints: const BoxConstraints(),
                              onPressed: () {},
                              splashColor: Colors.transparent,
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: LetTutorColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Booking',
                        style: TextStyle(
                          fontWeight: LetTutorFontWeights.medium,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              LetTutorSvg.startMessaging,
                              fit: BoxFit.cover,
                              color: LetTutorColors.primaryBlue,
                            ),
                            const Text(
                              'Message',
                              style: TextStyle(
                                fontSize: LetTutorFontSizes.px12,
                                color: LetTutorColors.primaryBlue,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              LetTutorSvg.report,
                              fit: BoxFit.cover,
                              color: LetTutorColors.primaryBlue,
                            ),
                            const Text(
                              'Report',
                              style: TextStyle(
                                fontSize: LetTutorFontSizes.px12,
                                color: LetTutorColors.primaryBlue,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: TextStyle(fontSize: LetTutorFontSizes.px12),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoChipWidget(
                      title: 'Languages',
                      tags: ['english'],
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoTextWidget(
                      title: 'Education',
                      content:
                          'Bachelor of Elementary education at Stratford International School.',
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoTextWidget(
                      title: 'Experience',
                      content:
                          'I have 3 years teaching experience both kids and adult as a classroom teacher and as em ESL Teacher in Vietnam in public schools and centers.',
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoTextWidget(
                      title: 'Interests',
                      content:
                          'traveling, reading, watching movies, learn foreign language.',
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoTextWidget(
                      title: 'Profession',
                      content: 'Teacher.',
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoChipWidget(
                      title: 'Languages',
                      tags: ['English for kids', 'STARTERS', 'MOVERS', 'Conversational'],
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const InfoCourseWidget(
                      title: 'Course',
                      courses: [
                        Course(
                          name: 'Basic conversation topics',
                          imageUrl: LetTutorImages.banner,
                          level: 'Beginner',
                          lessons: 10,
                        ),
                        Course(
                          name: 'Class - Elementary 2',
                          imageUrl: LetTutorImages.course,
                          level: 'Beginner',
                          lessons: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: _margin,
                    child: const Text(
                      'Rating and Comment (0)',
                      style: TextStyle(
                        color: LetTutorColors.primaryBlue,
                      ),
                    ),
                  ),
                  const FreeContentWidget('No data')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}