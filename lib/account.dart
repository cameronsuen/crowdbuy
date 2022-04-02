import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: const [
          SizedBox(width: 20, height: 40),
          CircleAvatar(
              child: Text(
                'CG',
                textScaleFactor: 2,
              ),
              radius: 40),
          SizedBox(width: 20, height: 10),
          Text('CrowdBuy Guys', style: TextStyle(fontSize: 20)),
          Text('Kwun Tong'),
          Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          Text(
            'Following',
            style: TextStyle(fontSize: 18),
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          Text(
            'Liked Request',
            style: TextStyle(fontSize: 18),
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
          Text(
            'My Requests',
            style: TextStyle(fontSize: 18),
          ),
        ],
      )),
    );
  }
}
