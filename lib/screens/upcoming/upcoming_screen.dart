import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class UpcomingScreen extends StatefulWidget {
  static const routeName = '/upcoming';

  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final int _perPage = 10;
  final int _page = 1;

  Future _refreshUpcoming(BuildContext context) async {
    await Provider.of<ScheduleProvider>(context, listen: false)
        .fetchAndSetUpcomingClass(page: _page, perPage: _perPage);
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('UPCOMING_SCREEN');
    return FutureBuilder(
      future: _refreshUpcoming(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.error != null) {
          return const Center(
            child: FreeContentWidget('No available upcoming class'),
          );
        }
        return RefreshIndicator(
          onRefresh: () => _refreshUpcoming(context),
          child: Consumer<ScheduleProvider>(
            builder: (context, provider, _) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: provider.bookings.isEmpty
                  ? const Center(
                      child: FreeContentWidget('No available bookings'),
                    )
                  : ListView.builder(
                      itemCount: provider.bookings.length,
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
                            child: BookingCardWidget(
                              booking: provider.bookings[index],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
