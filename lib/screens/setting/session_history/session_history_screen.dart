import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/index.dart';
import '../../../services/index.dart';
import '../../../widgets/index.dart';
import '../../../widgets/session_history_card.dart';

class SessionHistoryScreen extends StatelessWidget {
  static const routeName = '/session-history';

  final int page = 1;
  final int perPage = 10;

  const SessionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('SESSION_HISTORY_SCREEN');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget('Session History'),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: const SearchBarWidget(
                title: 'Search session history',
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder(
                  future: Provider.of<ScheduleProvider>(context, listen: false)
                      .fetchAndSetSessionHistory(page: page, perPage: perPage),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.error != null) {
                      return const Center(
                        child: FreeContentWidget('No available sessions'),
                      );
                    }
                    return Consumer<ScheduleProvider>(
                      builder: (context, provider, _) => ListView.builder(
                        itemCount: provider.bookings.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SessionHistoryCardWidget(
                              booking: provider.bookings[index],
                            ),
                          );
                        },
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
