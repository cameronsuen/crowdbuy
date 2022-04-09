import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text("Discount Calculator"),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      body: Center(
          child: Column(
        children: [
          const Image(
            image: NetworkImage('../asset/discount_photo.jpg'),
          ),
          ListTile(
              title: const Text('ASport 40% off over \$500',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              subtitle: RichText(
                  text: const TextSpan(
                      text: 'Post by ',
                      style: TextStyle(color: Colors.grey),
                      children: <TextSpan>[
                    TextSpan(
                        text: "ASport Official",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]))),
          const ListTile(
              trailing: Text('3 days left'),
              subtitle: Text(
                'Clothing',
                style: TextStyle(color: Colors.blue),
              )),
          const ListTile(
              title: Text(
            'Outstanding Requests',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
          Card(
            child: ListTile(
              leading: Column(
                children: const <Widget>[
                  (CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Text("K"),
                  )),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              title: const Text("Koey98"),
              isThreeLine: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      text: '4.8',
                      //style: DefaultTextStyle.of(context).style,
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: "5 minutes ago",
                      //style: DefaultTextStyle.of(context).style,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
              title: Text(
            'You may also interest...',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          Row(children: [
            const SizedBox(width: 20, height: 30),
            SizedBox(
              width: 400, // <-- Your width
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFF7276),
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {},
                child: const Text('New Request'),
              ),
            ),
            const SizedBox(width: 20, height: 40),
            const Icon(Icons.chat_outlined, size: 35)
          ])
        ],
      )),
    );
  }
}
