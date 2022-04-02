import 'package:flutter/material.dart';

class B2C extends StatelessWidget {
  const B2C({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              ListTile(
                // tileColor: Color.fromARGB(156, 255, 0, 0),
                leading: Icon(Icons.album),
                title: Text('Koey98'),
                subtitle: Text('4.8'),
              ),
              ListTile(
                subtitle: Text('4.8'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
