import 'package:crowdbuy/community.dart';
import 'package:crowdbuy/pairing_provider.dart';
import 'package:crowdbuy/request.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

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
        width: 190,
        child: Card(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              const Padding(
                child: Icon(
                  Icons.favorite_outline,
                  color: Color(0xFF9F9F9F),
                ),
                padding: EdgeInsets.fromLTRB(0, 4, 6, 0),
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image(image: NetworkImage(user.avatarUrl)),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Text(
                        user.username + " ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      user.isOffical
                          ? const Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Color(0xFF0085FF),
                            )
                          : const Text(""),
                    ],
                  ),
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
                            style: const TextStyle(
                              color: Color(0xFF686868),
                            ),
                          ),
                        ),
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                      ],
                    ),
                    RichText(
                      text: const TextSpan(
                        text: "5 minutes ago",
                        style: TextStyle(
                          color: Color(0xFF9F9F9F),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(startNewChat(context, user));
                },
              ),
            ],
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
        leading: InkWell(
          onTap: () {
            goBack(context);
          },
          child: FittedBox(
              fit: BoxFit.cover,
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_back),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image(
                            image: NetworkImage(pairing.postedBy.avatarUrl)),
                      )),
                ],
              )),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(pairing.bannerUrl),
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
                              pairing.postedBy.isOffical
                                  ? const Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: Color(0xFF0085FF),
                                    )
                                  : const Text(''),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${pairing.postedBy.rating}',
                                  style: const TextStyle(
                                      color: Color(0xFF686868))),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const Icon(Icons.star_half,
                                  color: Colors.amber, size: 14),
                              const Text(
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
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              const Padding(
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Color(0xFF9F9F9F),
                                  size: 16,
                                ),
                                padding: EdgeInsets.only(right: 50),
                              ),
                              Text(
                                '${pairing.liked} Likes\n336 people joined',
                                style:
                                    const TextStyle(color: Color(0xFF9F9F9F)),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: standardPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                            child: Image(
                                image:
                                    NetworkImage(pairing.postedBy.avatarUrl)),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Text(
                            displayPostedDateOrDeadline(),
                            style: const TextStyle(color: Color(0xFF9F9F9F)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: pairing.postedBy.isOffical
                            ? const Text(
                                'Outstanding Requests',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.start,
                              )
                            : const Text(
                                'Discount refers to...',
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
                      height: pairing.requesters.isEmpty ? 10 : 100,
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
                        makeNewRequest: makeNewRequest,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          primary: pairing.postedBy.isOffical
                              ? const Color(0xFFFF7276)
                              : const Color(0xFFFF7A00),
                          textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () {
                        if (pairing.postedBy.isOffical) {
                          makeNewRequest(context, pairing);
                        } else {
                          Navigator.of(context)
                              .push(startNewChat(context, pairing.postedBy));
                        }
                      },
                      child: pairing.postedBy.isOffical
                          ? const Text('New Request')
                          : const Text('Join Request'),
                    ),
                  ),
                ),
                const Icon(Icons.chat_outlined, size: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }

  startNewChat(BuildContext context, User user) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
        user: user,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  makeNewRequest(BuildContext context, Pairing pairing) async {
    var newPairing = await Navigator.of(context).push(
      makeRequest(pairing),
    ) as Pairing;

    Navigator.pop(context, newPairing);
  }

  Route makeRequest(Pairing pairing) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RequestPage(pairing: pairing),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}
