class ChatModel {
  final String id;
  final String message;
  final bool isUser;
  bool? isRead;

  ChatModel({
    required this.id,
    required this.message,
    required this.isUser,
    this.isRead,
  });
}
