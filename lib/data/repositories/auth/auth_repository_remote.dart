import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_calendar/data/repositories/auth/auth_repository.dart';
import 'package:interactive_calendar/data/services/auth_service.dart';
import 'package:interactive_calendar/data/services/ui_service_local.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote(
      {required AuthService authService, required UiService uiService})
      : _authService = authService,
        _uiService = uiService {
    _isLogged = _isLoggedIn();
  }

  final AuthService _authService;
  final UiService _uiService;

  late bool _isLogged;
  bool get isLogged => _isLogged;

  bool _isLoggedIn() {
    bool isLogedin = _authService.isUserLoggedIn();
    return isLogedin;
  }

  @override
  Future<void> signInWithEmailPassowrd(
      String email, String password, BuildContext context) async {
    try {
      _authService.signInWithEmailPassword(email, password);
      _isLogged = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        _uiService.errorSnackBar(e.toString(), context);
      }
    }
  }

  @override
  Future<void> createNewUser(
      String name, String email, String password, BuildContext context) async {
    try {
      _authService.createNewUser(name, email, password);
      _isLogged = true;
      notifyListeners();
      _uiService.successSnackBar('Successfully registered user!', context);
    } on FirebaseAuthException catch (e) {
      _uiService.errorSnackBar(e.toString(), context);
    }
  }

  @override
  Future<void> logout() async {
    try {
      _authService.logout();
      _isLogged = false;
      notifyListeners();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  String getCurrentUserId() {
    return _authService.getCurrentUserId();
  }
  
  @override
  String getCurrentUseEmail() {
    return _authService.getUserEmail();
  }
  
  @override
  String getCurrentUserName() {
    return _authService.getUserName();
  }
}
