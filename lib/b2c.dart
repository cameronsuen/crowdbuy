import 'package:crowdbuy/community.dart';
import 'package:crowdbuy/pairing_provider.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';

class B2C extends StatelessWidget {
  Pairing pairing;

  B2C({Key? key, required this.pairing}) : super(key: key);

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
    var standardPadding = const EdgeInsets.symmetric(horizontal: 16);

    Widget renderInterestedParty(User user) {
      return SizedBox(
        width: 200,
        child: Card(
          child: ListTile(
            //dense: true,
            leading: Padding(padding: const EdgeInsets.only(top: 8), child:CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
              child: Image(image: NetworkImage(user.avatarUrl)),
            ),),
            title: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(user.username),
            ),
            subtitle: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${user.rating}',
                        //style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                  ],
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [Text(pairing.postedBy.username)],
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
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    pairing.item,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Post by ',
                            style: const TextStyle(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                text: pairing.postedBy.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Color(0xFF0085FF),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
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
                  children: [
                    Text(
                      '${pairing.liked} Likes\n336 people joined',
                      style: const TextStyle(color: Color(0xFF9F9F9F)),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: standardPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      child: Text('AS'),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Text(displayPostedDateOrDeadline()),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Outstanding Requests',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => renderInterestedParty(
                        pairing.requesters[index],
                      )),
                  itemCount: pairing.requesters.length,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'You may also be interested in...',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(
                height: 280,
                child: CommunityList(
                  posts: PairingProvider.getSimilarItems(),
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              Padding(
                padding: standardPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFFFF7276),
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () {},
                          child: const Text('New Request'),
                        ),
                      ),
                    ),
                    const Icon(Icons.chat_outlined, size: 35),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
