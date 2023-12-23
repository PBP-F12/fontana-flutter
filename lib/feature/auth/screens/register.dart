import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/constant/urls.dart';
import 'package:bookshelve_flutter/feature/auth/screens/login.dart';
import 'package:bookshelve_flutter/feature/auth/widgets/custom_text_field.dart';
import 'package:bookshelve_flutter/feature/onboarding/widgets/custom_text_button.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final CookieRequest request;

  const RegisterPage({super.key, required this.request});

  @override
  State<RegisterPage> createState() => _RegisterPageState(request: request);
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();

  final CookieRequest request;

  _RegisterPageState({required this.request});

  int? _sliding = 0;
  int switchCounter = 0;
  final List<String> roles = ['AUTHOR', 'READER'];
  String selectedRole = 'AUTHOR';
  Map<int, Widget> roleWidgetsMap = {
    0: Text('Author',
        style: TextStyle(
            color: const Color(0xff333333),
            fontFamily: GoogleFonts.merriweather().fontFamily)),
    1: Text('Reader',
        style: TextStyle(
            color: const Color(0xff333333),
            fontFamily: GoogleFonts.merriweather().fontFamily))
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: FontanaColor.creamy2,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello There!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                    fontFamily: GoogleFonts.dmSerifDisplay().fontFamily),
              ),
              const SizedBox(height: 10),
              Text(
                "Nice to meet you, uhh... who?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 18,
                    fontFamily: GoogleFonts.merriweather().fontFamily),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    CustomTextField(_fullNameController, 'Full Name',
                        const Icon(Icons.person_2),
                        hintText: 'J. K. Rowling'),
                    const SizedBox(height: 16.0),
                    CustomTextField(_usernameController, 'Username',
                        const Icon(Icons.person_2),
                        hintText: 'j.k.rowling'),
                    const SizedBox(height: 16.0),
                    CustomTextField(_passwordController, 'Password',
                        const Icon(Icons.fingerprint),
                        isHideText: true, hintText: 'Set a strong password.'),
                    const SizedBox(height: 16.0),
                    CustomTextField(_confirmationPasswordController,
                        'Confirm Password', const Icon(Icons.fingerprint),
                        isHideText: true,
                        hintText: 'Be sure to match the password ;)'),
                    const SizedBox(height: 16.0),
                    Text('I identify as...',
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color(0xff765827),
                            fontFamily: GoogleFonts.merriweather().fontFamily)),
                    const SizedBox(height: 8.0),
                    CupertinoSlidingSegmentedControl(
                        thumbColor: const Color(0xfff8ede3),
                        backgroundColor: const Color(0xffeac696),
                        padding: const EdgeInsets.all(8),
                        children: roleWidgetsMap,
                        groupValue: _sliding,
                        onValueChanged: (int? newValue) {
                          setState(() {
                            switchCounter++;
                            if (switchCounter == 5) {
                              roles.add('RAWR');
                              roleWidgetsMap[2] =
                                  RichText(text: const TextSpan(text: '🦁'));
                            }

                            if (newValue != null) {
                              if (newValue == 2) {
                                _sliding = 1;
                                roles.removeAt(2);
                                roleWidgetsMap.remove(2);
                                showToast(context, 'RAWR');
                              } else {
                                _sliding = newValue;
                                selectedRole = roles[newValue];
                              }
                            } else {
                              _sliding = 0;
                            }
                          });
                        }),
                    const SizedBox(height: 24.0),
                    CustomTextButton(
                        buttonText: 'Sign up',
                        fixedSize:
                            MaterialStateProperty.all(Size(screenWidth, 60)),
                        variant: 'primary',
                        onPressed: () {
                          // Perform registration logic
                          if (_fieldsIsNotEmpty()) {
                            _performRegistration(context);
                          } else {
                            _showErrorDialog();
                          }
                        }),
                    const SizedBox(height: 12.0),
                    CustomTextButton(
                        buttonText: 'or Sign in?',
                        fixedSize:
                            MaterialStateProperty.all(Size(screenWidth, 60)),
                        variant: 'secondary',
                        onPressed: () {
                          // Navigate to the registration page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _fieldsIsNotEmpty() {
    return _fullNameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmationPasswordController.text.isNotEmpty;
  }

  void _performRegistration(BuildContext context) async {
    // Replace this with your actual registration logic
    // For simplicity, we'll just print a message
    String fullName = _fullNameController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmationPassword = _confirmationPasswordController.text;

    final response = await request.registerAs(
        role: selectedRole,
        fullName: fullName,
        username: username,
        password: password,
        confirmationPassword: confirmationPassword);

    if (response['status'] == 200) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const LoginPage())));
    } else {
      showToast(context, response['message']);
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
