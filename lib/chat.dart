import 'package:crowdbuy/calculator.dart';
import 'package:crowdbuy/pairing_provider.dart';
import 'package:flutter/material.dart';

import 'package:crowdbuy/chat_provider.dart';

class ChatPage extends StatefulWidget {
  final User user;
  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  Chat createState() => Chat();
}

class Chat extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ChatProvider chatProvider = ChatProvider();
  late final User user;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = widget.user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Column(
              children: <Widget>[
                Text(user.username),
                Text(
                  "Last seen 02:55 pm",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            leadingWidth: 72,
            leading: FittedBox(
              fit: BoxFit.cover,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.arrow_back),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: CircleAvatar(
                        child: Image.network(user.avatarUrl),
                      )),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.calculate_outlined),
                onPressed: launchCalculator,
              )
            ]),
        body: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              buildMessages(),
              buildInput(context),
            ],
          ),
        ]));
  }

  Widget buildInput(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: getAttachment,
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(textEditingController.text);
              },
              style: const TextStyle(fontSize: 15),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text),
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5)),
        color: Colors.white,
      ),
    );
  }

  Widget buildMessages() {
    return Flexible(
        child: StreamBuilder<MessageSnapshot>(
            stream: chatProvider.getMessages(),
            builder: (BuildContext context,
                AsyncSnapshot<MessageSnapshot> snapshot) {
              if (snapshot.hasData) {
                List<Message> messages = snapshot.data!.messages;
                if (messages.isNotEmpty) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: messages.length,
                      itemBuilder: (context, index) =>
                          buildItem(context, index, messages[index]));
                }
              }
              return const Center(
                  child: Text("Start chatting by sending msg!"));
            }));
  }

  Widget buildItem(BuildContext context, int index, Message message) {
    MainAxisAlignment axisAlignment;
    BoxDecoration chatBubble;
    TextStyle? chatTextStyle;
    if (message.from == "camsuen") {
      axisAlignment = MainAxisAlignment.end;
      chatBubble = BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      );
      chatTextStyle = Theme.of(context).primaryTextTheme.bodyMedium;
    } else {
      axisAlignment = MainAxisAlignment.start;
      chatBubble = BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(15),
      );
      chatTextStyle = Theme.of(context).textTheme.bodyMedium;
    }
    return Row(
      children: <Widget>[
        Container(
          child: Text(message.message, style: chatTextStyle),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: chatBubble,
          margin: const EdgeInsets.only(top: 10),
        )
      ],
      mainAxisAlignment: axisAlignment,
    );
  }

  void onSendMessage(String text) {
    chatProvider.pushMessage(
      Message(
        "camsuen",
        "to",
        text,
        false,
        const Duration(seconds: 0),
        DateTime.now(),
      ),
    );
    textEditingController.clear();
  }

  void getAttachment() {}

  void launchCalculator() {
    var router = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const Calculator(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );

    Navigator.of(context).push(router);
  }
}
