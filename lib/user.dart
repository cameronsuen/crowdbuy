class User {
  String username;
  double rating;
  String avatarUrl;

  User({required this.username, required this.rating, required this.avatarUrl});

  static var koey98 = User(
    username: 'Steven',
    rating: 4.5,
    avatarUrl: '../asset/propic/koey98.png',
  );
  static var aby = User(
    username: 'Nat',
    rating: 4.9,
    avatarUrl: '../asset/propic/aby.lu.png',
  );
  static var jack = User(
    username: 'Cameron',
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

  static List<User> getAllUsers() {
    return <User>[koey98, aby, jack, asport, boutique, currentUser];
  }
}
