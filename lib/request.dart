import 'package:crowdbuy/pairing_provider.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  final Pairing pairing;
  const RequestPage({Key? key, required this.pairing}) : super(key: key);

  @override
  Request createState() => Request();
}

class Request extends State<RequestPage> {
  late final Pairing pairing;

  Request();

  TextEditingController subjectEditingController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    setState(() {
      subjectEditingController.text = widget.pairing.item;
      pairing = widget.pairing;
    });
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
                  children: <Widget>[
                    (CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image(
                          image: NetworkImage(pairing.postedBy.avatarUrl)),
                    )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                title: Text(pairing.item),
                isThreeLine: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: pairing.location.desc,
                        style: const TextStyle(color: Colors.black),
                        //style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Post by ",
                        style: const TextStyle(color: Colors.black),
                        //style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: pairing.postedBy.username,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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

  void onPressed() {
    Pairing newPairing = Pairing(
      item: subjectEditingController.text,
      location: pairing.location,
      postedBy: pairing.postedBy,
      favorite: pairing.favorite,
      postedDate: pairing.postedDate,
      deadline: pairing.deadline,
      liked: pairing.liked,
      bannerUrl: pairing.bannerUrl,
      requesters: [],
    );

    Navigator.pop(context, newPairing);
  }

  void onAddPhoto() {}
}
