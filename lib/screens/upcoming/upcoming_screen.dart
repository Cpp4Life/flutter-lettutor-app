import 'package:flutter/material.dart';

import '../../core/styles/index.dart';
import '../../widgets/index.dart';

class UpcomingScreen extends StatelessWidget {
  static const routeName = '/upcoming';

  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  const BookingCardWidget(
                    name: 'Dat Truong Gia',
                    date: '2023-16-03',
                    startTime: '08:30',
                    endTime: '11:30',
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: LetTutorColors.greyScaleMediumGrey,
                              ),
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: LetTutorColors.secondaryDarkBlue,
                                fontSize: LetTutorFontSizes.px14,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: LetTutorColors.greyScaleMediumGrey,
                              ),
                              color: LetTutorColors.greyScaleMediumGrey,
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Go to meeting',
                              style: TextStyle(
                                color: Colors.white,
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
    );
  }
}
