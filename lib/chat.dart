import 'package:flutter/material.dart';

import 'chat_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Chat createState() => Chat();
}

class Chat extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
          /*Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: getSticker,
                color: ColorConstants.primaryColor,
              ),
            ),
            color: Colors.white,
          ),*/

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

  void onSendMessage(String text) {}

  void getAttachment() {}
}
