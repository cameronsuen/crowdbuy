class Message {
  String from;
  String to;
  String message;
  DateTime timestamp;
  Message(this.from, this.to, this.message, [DateTime? timestamp])
      : timestamp = timestamp ?? DateTime.now();
}

class MessageSnapshot {
  String chatId;
  DateTime timestamp;
  List<Message> messages;
  MessageSnapshot(this.chatId, this.timestamp, [this.messages = const []]);
}

class ChatProvider {
  static String chatId = "12345678";
  static List<Message> messages = [
    Message("sto", "camsuen", "Hello, I'll buy a \$300 shirt"),
    Message("camsuen", "sto", "Sure, let's wait at ASport at 2/F?"),
    Message("sto", "camsuen", "Sure, see you!"),
  ];
  static Stream<MessageSnapshot> getMessages() async* {
    await Future.delayed(const Duration(seconds: 1));
    yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, 1));
    await Future.delayed(const Duration(seconds: 3));
    yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, 2));
    await Future.delayed(const Duration(seconds: 2));
    yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, 3));
  }
}
