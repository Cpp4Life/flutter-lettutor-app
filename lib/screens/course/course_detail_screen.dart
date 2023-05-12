import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';

class CourseDetailScreen extends StatefulWidget {
  static const routeName = '/course-detail';

  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final Map<String, String> _levels = {
    '0': 'Any level',
    '1': 'Beginner',
    '2': 'High Beginner',
    '3': 'Pre-Intermediate',
    '4': 'Intermediate',
    '5': 'Upper-Intermediate',
    '6': 'Advanced',
    '7': 'Proficiency',
  };

  bool _isLoading = true;
  bool _isInit = true;
  Course _course = Course(id: '');

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchCourse();
    }
    super.didChangeDependencies();
  }

  void fetchCourse() async {
    final courseId = ModalRoute.of(context)?.settings.arguments;
    if (courseId != null) {
      final course =
          await Provider.of<CourseProvider>(context).findCourseById(courseId as String);
      setState(() {
        _isLoading = false;
        _course = course;
        _isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('COURSE_DETAIL_SCREEN');

    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final width = size.width - padding.left - padding.right;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: _course.imageUrl as String,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Image.network(
                          'https://picsum.photos/536/354',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.black26,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 170,
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.fromLTRB(15, 65, 15, 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "About Course",
                                      style: TextStyle(
                                        fontSize: LetTutorFontSizes.px26,
                                        fontWeight: LetTutorFontWeights.bold,
                                      ),
                                    ),
                                    Text(
                                      _course.description!,
                                      style: const TextStyle(
                                        fontSize: LetTutorFontSizes.px14,
                                        color: LetTutorColors.greyScaleDarkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: const Text(
                                        "Overview",
                                        style: TextStyle(
                                          fontSize: LetTutorFontSizes.px26,
                                          fontWeight: LetTutorFontWeights.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.help_outline),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, bottom: 10),
                                                child: const Text(
                                                  "Why take this course?",
                                                  style: TextStyle(
                                                    fontSize: LetTutorFontSizes.px16,
                                                    color:
                                                        LetTutorColors.secondaryDarkBlue,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            _course.reason!,
                                            style: const TextStyle(
                                              fontSize: LetTutorFontSizes.px14,
                                              color: LetTutorColors.greyScaleDarkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.help_outline),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10, bottom: 10),
                                                child: const Text(
                                                  "What will you be able to do?",
                                                  style: TextStyle(
                                                    fontSize: LetTutorFontSizes.px16,
                                                    color:
                                                        LetTutorColors.secondaryDarkBlue,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            _course.purpose!,
                                            style: const TextStyle(
                                              fontSize: LetTutorFontSizes.px14,
                                              color: LetTutorColors.greyScaleDarkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Level",
                                      style: TextStyle(
                                        fontSize: LetTutorFontSizes.px26,
                                        fontWeight: LetTutorFontWeights.bold,
                                      ),
                                    ),
                                    Text(
                                      _levels[_course.level]!,
                                      style: const TextStyle(
                                        fontSize: LetTutorFontSizes.px16,
                                        color: LetTutorColors.greyScaleDarkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 7),
                                      child: const Text(
                                        "Topic",
                                        style: TextStyle(
                                          fontSize: LetTutorFontSizes.px26,
                                          fontWeight: LetTutorFontWeights.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: ListView.builder(
                                        itemCount: _course.topics!.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (_, index) => GestureDetector(
                                          onTap: () => launchUrl(
                                            Uri.parse(_course.topics![index].nameFile!),
                                          ),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: LetTutorColors.greyScaleLightGrey,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    margin:
                                                        const EdgeInsets.only(right: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: Colors.indigo[200],
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: LetTutorFontSizes.px24,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      _course.topics![index].name!,
                                                      style: const TextStyle(
                                                        fontSize: LetTutorFontSizes.px16,
                                                        fontWeight:
                                                            LetTutorFontWeights.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 126,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: LetTutorColors.greyScaleDarkGrey,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    _course.topics!.length.toString(),
                                    style: const TextStyle(
                                      fontSize: LetTutorFontSizes.px24,
                                      fontWeight: FontWeight.bold,
                                      color: LetTutorColors.primaryBlue,
                                    ),
                                  ),
                                  const Text(
                                    "topics",
                                    style: TextStyle(
                                      fontSize: LetTutorFontSizes.px20,
                                      color: LetTutorColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    _course.users!.length.toString(),
                                    style: const TextStyle(
                                      fontSize: LetTutorFontSizes.px24,
                                      fontWeight: FontWeight.bold,
                                      color: LetTutorColors.secondaryDarkBlue,
                                    ),
                                  ),
                                  const Text(
                                    "tutor",
                                    style: TextStyle(
                                      fontSize: LetTutorFontSizes.px16,
                                      color: LetTutorColors.secondaryDarkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
