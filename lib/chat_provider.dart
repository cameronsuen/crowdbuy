class Message {
  String from;
  String to;
  String message;
  DateTime timestamp;
  bool isMock;
  Duration delay;
  Message(this.from, this.to, this.message, this.isMock, this.delay,
      [DateTime? timestamp])
      : timestamp = timestamp ?? DateTime.now();
}

class MessageSnapshot {
  String chatId;
  DateTime timestamp;
  List<Message> messages;
  MessageSnapshot(this.chatId, this.timestamp, [this.messages = const []]);
}

class ChatProvider {
  final String chatId;
  late List<Message> messages;
  ChatProvider() : chatId = "12345678" {
    messages = [
      Message(
        "sto",
        "camsuen",
        "Hello, I'll buy a \$300 shirt",
        true,
        const Duration(seconds: 1),
      ),
      Message(
        "camsuen",
        "sto",
        "Sure, let's wait at ASport at 2/F?",
        true,
        const Duration(seconds: 3),
      ),
      Message(
        "sto",
        "camsuen",
        "Sure, see you!",
        true,
        const Duration(seconds: 2),
      ),
    ];
  }

  Stream<MessageSnapshot> getMessages() async* {
    /*int i = 0;
    while (i < messages.length) {
      ++i;
      if (messages.last.isMock) {
        await Future.delayed(messages.last.delay);
      }
      yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, i + 1));
    }*/
    await Future.delayed(const Duration(seconds: 1));
    yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, 1));
    await Future.delayed(const Duration(seconds: 3));
    yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, 2));
    await Future.delayed(const Duration(seconds: 2));
    yield MessageSnapshot(chatId, DateTime.now(), messages.sublist(0, 3));

    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield MessageSnapshot(chatId, DateTime.now(), messages);
    }
  }

  void pushMessage(Message message) {
    messages.add(message);
  }
}
