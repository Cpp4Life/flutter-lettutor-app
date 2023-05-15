import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class TutorsScreen extends StatefulWidget {
  static const routeName = '/tutors';

  const TutorsScreen({super.key});

  @override
  State<TutorsScreen> createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<dynamic> _specialties = [];
  late List<Tutor> _tutors = [];
  final int _perPage = 12;
  int _page = 1;
  String _searchResult = '';
  String _selectedSpecialty = '';
  bool _isLoadMore = false;
  bool _isLoading = true;
  Timer? _debounce;

  @override
  void initState() {
    _scrollController.addListener(loadMore);
    _specialties.add(LearnTopic(id: 1, key: '', name: 'All'));
    fetchSpecialties();
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollController.removeListener(loadMore);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void handleSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchResult = value;
        _tutors = [];
        _page = 1;
        _isLoading = true;
      });
    });
  }

  void fetchSpecialties() async {
    try {
      final learnTopics = await Provider.of<LearnTopicProvider>(context, listen: false)
          .fetchAndSetLearnTopics();
      if (!mounted) return;
      final testPreps = await Provider.of<TestPreparationProvider>(context, listen: false)
          .fetchAndSetTests();

      if (mounted) {
        setState(() {
          _specialties.addAll(learnTopics);
          _specialties.addAll(testPreps);
        });
      }
    } on HttpException catch (error) {
      await Analytics.crashEvent(
        'fetchSpecialtiesHttpExceptionCatch',
        exception: error.toString(),
        fatal: true,
      );
    } catch (error) {
      await Analytics.crashEvent(
        'fetchSpecialtiesCatch',
        exception: error.toString(),
        fatal: true,
      );
    }
  }

  void fetchTutorsWithFilters() async {
    try {
      final tutorProvider = Provider.of<TutorProvider>(context, listen: false);
      await tutorProvider.fetchAndSetTutorsWithFilters(
        page: _page,
        perPage: _perPage,
        specialties: [_selectedSpecialty],
        search: _searchResult,
      );
      final response = tutorProvider.tutors;
      if (mounted) {
        setState(() {
          _tutors.addAll(response);
          _tutors = _tutors.toSet().toList(); // remove duplicates
          _isLoading = false;
          _isLoadMore = false;
        });
      }
    } on HttpException catch (error) {
      await Analytics.crashEvent(
        'fetchTutorsWithFiltersHttpExceptionCatch',
        exception: error.toString(),
        fatal: true,
      );
    } catch (error) {
      await Analytics.crashEvent(
        'fetchTutorsWithFiltersCatch',
        exception: error.toString(),
        fatal: true,
      );
    }
  }

  void loadMore() {
    if (_scrollController.position.extentAfter < _page * _perPage) {
      setState(() {
        _isLoadMore = true;
      });
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 100), () {
        _page++;
        fetchTutorsWithFilters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('TUTORS_SCREEN');
    final lang = Provider.of<AppProvider>(context).language;

    if (_isLoading) {
      fetchTutorsWithFilters();
    }

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SearchBarWidget(
            title: lang.tutorSearchHint,
            controller: _searchCtrl,
            onChanged: handleSearch,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SizedBox(
            height: 35,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: _specialties.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: _initSpecialtyChip(_specialties[index]),
                );
              },
            ),
          ),
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: _tutors.isEmpty
                      ? const FreeContentWidget('No available tutors')
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: _tutors.length,
                          itemBuilder: (context, index) {
                            return TutorCardWidget(
                              key: ValueKey(_tutors[index].id),
                              id: _tutors[index].userId as String,
                              name: _tutors[index].name as String,
                              avatar: _tutors[index].avatar,
                              bio: _tutors[index].bio as String,
                              specialties:
                                  _tutors[index].specialties?.split(',') as List<String>,
                              rating: _tutors[index].rating,
                            );
                          },
                          shrinkWrap: true,
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

  Widget _initSpecialtyChip(dynamic chip) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSpecialty = chip.key;
          _tutors = [];
          _page = 1;
          _isLoading = true;
        });
      },
      child: Chip(
        backgroundColor: _selectedSpecialty == chip.key
            ? LetTutorColors.softBlue
            : LetTutorColors.paleGrey,
        side: BorderSide(
          color: _selectedSpecialty == chip.key
              ? Colors.blue[100] as Color
              : Colors.grey[300] as Color,
        ),
        label: Text(
          chip.name,
          style: TextStyle(
            fontSize: LetTutorFontSizes.px12,
            color: _selectedSpecialty == chip.key
                ? LetTutorColors.primaryBlue
                : LetTutorColors.greyScaleDarkGrey,
          ),
        ),
      ),
    );
  }
}
