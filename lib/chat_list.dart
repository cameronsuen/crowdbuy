import 'package:crowdbuy/b2c.dart';
import 'package:crowdbuy/pairing_provider.dart';
import 'package:crowdbuy/request.dart';
import 'package:flutter/material.dart';
import 'package:duration/duration.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Bad: testing only
    DateTime now = DateTime.now();
    DateTime threeDaysAfter = now.add(const Duration(days: 3));
    DateTime twoWeeksAfter = now.add(const Duration(days: 14));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));
    DateTime twelveMinAgo = now.subtract(const Duration(minutes: 12));
    List<Pairing> pairings = [];

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: const FloatingAppBar(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: PairingList(items: pairings),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: index,
        // onTap: (int index) {
        //   setState(() {
        //     this.index = index;
        //   }
        //   );
        //   _navigateToScreens(index);
        // },
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ], // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class FloatingAppBar extends StatelessWidget with PreferredSizeWidget {
  const FloatingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        child: Material(
            color: Colors.white,
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(children: <Widget>[
                const Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 8),
                        hintText: "Search for discounts..."),
                  ),
                ),
                IconButton(
                  splashColor: Colors.grey,
                  splashRadius: Material.defaultSplashRadius / 1.2,
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ]),
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/*class Pairing {
  String id;
  String item;
  String postedBy;
  String location;
  bool favorite;
  DateTime postedDate;
  DateTime deadline;
  Pairing(this.item, this.postedBy, this.location, this.favorite,
      this.postedDate, this.deadline,
      [String? id])
      : id = id ?? const Uuid().v1.toString();
}*/

class PairingItem extends StatelessWidget {
  final Pairing pairing;
  const PairingItem(this.pairing, {Key? key}) : super(key: key);
  String displayPostedDateOrDeadline() {
    DateTime now = DateTime.now();
    DateTime fiveDaysTillNow = now.add(const Duration(days: 5));
    Duration timeDiff;
    String leftOrAgo;
    if (pairing.deadline.isBefore(fiveDaysTillNow)) {
      timeDiff = pairing.deadline.difference(now);
      leftOrAgo = "left";
    } else {
      timeDiff = now.difference(pairing.postedDate);
      leftOrAgo = "ago";
    }
    DurationTersity tersity = DurationTersity.day;
    if (timeDiff < const Duration(minutes: 1)) {
      tersity = DurationTersity.second;
    } else if (timeDiff < const Duration(hours: 1)) {
      tersity = DurationTersity.minute;
    } else if (timeDiff < const Duration(days: 1)) {
      tersity = DurationTersity.hour;
    }

    return '${prettyDuration(timeDiff, tersity: tersity, abbreviated: true)} $leftOrAgo';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Column(
              children: <Widget>[
                (CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  child: Image(
                    image: NetworkImage(pairing.postedBy.avatarUrl),
                  ),
                ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            title: Text(pairing.item),
            isThreeLine: true,
            trailing: SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(pairing.favorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          const Icon(Icons.person_add_alt_1_outlined)
                        ]),
                    Text(displayPostedDateOrDeadline())
                  ],
                )),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(text: TextSpan(text: pairing.location.desc)),
                  RichText(
                      text: TextSpan(
                          text: 'Post by ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                        TextSpan(
                            text: pairing.postedBy.username,
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ]))
                ]),
            onTap: () {
              //Navigator.of(context).push(_createRoute());
            }));
  }
}

class PairingList extends StatelessWidget {
  final List<Pairing> items;
  const PairingList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return PairingItem(items[index]);
        });
  }
}
