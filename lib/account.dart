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
          Text('CrowdBuy Guys'),
          Text('Kwun Tong'),
          Divider(
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
        ],
      )),
    );
  }
}
