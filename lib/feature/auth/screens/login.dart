import 'package:bookshelve_flutter/feature/auth/screens/register_as_reader.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 174, 125),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                  color: Color(0xFF765827),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: Image.asset(
                'assets/images/readbook-vector.png',
                height: 275,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
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
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () async {
              // Perform login logic (authentication check)
              if (_performLogin()) {
                String username = _usernameController.text;
                String password = _passwordController.text;

                await request.login('http://localhost:8000/auth/api/login',
                    {'username': username, 'password': password});

                if (request.loggedIn) {
                  // If successful, navigate to the home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(request)),
                  );
                } else {
                  print('failed to login');
                }
              } else {
                // Show an error message or handle authentication failure
                _showErrorDialog();
              }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 12.0),
          TextButton(
            onPressed: () {
              // Navigate to the registration page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReaderRegistrationPage()),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  bool _performLogin() {
    // Replace this with your actual authentication logic
    // For simplicity, we'll just check if both fields are non-empty
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
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
