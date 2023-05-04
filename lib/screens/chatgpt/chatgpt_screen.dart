import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class ChatGPTScreen extends StatelessWidget {
  static const routeName = '/chatgpt';

  const ChatGPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('CHATGPT_SCREEN');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: provider.messages.length,
                  itemBuilder: (context, index) => ChatItemWidget(
                    chat: provider.reversedMessage[index],
                  ),
                ),
              ),
              const MessageInputWidget(),
            ],
          );
        },
      ),
    );
  }
}
