import 'package:uuid/uuid.dart';

class PairingCategory {
  final String category;
  final List<Pairing> pairings;
  PairingCategory(this.category, this.pairings);
}

class User {
  String username;
  double rating;
  String avatarUrl;

  User({required this.username, required this.rating, required this.avatarUrl});
}

class Pairing {
  String id;
  String item;
  User postedBy;
  String location;
  bool favorite;
  DateTime postedDate;
  DateTime deadline;
  int liked;
  String bannerUrl;
  List<User> requesters;
  Pairing(
      this.item,
      this.postedBy,
      this.location,
      this.favorite,
      this.postedDate,
      this.deadline,
      this.liked,
      this.bannerUrl,
      this.requesters,
      [String? id])
      : id = id ?? const Uuid().v1.toString();
}

class PairingProvider {
  static var koey98 = User(
    username: 'Steven',
    rating: 4.5,
    avatarUrl: '../asset/propic/koey98.png',
  );
  static var aby = User(
    username: 'aby.lu',
    rating: 4.9,
    avatarUrl: '../asset/propic/aby.lu.png',
  );
  static var jack = User(
    username: 'jack_smith',
    rating: 4.1,
    avatarUrl: '../asset/propic/jack_smith.png',
  );
  static var asport = User(
    username: 'ASport Official',
    rating: 4.1,
    avatarUrl: '../asset/propic/asport.png',
  );
  static var boutique = User(
    username: 'Boutique Official',
    rating: 4.5,
    avatarUrl: '../asset/propic/boutique.png',
  );
  static var currentUser = User(
    username: 'Evans',
    rating: 4.9,
    avatarUrl: '../asset/propic/me.png',
  );

  static List<Pairing> getNearby() {
    DateTime now = DateTime.now();
    DateTime threeDaysAfter = now.add(const Duration(days: 3));
    DateTime oneWeekAfter = now.add(const Duration(days: 7));
    DateTime twoWeeksAfter = now.add(const Duration(days: 14));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));
    DateTime twelveMinAgo = now.subtract(const Duration(minutes: 12));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime threeDaysAgo = now.subtract(const Duration(days: 3));
    DateTime fiveDaysAgo = now.subtract(const Duration(days: 5));

    return <Pairing>[
      Pairing('ASport 40% off over \$500', asport, 'Nano Plaza - ASport', false,
          fiveMinAgo, threeDaysAfter, 5, "", [koey98, aby]),
      Pairing('ASport Wait for Pair!!!', koey98, 'Nano Plaza - ASport', false,
          fiveMinAgo, twoWeeksAfter, 8, "", []),
      Pairing('\$700 for 2 pairs of shoes', jack, 'Nano Plaza - Boutique',
          false, twelveMinAgo, twoWeeksAfter, 10, "", []),
      Pairing('Boutique 20% off over \$800', boutique, 'Mega Plaza - Boutique',
          false, fiveDaysAgo, threeDaysAfter, 10, "", []),
      Pairing('ASport Wait for Pair!!!', koey98, 'Nano Plaza - ASport', false,
          twoDaysAgo, oneWeekAfter, 20, "", []),
      Pairing('\$700 for 2 pairs of shoes', jack, 'Nano Plaza - Boutique',
          false, threeDaysAgo, twoWeeksAfter, 3, "", []),
    ];
  }

  static List<Pairing> getSimilarItems() {
    DateTime now = DateTime.now();
    DateTime tenDaysAfter = now.add(const Duration(days: 10));
    DateTime fifteenDaysAfter = now.add(const Duration(days: 15));
    DateTime twentyDaysAfter = now.add(const Duration(days: 20));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime oneDayAgo = now.subtract(const Duration(days: 1));

    var pairings = <Pairing>[
      Pairing('2nd Item at \$1', asport, 'Nano Plaza - ASport', false,
          fiveMinAgo, tenDaysAfter, 10, '../asset/discount-tile1.jpg', []),
      Pairing(
        'Sharing on BShop Discount',
        koey98,
        'Nano Plaza - ASport',
        false,
        twoDaysAgo,
        fifteenDaysAfter,
        8,
        '../asset/discount-tile3.jpg',
        [],
      ),
    ];

    return pairings;
  }

  static List<PairingCategory> getFeaturedItems() {
    DateTime now = DateTime.now();
    DateTime tenDaysAfter = now.add(const Duration(days: 10));
    DateTime fifteenDaysAfter = now.add(const Duration(days: 15));
    DateTime twentyDaysAfter = now.add(const Duration(days: 20));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime oneDayAgo = now.subtract(const Duration(days: 1));

    var pairings = <Pairing>[
      Pairing('2nd Item at \$1', asport, 'Nano Plaza - ASport', false,
          fiveMinAgo, tenDaysAfter, 10, '../asset/discount-tile1.jpg', []),
      Pairing(
        'Sharing on  BShop Discount',
        koey98,
        'Nano Plaza - ASport',
        false,
        twoDaysAgo,
        fifteenDaysAfter,
        8,
        '../asset/discount-tile3.jpg',
        [],
      ),
      Pairing(
        '\$400 for 3 pairs of shoes',
        jack,
        'Nano Plaza - Boutique',
        false,
        twoDaysAgo,
        fifteenDaysAfter,
        3,
        '../asset/discount-tile4.jpg',
        [],
      ),
    ];

    var categories = <PairingCategory>[
      PairingCategory("Latest",
          pairings.where((p) => p.postedDate.isAfter(oneDayAgo)).toList()),
      PairingCategory("Popular", pairings.where((p) => p.liked > 5).toList()),
      PairingCategory("Last Minute Offer",
          pairings.where((p) => p.deadline.isBefore(twentyDaysAfter)).toList()),
    ];

    return categories;
  }
}
