import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final CookieRequest request;

  const SplashScreen(this.request, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Customize the splash screen appearance
      body: Center(
        child: FlutterLogo(
          size: 150,
        ),
      ),
    );
  }
}
