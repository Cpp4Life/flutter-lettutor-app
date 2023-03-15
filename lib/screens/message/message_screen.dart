import 'package:flutter/material.dart';

import '../../core/assets/assets.dart';
import '../../core/styles/styles.dart';
import '../../widgets/index.dart';

class MessageScreen extends StatelessWidget {
  final int _messages = 5;

  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarWidget('Search Message'),
        _messages == 0
            ? const FreeContentWidget('No recent chat')
            : Expanded(
                child: ListView.builder(
                  itemCount: _messages,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MediaQuery(
                      data: const MediaQueryData(padding: EdgeInsets.zero),
                      child: ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            LetTutorImages.avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Text(
                          'Hello world',
                          style: TextStyle(fontSize: LetTutorFontSizes.px14),
                        ),
                        subtitle: const Text(
                          'learning flutter',
                          style: TextStyle(
                            fontSize: LetTutorFontSizes.px12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
