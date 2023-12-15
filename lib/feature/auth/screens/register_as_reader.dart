import 'package:bookshelve_flutter/feature/auth/screens/register_as_author.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReaderRegistrationPage extends StatefulWidget {
  const ReaderRegistrationPage({super.key});

  @override
  _ReaderRegistrationPageState createState() => _ReaderRegistrationPageState();
}

class _ReaderRegistrationPageState extends State<ReaderRegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration As Reader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmationPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Perform registration logic
                if (_fieldsIsNotEmpty()) {
                  _performRegistration(context);
                } else {
                  _showErrorDialog();
                }
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
                      builder: (context) => const AuthorRegistrationPage()),
                );
              },
              child: const Text('Register as Author'),
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

  bool _fieldsIsNotEmpty() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _performRegistration(BuildContext context) async {
    // Replace this with your actual registration logic
    // For simplicity, we'll just print a message
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmationPassword = _confirmationPasswordController.text;

    Map<String, dynamic> request = {
      "username": username,
      "password1": password,
      "password2": confirmationPassword
    };

    final uri = Uri.parse("http://localhost:8000/auth/api/register/reader");
    final response = await http.post(uri, body: request);

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      print('error');
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Register Failed'),
        content: Text('Invalid username or password. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
