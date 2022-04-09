import 'package:uuid/uuid.dart';

class PairingCategory {
  final String category;
  final List<Pairing> pairings;
  PairingCategory(this.category, this.pairings);
}

class Pairing {
  String id;
  String item;
  String postedBy;
  String location;
  bool favorite;
  DateTime postedDate;
  DateTime deadline;
  int liked;
  String bannerUrl;
  Pairing(this.item, this.postedBy, this.location, this.favorite,
      this.postedDate, this.deadline, this.liked, this.bannerUrl,
      [String? id])
      : id = id ?? const Uuid().v1.toString();
}

class PairingProvider {
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
      Pairing('ASport 40% off over \$500', 'ASport Offical',
          'Nano Plaza - ASport', false, fiveMinAgo, threeDaysAfter, 5, ""),
      Pairing('ASport Wait for Pair!!!', 'Koey98', 'Nano Plaza - ASport', false,
          fiveMinAgo, twoWeeksAfter, 8, ""),
      Pairing('\$700 for 2 pairs of shoes', 'Jack_Smith',
          'Nano Plaza - Boutique', false, twelveMinAgo, twoWeeksAfter, 10, ""),
      Pairing('BSport 20% off over \$800', 'BSport Offical',
          'Mega Plaza - BSport', false, fiveDaysAgo, threeDaysAfter, 10, ""),
      Pairing('ASport Wait for Pair!!!', 'Koey98', 'Nano Plaza - ASport', false,
          twoDaysAgo, oneWeekAfter, 20, ""),
      Pairing('\$700 for 2 pairs of shoes', 'Jack_Smith',
          'Nano Plaza - Boutique', false, threeDaysAgo, twoWeeksAfter, 3, ""),
    ];
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
      Pairing('2nd Item at \$1', 'ASport Offical', 'Nano Plaza - ASport', false,
          fiveMinAgo, tenDaysAfter, 10, '../asset/discount-tile1.jpg'),
      Pairing(
        'Sharing on  BShop Discount',
        'Koey98',
        'Nano Plaza - ASport',
        false,
        twoDaysAgo,
        fifteenDaysAfter,
        8,
        '../asset/discount-tile3.jpg',
      ),
      Pairing(
        '\$400 for 3 pairs of shoes',
        'Jack_Smith',
        'Nano Plaza - Boutique',
        false,
        twoDaysAgo,
        fifteenDaysAfter,
        3,
        '../asset/discount-tile4.jpg',
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
