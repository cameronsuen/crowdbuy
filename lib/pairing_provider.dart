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
  Pairing({
    required this.item,
    required this.postedBy,
    required this.location,
    required this.favorite,
    required this.postedDate,
    required this.deadline,
    required this.liked,
    required this.bannerUrl,
    required this.requesters,
  }) : id = const Uuid().v1.toString();
}

class PairingProvider {
  List<Pairing> pairings;

  PairingProvider() : pairings = [] {
    DateTime now = DateTime.now();
    DateTime threeDaysAfter = now.add(const Duration(days: 3));
    DateTime oneWeekAfter = now.add(const Duration(days: 7));
    DateTime twoWeeksAfter = now.add(const Duration(days: 14));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));
    DateTime twelveMinAgo = now.subtract(const Duration(minutes: 12));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime threeDaysAgo = now.subtract(const Duration(days: 3));
    DateTime fiveDaysAgo = now.subtract(const Duration(days: 5));

    pairings = <Pairing>[
      Pairing(
        item: 'ASport 40% off over \$500',
        postedBy: asport,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: threeDaysAfter,
        liked: 5,
        bannerUrl: "",
        requesters: [koey98, aby],
      ),
      Pairing(
        item: 'ASport Wait for Pair!!!',
        postedBy: koey98,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: twoWeeksAfter,
        liked: 8,
        bannerUrl: "",
        requesters: [],
      ),
      Pairing(
        item: '\$700 for 2 pairs of shoes',
        postedBy: jack,
        location: 'Nano Plaza - Boutique',
        favorite: false,
        postedDate: twelveMinAgo,
        deadline: twoWeeksAfter,
        liked: 10,
        bannerUrl: "",
        requesters: [],
      ),
      Pairing(
        item: 'Boutique 20% off over \$800',
        postedBy: boutique,
        location: 'Mega Plaza - Boutique',
        favorite: false,
        postedDate: fiveDaysAgo,
        deadline: threeDaysAfter,
        liked: 10,
        bannerUrl: "",
        requesters: [],
      ),
      Pairing(
        item: 'ASport Wait for Pair!!!',
        postedBy: koey98,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: oneWeekAfter,
        liked: 20,
        bannerUrl: "",
        requesters: [],
      ),
      Pairing(
        item: '\$700 for 2 pairs of shoes',
        postedBy: jack,
        location: 'Nano Plaza - Boutique',
        favorite: false,
        postedDate: threeDaysAgo,
        deadline: twoWeeksAfter,
        liked: 3,
        bannerUrl: "",
        requesters: [],
      ),
    ];
  }

  submitRequest(Pairing pairing) {
    pairings.add(pairing);
  }

  User getCurrentUser() {
    return currentUser;
  }

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

  List<Pairing> getNearby() {
    return pairings;
  }

  static List<Pairing> getSimilarItems() {
    DateTime now = DateTime.now();
    DateTime tenDaysAfter = now.add(const Duration(days: 10));
    DateTime fifteenDaysAfter = now.add(const Duration(days: 15));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));

    var pairings = <Pairing>[
      Pairing(
        item: '2nd Item at \$1',
        postedBy: asport,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: tenDaysAfter,
        liked: 10,
        bannerUrl: '../asset/discount-tile1.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Sharing on  BShop Discount',
        postedBy: koey98,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: fifteenDaysAfter,
        liked: 8,
        bannerUrl: '../asset/discount-tile3.jpg',
        requesters: [],
      ),
    ];

    return pairings;
  }

  List<PairingCategory> getFeaturedItems() {
    DateTime now = DateTime.now();
    DateTime tenDaysAfter = now.add(const Duration(days: 10));
    DateTime fifteenDaysAfter = now.add(const Duration(days: 15));
    DateTime twentyDaysAfter = now.add(const Duration(days: 20));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime oneDayAgo = now.subtract(const Duration(days: 1));

    var pairings = <Pairing>[
      Pairing(
        item: '2nd Item at \$1',
        postedBy: asport,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: tenDaysAfter,
        liked: 10,
        bannerUrl: '../asset/discount-tile1.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Sharing on  BShop Discount',
        postedBy: koey98,
        location: 'Nano Plaza - ASport',
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: fifteenDaysAfter,
        liked: 8,
        bannerUrl: '../asset/discount-tile3.jpg',
        requesters: [],
      ),
      Pairing(
        item: '\$400 for 3 pairs of shoes',
        postedBy: jack,
        location: 'Nano Plaza - Boutique',
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: fifteenDaysAfter,
        liked: 3,
        bannerUrl: '../asset/discount-tile4.jpg',
        requesters: [],
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
