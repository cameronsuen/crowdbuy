import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Request createState() => Request();
}

class Request extends State<RequestPage> {
  final TextEditingController subjectEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Ruquest"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: subjectEditingController,
              style: const TextStyle(
                fontSize: 20.0,
              ),
              decoration: const InputDecoration.collapsed(
                hintText: "Subject",
                hintStyle: TextStyle(fontSize: 20.0),
              ),
            ),
            Divider(thickness: 1, color: Theme.of(context).hintColor),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Remarks",
              ),
              maxLines: 10,
            ),
            Row(
              children: [
                ButtonTheme(
                  minWidth: 48,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: onAddPhoto,
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).hintColor,
                    ),
                    child: Column(children: const [
                      Icon(Icons.add_a_photo_outlined),
                      Text("Photo"),
                    ]),
                    //icon: const Icon(Icons.add_a_photo_outlined),
                    //onPressed: onAddPhoto, child: Column,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Theme.of(context).hintColor),
            const SizedBox(height: 16.0),
            const Text(
              "Discount refers to",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            Card(
              child: ListTile(
                leading: Column(
                  children: const <Widget>[
                    (CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent,
                      child: Text("TH"),
                    )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                title: const Text("ASport 40% off over \$500"),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: const TextSpan(
                        text: 'Nano Plaza (ASport) 150m',
                        //style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        text: "Post by ",
                        //style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "ASport Official",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("Post"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSendMessage(String text) {}

  void getAttachment() {}

  void onPressed() {}

  void onAddPhoto() {}
}
