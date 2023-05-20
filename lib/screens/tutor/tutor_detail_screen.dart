import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../constants/index.dart';
import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../helpers/index.dart';
import '../../models/index.dart' as model;
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class TutorDetailScreen extends StatefulWidget {
  static const routeName = '/tutor-detail';

  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  final EdgeInsetsGeometry _margin = const EdgeInsets.only(left: 20, right: 20, top: 10);
  final int _page = 1;
  final int _perPage = 12;
  model.Tutor _tutor = model.Tutor(id: '');
  final List<model.Feedback> _feedbacks = [];
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
      final provider = Provider.of<TutorProvider>(context, listen: false);
      final tutor = await provider.searchTutorByID(tutorId as String);
      final feedbacks = await provider.getTutorFeedbacks(
          page: _page, perPage: _perPage, tutorId: tutorId);
      setState(() {
        _tutor = tutor;
        _feedbacks.addAll(feedbacks);
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
    context.read<Analytics>().setTrackingScreen('TUTOR_DETAIL_SCREEN');
    final tutorProvider = Provider.of<TutorProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;

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
                                        _tutor.country ??
                                            countries[_tutor.user?.country] ??
                                            '',
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
                                  Consumer<TutorProvider>(
                                    builder: (context, provider, _) => IconButton(
                                      padding: const EdgeInsets.only(top: 5),
                                      constraints: const BoxConstraints(),
                                      onPressed: () async {
                                        try {
                                          await tutorProvider
                                              .toggleFavorite(_tutor.user!.id);
                                          setState(() {
                                            _tutor.isFavorite = !_tutor.isFavorite!;
                                          });
                                        } on model.HttpException catch (e) {
                                          TopSnackBar.showError(context, e.toString());
                                          await Analytics.crashEvent(
                                            'tutorDetailCatch',
                                            exception: e.toString(),
                                          );
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      icon: Icon(
                                        _tutor.isFavorite!
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: LetTutorColors.primaryRed,
                                      ),
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
                              BottomModalSheet.show(
                                context: context,
                                title: 'Choose the available schedule',
                                widget: ScheduleGridWidget(_tutor.user!.id),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              padding: const EdgeInsets.all(10),
                              backgroundColor: LetTutorColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              lang.bookingTutorButton,
                              style: const TextStyle(
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
                                    colorFilter: const ColorFilter.mode(
                                      LetTutorColors.primaryBlue,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Text(
                                    lang.message,
                                    style: const TextStyle(
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
                                    colorFilter: const ColorFilter.mode(
                                      LetTutorColors.primaryBlue,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Text(
                                    lang.report,
                                    style: const TextStyle(
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
                            title: lang.languages,
                            tags: languages.entries
                                .where((element) =>
                                    _tutor.languages!.split(',').contains(element.key))
                                .map((e) => e.value['name'] as String)
                                .toList(),
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: lang.education,
                            content: _tutor.education ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: lang.experience,
                            content: _tutor.experience ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: lang.interests,
                            content: _tutor.interests ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoTextWidget(
                            title: lang.profession,
                            content: _tutor.profession ?? '',
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoChipWidget(
                            title: lang.specialties,
                            tags: _tutor.specialties?.split(',') ?? [],
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: InfoCourseWidget(
                            title: lang.course,
                            courses: _tutor.user?.courses ?? [],
                          ),
                        ),
                        Container(
                          margin: _margin,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${lang.ratingAndComments} (${_feedbacks.length})',
                                style: const TextStyle(
                                  color: LetTutorColors.primaryBlue,
                                ),
                              ),
                              _feedbacks.isEmpty
                                  ? const FreeContentWidget('No Data')
                                  : ListView.builder(
                                      itemCount: _feedbacks.length,
                                      itemBuilder: (context, index) => RateCommentWidget(
                                        _feedbacks[index],
                                      ),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
