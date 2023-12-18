import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final CookieRequest request;

  const SplashScreen(this.request, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc8ae7d),
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 250),
      ),
    );
  }
}
