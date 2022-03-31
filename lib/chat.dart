import 'package:flutter/material.dart';

import 'chat_provider.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              buildMessages(),
            ],
          ),
        ]));
  }

  Widget buildMessages() {
    return Flexible(
        child: StreamBuilder<MessageSnapshot>(
            stream: ChatProvider.getMessages(),
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
}
