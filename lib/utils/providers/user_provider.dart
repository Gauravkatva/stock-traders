import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userId;

  void initialiseUser() {
    userId = _firebaseAuth.currentUser!.uid;
  }
}
