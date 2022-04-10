import 'package:crowdbuy/location_provider.dart';
import 'package:crowdbuy/user.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class PairingCategory {
  final String category;
  final List<Pairing> pairings;
  PairingCategory(this.category, this.pairings);
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
    DateTime fiveMinAgo = now.subtract(const Duration(minutes: 5));
    DateTime twelveMinAgo = now.subtract(const Duration(minutes: 12));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime threeDaysAgo = now.subtract(const Duration(days: 3));
    DateTime fiveDaysAgo = now.subtract(const Duration(days: 5));

    pairings = <Pairing>[
      Pairing(
        item: 'ASport 40% off over \$500',
        postedBy: User.asport,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.central,
        ),
        favorite: false,
        postedDate: fiveDaysAgo,
        deadline: threeDaysAfter,
        liked: 5,
        bannerUrl: '../asset/discount-tile1.jpg',
        requesters: [User.koey98, User.aby],
      ),
      Pairing(
        item: 'ASport Wait for Pair!!!',
        postedBy: User.koey98,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.taipo,
        ),
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: twoWeeksAfter,
        liked: 8,
        bannerUrl: '../asset/discount-tile2.jpg',
        requesters: [],
      ),
      Pairing(
        item: '\$700 for 2 pairs of shoes',
        postedBy: User.jack,
        location: PostedLocation(
          desc: 'Nano Plaza - Boutique',
          location: LocationProvider.sf,
        ),
        favorite: false,
        postedDate: twelveMinAgo,
        deadline: twoWeeksAfter,
        liked: 10,
        bannerUrl: '../asset/discount-tile3.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Boutique 20% off over \$800',
        postedBy: User.boutique,
        location: PostedLocation(
          desc: 'Mega Plaza - Boutique',
          location: LocationProvider.london,
        ),
        favorite: false,
        postedDate: fiveDaysAgo,
        deadline: threeDaysAfter,
        liked: 10,
        bannerUrl: '../asset/discount-tile4.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'ASport Wait for Pair!!!',
        postedBy: User.koey98,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.canberra,
        ),
        favorite: false,
        postedDate: twoDaysAgo,
        deadline: oneWeekAfter,
        liked: 20,
        bannerUrl: '../asset/discount-tile1.jpg',
        requesters: [],
      ),
      Pairing(
        item: '\$700 for 2 pairs of shoes',
        postedBy: User.jack,
        location: PostedLocation(
          desc: 'Nano Plaza - Boutique',
          location: LocationProvider.singapore,
        ),
        favorite: false,
        postedDate: threeDaysAgo,
        deadline: twoWeeksAfter,
        liked: 3,
        bannerUrl: '../asset/discount-tile2.jpg',
        requesters: [],
      ),
    ];
  }

  submitRequest(Pairing pairing) {
    pairing.postedBy = User.jack;
    pairing.postedDate = DateTime.now();
    pairings.add(pairing);
  }

  User getCurrentUser() {
    return User.currentUser;
  }

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
        postedBy: User.asport,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.taipo,
        ),
        favorite: false,
        postedDate: fiveMinAgo,
        deadline: tenDaysAfter,
        liked: 10,
        bannerUrl: '../asset/discount-tile1.jpg',
        requesters: [],
      ),
      Pairing(
        item: 'Sharing on BShop Discount',
        postedBy: User.koey98,
        location: PostedLocation(
          desc: 'Nano Plaza - ASport',
          location: LocationProvider.taipo,
        ),
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
    DateTime tenMinAgo = now.subtract(const Duration(minutes: 10));

    DateTime twoDaysAgo = now.subtract(const Duration(days: 2));
    DateTime oneDayAgo = now.subtract(const Duration(days: 1));

    var categories = <PairingCategory>[
      PairingCategory("Latest",
          pairings.where((p) => p.postedDate.isAfter(tenMinAgo)).toList()),
      PairingCategory("Popular", pairings.where((p) => p.liked > 5).toList()),
      PairingCategory("Last Minute Offer",
          pairings.where((p) => p.deadline.isBefore(twentyDaysAfter)).toList()),
    ];

    return categories;
  }
}
