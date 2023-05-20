import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/foundation.dart';

import '../config/index.dart';
import 'index.dart';

class OpenAIService {
  final List<Map<String, String>> _history = [];

  final _openAI = OpenAI.instance.build(
    token: Config.token,
    baseOption: HttpSetup(
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  Future<String> getResponse(String message) async {
    final userInput = Map<String, String>.of(
      {
        'role': 'user',
        'content': message,
      },
    );
    _history.add(userInput);

    try {
      final request = ChatCompleteText(
        model: ChatModel.gptTurbo0301,
        messages: _history,
        maxToken: 1024,
      );

      final response = await _openAI.onChatCompletion(request: request);
      if (response == null) {
        return 'Oops! Something went wrong';
      }
      final content = response.choices.last.message?.content;
      final assistantInput = Map<String, String>.of(
        {
          'role': 'assistant',
          'content': content as String,
        },
      );
      _history.add(assistantInput);
      return content;
    } catch (error) {
      await Analytics.crashEvent(
        'getResponse',
        exception: error.toString(),
        fatal: true,
      );
      debugPrint(error.toString());
      return 'Oops! Something went wrong';
    }
  }
}
