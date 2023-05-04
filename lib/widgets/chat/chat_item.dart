import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../models/index.dart';
import '../../providers/index.dart';

class ChatItemWidget extends StatefulWidget {
  final ChatModel chat;

  const ChatItemWidget({
    required this.chat,
    super.key,
  });

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  late ChatProvider _chatPvd;

  @override
  void initState() {
    _chatPvd = Provider.of<ChatProvider>(context, listen: false);
    super.initState();
  }

  void readMessage(String id) {
    _chatPvd.readMessage(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment:
            widget.chat.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !widget.chat.isUser
              ? Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      LetTutorSvg.chatgpt,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                decoration: BoxDecoration(
                  color: widget.chat.isUser
                      ? LetTutorColors.primaryBlue
                      : LetTutorColors.secondaryDarkBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: Radius.circular(widget.chat.isUser ? 15 : 0),
                    bottomRight: Radius.circular(widget.chat.isUser ? 0 : 15),
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: LetTutorFontSizes.px14,
                    fontWeight: LetTutorFontWeights.medium,
                    color: Colors.white,
                  ),
                  child: widget.chat.isUser || widget.chat.isRead!
                      ? Text(widget.chat.message)
                      : AnimatedTextKit(
                          isRepeatingAnimation: false,
                          repeatForever: false,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(widget.chat.message),
                          ],
                          onTap: () => readMessage(widget.chat.id),
                          onFinished: () => readMessage(widget.chat.id),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
