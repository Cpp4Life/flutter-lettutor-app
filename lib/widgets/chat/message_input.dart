import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';

class MessageInputWidget extends StatefulWidget {
  const MessageInputWidget({super.key});

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final _msgController = TextEditingController();
  final OpenAIService _service = OpenAIService();
  late ChatProvider _chatPvd;
  bool _isReplying = false;

  @override
  void initState() {
    _chatPvd = Provider.of<ChatProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void sendTextMessage(String msg) async {
    if (msg.isEmpty) return;

    setReplyingState(true);
    addToChatList(msg: msg, isUser: true, isRead: true);
    final response = await _service.getResponse(msg);
    addToChatList(msg: response, isUser: false, isRead: false);
    setReplyingState(false);
  }

  void setReplyingState(bool isRelying) {
    if (mounted) {
      setState(() {
        _isReplying = isRelying;
      });
    }
  }

  void addToChatList({required String msg, required bool isUser, required bool isRead}) {
    _chatPvd.addMessage(
      ChatModel(
        id: const Uuid().v4(),
        message: msg,
        isUser: isUser,
        isRead: isRead,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          if (_isReplying)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: JumpingDots(
                color: LetTutorColors.secondaryDarkBlue,
                radius: 10,
                numberOfDots: 3,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _msgController,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Type a message...',
                    hintStyle: const TextStyle(
                      color: LetTutorColors.greyScaleDarkGrey,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: LetTutorColors.primaryBlue,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  style: const TextStyle(fontSize: LetTutorFontSizes.px14),
                ),
              ),
              ElevatedButton(
                onPressed: _isReplying
                    ? () {}
                    : () {
                        final msg = _msgController.text;
                        sendTextMessage(msg);
                        _msgController.clear();
                      },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                ),
                child: const Icon(
                  Icons.send,
                  size: 28,
                  color: LetTutorColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
