// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdbuy/firebase_options.dart';
import 'package:crowdbuy/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var snapshot = await FirebaseFirestore.instance.collection('userInfo').get();

  for (var doc in snapshot.docs) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.delete(doc.reference);
    });
  }

  for (var user in User.getAllUsers()) {
    var email =
        '${user.username.toLowerCase().replaceAll(RegExp(' '), '_')}@crowdbuy-dummy.com';
    var doc = FirebaseFirestore.instance.collection('userInfo').doc(email);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(doc, {
        'username': user.username,
        'avatarUrl': user.avatarUrl,
        'rating': user.rating,
      });
    });
  }

  /*testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });*/
}
