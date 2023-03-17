import 'package:flutter/material.dart';
import 'package:lettutor_app/widgets/session_history_card.dart';

import '../../../core/styles/styles.dart';
import '../../../widgets/index.dart';

class SessionHistoryScreen extends StatelessWidget {
  static const routeName = '/session-history';

  const SessionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget('Session History'),
      body: SafeArea(
        child: Column(
          children: [
            const SearchBarWidget('Search session history'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SessionHistoryCardWidget(
                              name: 'Dat Truong Gia',
                              date: '09:00, 03/17/2023',
                              duration: '00:12:38',
                              review: 'Not feedback yet',
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: LetTutorColors.primaryBlue,
                                        border: Border.all(
                                          color: LetTutorColors.primaryBlue,
                                        ),
                                        borderRadius: const BorderRadius.horizontal(
                                          left: Radius.circular(10),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Give Feedback',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: LetTutorFontSizes.px14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: LetTutorColors.primaryBlue,
                                        ),
                                        borderRadius: const BorderRadius.horizontal(
                                          right: Radius.circular(10),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'See Tutor Detail',
                                        style: TextStyle(
                                          color: LetTutorColors.primaryBlue,
                                          fontSize: LetTutorFontSizes.px14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
