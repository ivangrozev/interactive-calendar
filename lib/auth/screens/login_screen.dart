import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/data/repositories/auth/auth_repository_remote.dart';
import 'package:interactive_calendar/routing/Routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () =>
                    Provider.of<AuthRepositoryRemote>(context, listen: false)
                        .signInWithEmailPassowrd(_emailController.text,
                            _passwordController.text, context),
                child: const Text('Login')),
            TextButton(
              onPressed: () => context.go(Routes.register),
              child: const Row(
                children: [
                  Text('Don\'t have an account?'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Register here!',
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  return context.go(Routes.seeEventsAsGuest);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Check events as a guest'),
                    Icon(Icons.calendar_month),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
