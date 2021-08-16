import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }
}
