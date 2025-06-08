import 'package:flutter/material.dart';
import 'package:interactive_calendar/data/repositories/auth/auth_repository_remote.dart';
import 'package:interactive_calendar/utils/password_controller.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: PasswordController.validate,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Provider.of<AuthRepositoryRemote>(context, listen: false)
                      .createNewUser(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          context);
                },
                child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
