import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

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

abstract class IChatProvider {
  Stream<MessageSnapshot> getMessages();
  void pushMessage(Message message);
}

class RealChatProvider implements IChatProvider {
  String chatId;

  RealChatProvider() : chatId = '12345';

  @override
  Stream<MessageSnapshot> getMessages() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection(chatId)
        .orderBy('timestamp', descending: true)
        .limit(100)
        .snapshots()
        .asyncMap(
          (snapshot) => MessageSnapshot(
            chatId,
            DateTime.now(),
            snapshot.docs
                .map(
                  (m) => Message(
                    m.get('from') as String,
                    m.get('to') as String,
                    m.get('message') as String,
                    false,
                    const Duration(seconds: 0),
                    DateTime.fromMillisecondsSinceEpoch(
                      int.parse(m.get('timestamp').toString()),
                    ),
                  ),
                )
                .toList(),
          ),
        );
  }

  @override
  void pushMessage(Message message) {
    var documentReference = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'from': message.from,
          'to': message.to,
          'timestamp': message.timestamp.millisecondsSinceEpoch.toString(),
          'message': message.message,
        },
      );
    });
  }
}

class ChatProvider implements IChatProvider {
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

  @override
  Stream<MessageSnapshot> getMessages() async* {
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

  @override
  void pushMessage(Message message) {
    messages.add(message);
  }
}
