import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/index.dart';
import '../index.dart';

class ScheduleGridWidget extends StatelessWidget {
  final String tutorId;

  const ScheduleGridWidget(this.tutorId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ScheduleProvider>(context, listen: false)
          .fetchAndSetSchedules(tutorId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.error != null) {
          return const Center(
            child: FreeContentWidget('No available schedules'),
          );
        }
        return Consumer<ScheduleProvider>(
          builder: (context, provider, _) => GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            itemCount: provider.schedules.length,
            itemBuilder: (context, index) => ScheduleItemWidget(
              provider.schedules[index].startTimestamp!,
              provider.schedules[index].scheduleDetails!,
              ValueKey(provider.schedules[index].id),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        );
      },
    );
  }
}
