import 'package:flutter/material.dart';

class B2C extends StatelessWidget {
  const B2C({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: const [
              Text("ASport"),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          leadingWidth: 72,
          leading: FittedBox(
              fit: BoxFit.cover,
              child: Row(
                children: const <Widget>[
                  Icon(Icons.arrow_back),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: CircleAvatar(
                        child: Text('AS'),
                      )),
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              const Image(
                image: NetworkImage('../asset/discount_photo.jpg'),
              ),
              ListTile(
                title: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    'ASport 40% off over \$500',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Post by ',
                            style: TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "ASport Official",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Color(0xFF0085FF),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('4.5', style: TextStyle(color: Color(0xFF686868))),
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        Icon(Icons.star_half, color: Colors.amber, size: 14),
                        Text(
                          '(29)',
                          style: TextStyle(color: Color(0xFFB0B0B0)),
                        )
                      ],
                    ),
                    const Text(
                      'Clothing',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                trailing: Column(
                  children: const [
                    Text(
                      '23 Likes\n336 people joined',
                      style: TextStyle(color: Color(0xFF9F9F9F)),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              ListTile(
                trailing: SizedBox(
                  height: 20,
                  width: 105,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      CircleAvatar(
                        child: Text('AS'),
                      ),
                      Text('3 days left'),
                    ],
                  ),
                ),
              ),
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
                const SizedBox(width: 20, height: 10),
                const Icon(Icons.chat_outlined, size: 35)
              ])
            ],
          )),
        ));
  }
}
