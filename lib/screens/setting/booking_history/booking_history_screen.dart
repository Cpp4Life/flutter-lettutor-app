import 'package:flutter/material.dart';

import '../../../widgets/index.dart';

class BookingHistoryScreen extends StatelessWidget {
  static const routeName = '/booking-history';

  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget('Booking History'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => const Card(
              elevation: 5,
              // child: BookingCardWidget(
              //     name: 'Dat Truong Gia',
              //     date: '2023-16-03',
              //     startTime: '08:30',
              //     endTime: '11:30'),
            ),
          ),
        ),
      ),
    );
  }
}
