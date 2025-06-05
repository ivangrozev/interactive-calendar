import 'package:flutter/material.dart';
import 'package:interactive_calendar/services/auth_service.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  Future<void> _logOut(BuildContext context) {
    AuthService authService = AuthService();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Logout...',
          style: TextStyle(color: Colors.orange),
        ),
        duration: Duration(seconds: 1),
      ),
    );
    return authService.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ElevatedButton(
          onPressed: () {
            _logOut(context);
          },
          child: const Text('Logout')),
    );
  }
}
