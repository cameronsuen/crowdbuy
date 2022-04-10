import 'package:crowdbuy/location_provider.dart';
import 'package:location/location.dart';
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

class PostedLocation {
  String desc;
  LocationData location;
  PostedLocation({required this.desc, required this.location});
}

class Pairing {
  String id;
  String item;
  User postedBy;
  PostedLocation location;
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
    DateTime threeWeeksAfter = now.add(const Duration(days: 21));
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));
    DateTime twelveMinAgo = now.subtract(const Duration(minutes: 12));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime threeDaysAgo = now.subtract(const Duration(days: 3));
    DateTime fiveDaysAgo = now.subtract(const Duration(days: 5));

    pairings = <Pairing>[
      Pairing(
        item: 'ASport 40% off over \$500',
        postedBy: asport,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.central,
        ),
        favorite: false,
        postedDate: fiveDaysAgo,
        deadline: twoWeeksAfter,
        liked: 5,
        bannerUrl: '../asset/discount-asport.jpg',
        requesters: [koey98, aby],
      ),
      Pairing(
        item: 'ASport Wait for Pair!!!',
        postedBy: koey98,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.central,
        ),
        favorite: false,
        postedDate: twelveMinAgo,
        deadline: twoWeeksAfter,
        liked: 8,
        bannerUrl: '../asset/discount-asport.jpg',
        requesters: [],
      ),
      Pairing(
        item: '\$800 for 20% off!',
        postedBy: jack,
        location: PostedLocation(
          desc: 'Far Far Plaza - Boutique',
          location: LocationProvider.london,
        ),
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: twoWeeksAfter,
        liked: 10,
        bannerUrl: '../asset/discount-20off.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Boutique 20% off over \$800',
        postedBy: boutique,
        location: PostedLocation(
          desc: 'Far Far Plaza - Boutique',
          location: LocationProvider.london,
        ),
        favorite: false,
        postedDate: fiveDaysAgo,
        deadline: twoWeeksAfter,
        liked: 10,
        bannerUrl: '../asset/discount-20off.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Pet World Opening Promo',
        postedBy: koey98,
        location: PostedLocation(
          desc: 'Far Far Plaza - Pet World',
          location: LocationProvider.canberra,
        ),
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: threeWeeksAfter,
        liked: 52,
        bannerUrl: '../asset/discount-b2g1pet.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Boutique Buy 2 Get 1 Free',
        postedBy: boutique,
        location: PostedLocation(
          desc: 'Far Far Plaza - Boutique',
          location: LocationProvider.london,
        ),
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: threeDaysAfter,
        liked: 32,
        bannerUrl: '../asset/discount-b2g1.jpg',
        requesters: [],
      ),
      Pairing(
        item: '\$1 for 2nd pairs of shoes',
        postedBy: jack,
        location: PostedLocation(
          desc: 'Na Na Plaza - ShoeShine',
          location: LocationProvider.singapore,
        ),
        favorite: false,
        postedDate: threeDaysAgo,
        deadline: threeDaysAfter,
        liked: 33,
        bannerUrl: '../asset/discount-2nd1.jpg',
        requesters: [],
      ),
    ];
  }

  submitRequest(Pairing pairing) {
    pairing.postedBy = jack;
    pairing.postedDate = DateTime.now();
    pairings.add(pairing);
  }

  User getCurrentUser() {
    return currentUser;
  }

  static var koey98 = User(
    username: 'Steven',
    rating: 4.5,
    avatarUrl: '../asset/propic/steven.png',
  );
  static var aby = User(
    username: 'Nat',
    rating: 4.9,
    avatarUrl: '../asset/propic/nat.png',
  );
  static var jack = User(
    username: 'Cameron',
    rating: 4.1,
    avatarUrl: '../asset/propic/cameron.png',
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

  List<Pairing> getNearby(LocationData currentLocation) {
    return pairings
        .where((p) =>
            LocationProvider.getDistance(currentLocation, p.location.location) <
            LocationProvider.nearbyThresholdInKm)
        .toList();
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
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.taipo,
        ),
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: tenDaysAfter,
        liked: 10,
        bannerUrl: '../asset/discount-2nd1.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Sharing on ShoeShine Discount',
        postedBy: koey98,
        location: PostedLocation(
          desc: 'Na Na Plaza - ShoeShine',
          location: LocationProvider.taipo,
        ),
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: fifteenDaysAfter,
        liked: 8,
        bannerUrl: '../asset/discount-b2g1.jpg',
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
    DateTime tenMinAgo = now.subtract(const Duration(minutes: 10));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime oneDayAgo = now.subtract(const Duration(days: 1));

    var categories = <PairingCategory>[
      PairingCategory("Latest",
          pairings.where((p) => p.postedDate.isAfter(tenMinAgo)).toList()),
      PairingCategory("Popular", pairings.where((p) => p.liked > 30).toList()),
      PairingCategory("Last Minute Offer",
          pairings.where((p) => p.deadline.isBefore(tenDaysAfter)).toList()),
    ];

    return categories;
  }
}
