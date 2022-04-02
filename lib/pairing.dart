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
  Pairing(this.item, this.postedBy, this.location, this.favorite,
      this.postedDate, this.deadline, this.liked,
      [String? id])
      : id = id ?? const Uuid().v1.toString();
}
