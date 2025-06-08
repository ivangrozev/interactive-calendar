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

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  String getUserName() {
    return _auth.currentUser!.displayName!;
  }

   String getUserEmail() {
    return _auth.currentUser!.email!;
  }


  Future<void> logout() {
    try {
      return _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> createNewUser(String name, String email, String password) async {
    try {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((newUser) {
        newUser.user!.updateProfile(displayName: name);
      });
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
