import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on Exception {
      rethrow;
    }
  }

  String getUserName() {
    return _auth.currentUser!.displayName!;
  }

  Future<void> logOut() {
    try {
      return _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> createNewUser(
      String name, String email, String password) async {
    late Future<UserCredential> ucr;
    try {
      ucr = _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser?.updateProfile(displayName: name);
    } on FirebaseAuthException {
      rethrow;
    }
    return ucr;
  }
}
