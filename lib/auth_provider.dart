import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdbuy/user.dart' as user_provider;
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthProvider {
  Future<user_provider.User?> getCurrentUser();
  Future<bool> signin(email, password);
  Future<void> signout();
}

class AuthProvider extends IAuthProvider {
  @override
  Future<user_provider.User?> getCurrentUser() async {
    return user_provider.User(
      username: "Evans",
      avatarUrl: '../asset/propic/me.png',
      rating: 4.9,
    );
  }

  @override
  Future<bool> signin(email, password) async {
    return true;
  }

  @override
  Future<void> signout() async {}
}

class RealAuthProvider extends IAuthProvider {
  user_provider.User? user;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  RealAuthProvider({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  @override
  Future<user_provider.User?> getCurrentUser() async {
    if (user != null) return user;
    if (_firebaseAuth.currentUser != null) {
      var userInfo = await _firebaseFirestore
          .collection('userInfo')
          .doc(_firebaseAuth.currentUser?.email ?? '')
          .snapshots()
          .first;
      user = user_provider.User(
        username: userInfo.get('username') as String,
        rating: userInfo.get('rating') as double,
        avatarUrl: userInfo.get('avatarUrl') as String,
      );
      return user;
    }
    return null;
  }

  @override
  Future<bool> signin(email, password) async {
    bool signedIn = false;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userInfo = await _firebaseFirestore
          .collection('userInfo')
          .doc(email)
          .snapshots()
          .first;
      user = user_provider.User(
        username: userInfo.get('username') as String,
        rating: userInfo.get('rating') as double,
        avatarUrl: userInfo.get('avatarUrl') as String,
      );
    } catch (e) {
      signedIn = false;
    }
    return signedIn;
  }

  @override
  Future<void> signout() async {
    await _firebaseAuth.signOut();
    user = null;
  }
}
