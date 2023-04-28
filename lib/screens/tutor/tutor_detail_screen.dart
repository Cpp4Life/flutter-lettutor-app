import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../widgets/index.dart';

class TutorDetailScreen extends StatefulWidget {
  static const routeName = '/tutor-detail';

  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  final EdgeInsetsGeometry _margin = const EdgeInsets.only(left: 20, right: 20, top: 10);
  Tutor _tutor = Tutor(id: '');
  ChewieController? _chewieController;
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchTutor();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void fetchTutor() async {
    final tutorId = ModalRoute.of(context)?.settings.arguments;
    if (tutorId != null) {
      Provider.of<TutorProvider>(context, listen: false)
          .searchTutorByID(tutorId as String)
          .then((tutor) {
        setState(() {
          _tutor = tutor;
          _chewieController = ChewieController(
            videoPlayerController: VideoPlayerController.network(_tutor.video as String),
            autoPlay: true,
            looping: false,
            deviceOrientationsOnEnterFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.portraitUp,
            ],
          );
        });
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _chewieController!.pause();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
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
                      background: _chewieController == null
                          ? Container()
                          : Chewie(
                              controller: _chewieController!,
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
                              CachedImageNetworkWidget(_tutor.user?.avatar),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _tutor.user?.name ?? '',
                                        style: const TextStyle(
                                          fontSize: LetTutorFontSizes.px14,
                                          fontWeight: LetTutorFontWeights.medium,
                                        ),
                                      ),
                                      Text(
                                        _tutor.profession ?? '',
                                        style: const TextStyle(
                                          fontSize: LetTutorFontSizes.px12,
                                          color: LetTutorColors.greyScaleDarkGrey,
                                        ),
                                      ),
                                      Text(
                                        _tutor.country ?? _tutor.user?.country ?? '',
                                        style: const TextStyle(
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
                                  RatingWidget(
                                    count: _tutor.rating == null
                                        ? 0
                                        : _tutor.rating!.round(),
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.only(top: 5),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {},
                                    splashColor: Colors.transparent,
                                    icon: const Icon(
                                      Icons.favorite_border_outlined,
                                      color: LetTutorColors.primaryRed,
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
                            onPressed: () {
                              _showTutorSchedules(_tutor.user?.id as String);
                            },
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
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
                          child: Text(
                            _tutor.bio ?? '',
                            style: const TextStyle(fontSize: LetTutorFontSizes.px12),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoChipWidget(
                            title: 'Languages',
                            tags: _tutor.languages?.split(',') ?? [],
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: 'Education',
                            content: _tutor.education ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: 'Experience',
                            content: _tutor.experience ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: 'Interests',
                            content: _tutor.interests ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: 'Profession',
                            content: _tutor.profession ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoChipWidget(
                            title: 'Specialties',
                            tags: _tutor.specialties?.split(',') ?? [],
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoCourseWidget(
                            title: 'Course',
                            courses: _tutor.user?.courses ?? [],
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
                        const FreeContentWidget('No Data')
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Future<void> _showTutorSchedules(String tutorId) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return SafeArea(
          right: false,
          left: false,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: LetTutorColors.paleGrey,
                      ),
                      child: const Text(
                        'Choose the available schedule',
                        style: TextStyle(
                          fontSize: LetTutorFontSizes.px14,
                          fontWeight: LetTutorFontWeights.medium,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScheduleGridWidget(tutorId),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
