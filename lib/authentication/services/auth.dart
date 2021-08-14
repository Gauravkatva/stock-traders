import 'package:firebase_auth/firebase_auth.dart';

enum SignUpState { success, alreadyExists, error }

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUp(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      if (e.toString().contains('already')) {
        return SignUpState.alreadyExists;
      }
      return SignUpState.error;
    }
  }
}
