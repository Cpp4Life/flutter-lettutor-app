import 'package:flutter/material.dart';

import '../core/styles/styles.dart';
import 'index.dart';

class InfoChipWidget extends StatelessWidget {
  final String title;
  final List<String> tags;

  const InfoChipWidget({
    required this.title,
    required this.tags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: LetTutorColors.primaryBlue,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 35,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: ChipTagWidget(tags[index]),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
