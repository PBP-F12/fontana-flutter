import 'package:bookshelve_flutter/feature/auth/screens/register.dart';
import 'package:bookshelve_flutter/feature/auth/screens/register_as_reader.dart';
import 'package:bookshelve_flutter/feature/auth/widgets/custom_text_field.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:bookshelve_flutter/feature/onboarding/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:google_fonts/google_fonts.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hello Again!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF333333),
                fontFamily: GoogleFonts.dmSerifDisplay().fontFamily),
          ),
          const SizedBox(height: 10),
          Text(
            "Welcome back, you've been missed!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 18,
                fontFamily: GoogleFonts.merriweather().fontFamily),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                CustomTextField(
                    _usernameController, 'Username', const Icon(Icons.person_2),
                    hintText: 'jk.rowling'),
                const SizedBox(height: 16.0),
                CustomTextField(_passwordController, 'Password',
                    const Icon(Icons.fingerprint),
                    isHideText: true, hintText: 'Set a strong password.'),
                const SizedBox(height: 24.0),
                CustomTextButton(
                    buttonText: 'Sign in',
                    fixedSize: MaterialStateProperty.all(Size(screenWidth, 60)),
                    variant: 'primary',
                    onPressed: () async {
                      // Perform login logic (authentication check)
                      if (_performLogin()) {
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        await request.login(
                            'http://localhost:8000/auth/api/login',
                            {'username': username, 'password': password});

                        if (request.loggedIn) {
                          // If successful, navigate to the home page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(request)),
                          );
                        } else {
                          print('failed to login');
                        }
                      } else {
                        // Show an error message or handle authentication failure
                        _showErrorDialog();
                      }
                    }),
                const SizedBox(height: 12.0),
                CustomTextButton(
                    buttonText: 'or Sign up?',
                    fixedSize: MaterialStateProperty.all(Size(screenWidth, 60)),
                    variant: 'secondary',
                    onPressed: () {
                      // Navigate to the registration page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    }),
              ],
            ),
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
