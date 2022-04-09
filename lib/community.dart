import 'package:crowdbuy/pairing.dart';
import 'package:flutter/material.dart';
import 'package:duration/duration.dart';

class CommunityPage extends StatelessWidget {
  final List<PairingCategory> categories;

  const CommunityPage(this.categories, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              categories[index].category,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 275,
                child: CommunityList(posts: categories[index].pairings)),
            Divider(color: Theme.of(context).hintColor, height: 1),
          ],
        ),
      ),
    );

    /*var entries = categories.entries
        .map(
          (e) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  e.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: 200,
                    height: 200,
                    child: CommunityList(posts: e.value)),
                Divider(color: Theme.of(context).hintColor, height: 1),
              ],
            ),
          ),
        )
        .toList();
    return Column(
      children: entries/
      mainAxisAlignment: MainAxisAlignment.start,
    );*/
  }
}

class CommunityItem extends StatelessWidget {
  final Pairing pairing;
  const CommunityItem(this.pairing, {Key? key}) : super(key: key);
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
    //return const Text("hello");
    return SizedBox(
      width: 200,
      child: Card(
        child: Column(
          children: <Widget>[
            const Image(
              image: NetworkImage("../asset/discount-tile1.jpg"),
              fit: BoxFit.fill,
            ),
            ListTile(
              title: const Text("2nd item at \$1"),
              trailing: IconButton(
                icon: Icon(
                  pairing.favorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: onPressed,
              ),
              /*subtitle: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Text("${pairing.item[0]}${pairing.item[1]}"),
                    ),
                    Text(pairing.item),
                  ],
                ),*/
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {}
}

class CommunityList extends StatelessWidget {
  final List<Pairing> posts;
  const CommunityList({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return CommunityItem(posts[index]);
      },
    );
  }
}
