import 'package:crowdbuy/pairing_provider.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  static var currentUser = User(
      username: 'Evans',
      rating: 4.9,
      avatarUrl: '../asset/propic/me.png',
      isOffical: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          const SizedBox(width: 20, height: 40),
          CircleAvatar(
              child: Image(
                image: NetworkImage(currentUser.avatarUrl),
              ),
              radius: 40),
          const SizedBox(width: 20, height: 10),
          Text(currentUser.username, style: const TextStyle(fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${currentUser.rating}'),
              const Icon(Icons.star, size: 16, color: Colors.amber),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          const Text(
            'Following',
            style: TextStyle(fontSize: 18),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          const Text(
            'Liked Request',
            style: TextStyle(fontSize: 18),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          const Text(
            'My Requests',
            style: TextStyle(fontSize: 18),
          ),
        ],
      )),
    );
  }
}
