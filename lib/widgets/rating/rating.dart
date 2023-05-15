import 'package:flutter/material.dart';

import '../index.dart';

class RatingWidget extends StatelessWidget {
  final int count;

  const RatingWidget({required this.count, Key? key}) : super(key: key);

  List<Widget> _buildStars() {
    final stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      i < count
          ? stars.add(const StarWidget(isFilled: true))
          : stars.add(const StarWidget(isFilled: false));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildStars(),
    );
  }
}
