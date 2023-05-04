import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../index.dart';

class PeriodGridWidget extends StatefulWidget {
  final List<ScheduleDetails> details;

  const PeriodGridWidget(this.details, {super.key});

  @override
  State<PeriodGridWidget> createState() => _PeriodGridWidgetState();
}

class _PeriodGridWidgetState extends State<PeriodGridWidget> {
  @override
  void initState() {
    widget.details.sort(
      (d1, d2) => d1.startPeriodTimestamp!.compareTo(d2.startPeriodTimestamp!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      itemCount: widget.details.length,
      itemBuilder: (context, index) => PeriodItemWidget(
        id: widget.details[index].id,
        startPeriodTimestamp: widget.details[index].startPeriodTimestamp!,
        endPeriodTimestamp: widget.details[index].endPeriodTimestamp!,
        isBooked: widget.details[index].isBooked!,
        key: ValueKey(widget.details[index].id),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
