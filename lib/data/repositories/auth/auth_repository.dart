import 'package:flutter/material.dart';

abstract class AuthRepository extends ChangeNotifier {
  Future<void> signInWithEmailPassowrd(String email, String password, BuildContext context);
  Future<void> createNewUser(String name, String email, String password, BuildContext context);
  Future<void> logout();
  String getCurrentUserId();
  String getCurrentUserName();
  String getCurrentUseEmail();
}