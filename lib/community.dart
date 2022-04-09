import 'package:crowdbuy/pairing_provider.dart';
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
  }
}

class CommunityItem extends StatelessWidget {
  final Pairing pairing;
  const CommunityItem(this.pairing, {Key? key}) : super(key: key);
  String displayDeadline() {
    DateTime now = DateTime.now();
    Duration timeDiff;
    timeDiff = pairing.deadline.difference(now);
    DurationTersity tersity = DurationTersity.day;
    if (timeDiff < const Duration(minutes: 1)) {
      tersity = DurationTersity.second;
    } else if (timeDiff < const Duration(hours: 1)) {
      tersity = DurationTersity.minute;
    } else if (timeDiff < const Duration(days: 1)) {
      tersity = DurationTersity.hour;
    } else if (timeDiff < const Duration(days: 20)) {
      tersity = DurationTersity.day;
    }

    return '${prettyDuration(
      timeDiff,
      tersity: tersity,
      upperTersity: DurationTersity.day,
      abbreviated: false,
    )} left';
  }

  @override
  Widget build(BuildContext context) {
    //return const Text("hello");
    return SizedBox(
      width: 200,
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: ClipRect(
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Image(
                      image: NetworkImage(pairing.bannerUrl),
                      fit: BoxFit.cover,
                    ),
                    Text(
                      displayDeadline(),
                      style: const TextStyle(
                          backgroundColor: Color.fromARGB(80, 0, 0, 0),
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                pairing.item,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: -1,
              ),
              trailing: IconButton(
                icon: Icon(
                  pairing.favorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: onPressed,
              ),
              subtitle: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      radius: 8,
                      child: Image(
                          image: NetworkImage(pairing.postedBy.avatarUrl)),
                    ),
                  ),
                  Text(pairing.postedBy.username),
                ],
              ),
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
