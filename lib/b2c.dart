import 'package:flutter/material.dart';

class B2C extends StatelessWidget {
  const B2C({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: const Color(0xFFFF7276),
        textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          const Image(
            image: NetworkImage('../asset/discount_photo.jpg'),
          ),
          const ListTile(
              title: Text('ASport 40% off over \$500'),
              subtitle: Text(
                'Post by ASport Official',
                // subtitle: Column(
                //   children: const [
                //     Text('Post by ASport Official', textAlign: TextAlign.left),
                //     Text('4.8'),
                //   ],
              )),
          const ListTile(
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
          const ListTile(
              title: Text(
            'You may also interest...',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )),
          // const ListTile(
          //   leading: Icon(Icons.album),
          //   title: Text('Koey98'),
          //   subtitle: Text('4.8'),
          // ),
          Row(children: [
            ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('New Request'),
            ),
            const Icon(Icons.chat_bubble_outline_rounded)
          ])
        ],
      )),
    );
  }
}
