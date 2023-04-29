import 'package:flutter/material.dart';

import '../models/index.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatModel> _messages = [];

  List<ChatModel> get messages {
    return [..._messages];
  }

  List<ChatModel> get reversedMessage {
    return [..._messages.reversed.toList()];
  }

  void addMessage(ChatModel cm) {
    _messages.add(cm);
    notifyListeners();
  }

  void readMessage(String id) {
    final idx = _messages.indexWhere((element) => element.id == id);
    _messages[idx].isRead = true;
  }
}
