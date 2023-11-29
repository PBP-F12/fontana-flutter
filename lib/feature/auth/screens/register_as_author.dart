import 'package:bookshelve_flutter/feature/auth/screens/register_as_reader.dart';
import 'package:flutter/material.dart';

class AuthorRegistrationPage extends StatelessWidget {
  const AuthorRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration As Author'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Perform registration logic
                _performRegistration(context);
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 12.0),
            TextButton(
              onPressed: () {
                // Navigate to the registration page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReaderRegistrationPage()),
                );
              },
              child: const Text('Register as Reader'),
            ),
            const SizedBox(height: 12.0),
            TextButton(
              onPressed: () {
                // Navigate to the registration page
                Navigator.pop(context);
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _performRegistration(BuildContext context) {
    // Replace this with your actual registration logic
    // For simplicity, we'll just print a message
    print('Registration logic here');
    Navigator.pop(context);
  }
}
