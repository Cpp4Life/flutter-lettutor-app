import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../widgets/index.dart';

class TutorsScreen extends StatefulWidget {
  static const routeName = '/tutors';

  const TutorsScreen({super.key});

  @override
  State<TutorsScreen> createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchResult = '';
  String _selectedSpecialty = '';
  final List<dynamic> _specialties = [];

  @override
  void initState() {
    _specialties.add(LearnTopic(id: 1, key: '', name: 'All'));
    Provider.of<LearnTopicProvider>(context, listen: false).fetchAndSetLearnTopics().then(
      (value) {
        setState(() {
          _specialties.addAll(value);
        });
      },
    );
    Provider.of<TestPreparationProvider>(context, listen: false).fetchAndSetTests().then(
      (value) {
        Timer(
          const Duration(seconds: 1),
          () => setState(() {
            _specialties.addAll(value);
          }),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void handleChange(String value) {
    setState(() {
      _searchResult = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SearchBarWidget(
            title: 'Search Tutors',
            controller: _searchCtrl,
            onChanged: handleChange,
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
        FutureBuilder(
          future: Provider.of<TutorProvider>(context, listen: false)
              .fetchAndSetTutorsWithFilters(
            page: 1,
            perPage: 12,
            specialties: [_selectedSpecialty],
            search: _searchResult,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.error != null) {
              return const FreeContentWidget('No available tutors');
            }
            return Consumer<TutorProvider>(
              builder: (context, tutorsData, child) => tutorsData.tutors.isEmpty
                  ? const FreeContentWidget('No available tutors')
                  : Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: ListView.builder(
                          itemCount: tutorsData.tutors.length,
                          itemBuilder: (context, index) {
                            return TutorCardWidget(
                              key: ValueKey(tutorsData.tutors[index].id),
                              id: tutorsData.tutors[index].userId as String,
                              name: tutorsData.tutors[index].name as String,
                              avatar: tutorsData.tutors[index].avatar,
                              bio: tutorsData.tutors[index].bio as String,
                              specialties: tutorsData.tutors[index].specialties
                                  ?.split(',') as List<String>,
                              rating: tutorsData.tutors[index].rating,
                            );
                          },
                          shrinkWrap: true,
                        ),
                      ),
                    ),
            );
          },
        )
      ],
    );
  }

  Widget _initSpecialtyChip(dynamic chip) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSpecialty = chip.key;
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
