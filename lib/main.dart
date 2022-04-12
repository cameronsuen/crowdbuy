import 'package:crowdbuy/location_provider.dart';
import 'package:crowdbuy/pairing_provider.dart';
import 'package:crowdbuy/request.dart';
import 'package:flutter/material.dart';
import 'package:duration/duration.dart';
import 'package:location/location.dart';

import 'b2c.dart';
import 'account.dart';
import 'chat.dart';
import 'chat_list.dart';
import 'community.dart';
import 'calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrowdBuy',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        textTheme: Theme.of(context).textTheme.apply(),
      ),
      home: const MyHomePage(title: 'CrowdBuy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  PairingProvider provider = PairingProvider();
  LocationProvider locationProvider = LocationProvider();
  LocationData currentLocation = LocationProvider.central;

  @override
  void initState() {
    super.initState();
    locationProvider
        .init()
        .then((_result) => locationProvider.getLocation())
        .then((location) => {
              setState(
                () {
                  currentLocation = location;
                },
              ),
            });
  }

  Widget getCurrentPage() {
    switch (index) {
      case 1:
        return CommunityPage(
          categories: provider.getFeaturedItems(),
          makeNewRequest: makeNewRequest,
        );
      case 2:
        return ChatPage(user: provider.getCurrentUser());
      // return const Calculator();
      case 3:
        return const Account();
      case 0:
      default:
        return PairingList(
          items: provider.getNearby(currentLocation),
          makeNewRequest: makeNewRequest,
        );
    }
  }

  FloatingActionButton? getActionButtonIfNeeded() {
    switch (index) {
      case 1:
      case 2:
        return null;
      case 0:
      default:
        return FloatingActionButton(
          onPressed: () {},
          tooltip: 'New Request',
          child: const Icon(Icons.add),
        );
    }
  }

  makeNewRequest(BuildContext context, Pairing pairing) async {
    var newPairing = await Navigator.of(context).push(
      makeRequest(pairing),
    ) as Pairing?;

    if (newPairing != null) {
      provider.submitRequest(newPairing);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        //child: PairingList(items: pairings),
        child: getCurrentPage(),
      ),
      floatingActionButton: getActionButtonIfNeeded(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
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

Route makeRequest(Pairing pairing) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        B2C(pairing: pairing),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
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
                IconButton(
                  splashColor: Colors.grey,
                  splashRadius: Material.defaultSplashRadius / 1.2,
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ]),
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PairingItem extends StatelessWidget {
  final Pairing pairing;
  final void Function(BuildContext context, Pairing pairing) makeNewRequest;
  const PairingItem({
    Key? key,
    required this.pairing,
    required this.makeNewRequest,
  }) : super(key: key);
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
                  backgroundColor: Colors.white,
                  child: Image(image: NetworkImage(pairing.postedBy.avatarUrl)),
                  //child: Text('${pairing.postedBy[0]} ${pairing.postedBy[1]}'),
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
                  RichText(
                      text: TextSpan(
                          text: pairing.location.desc,
                          style: const TextStyle(color: Colors.black))),
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
              makeNewRequest(context, pairing);
            }));
  }
}

class PairingList extends StatelessWidget {
  final List<Pairing> items;
  final void Function(BuildContext context, Pairing pairing) makeNewRequest;
  const PairingList({
    Key? key,
    required this.items,
    required this.makeNewRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return PairingItem(
            pairing: items[index],
            makeNewRequest: makeNewRequest,
          );
        });
  }
}
