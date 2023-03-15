import 'package:flutter/material.dart';

import '../../../core/assets/assets.dart';
import '../../../core/styles/styles.dart';
import '../../../widgets/index.dart';

class BookingHistoryScreen extends StatelessWidget {
  static const routeName = '/booking-history';

  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget('Booking History'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      LetTutorImages.banner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    'Dat Truong Gia',
                    style: TextStyle(
                      fontSize: LetTutorFontSizes.px14,
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      const Text(
                        '2023-16-03',
                        style: TextStyle(
                          fontSize: LetTutorFontSizes.px12,
                        ),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: LetTutorColors.primaryBlue,
                            width: 1,
                          ),
                          color: LetTutorColors.softBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '08:30',
                          style: TextStyle(
                            fontSize: LetTutorFontSizes.px10,
                            color: LetTutorColors.primaryBlue,
                          ),
                        ),
                      ),
                      const Text(
                        '-',
                        style: TextStyle(
                          color: LetTutorColors.secondaryDarkBlue,
                        ),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 1,
                          ),
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '10:30',
                          style: TextStyle(
                            fontSize: LetTutorFontSizes.px10,
                            color: Colors.orange,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
