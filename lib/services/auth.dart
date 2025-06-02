import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  void createUser(String email, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
