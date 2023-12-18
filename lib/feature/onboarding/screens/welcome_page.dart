import 'package:bookshelve_flutter/feature/auth/screens/login.dart';
import 'package:bookshelve_flutter/feature/auth/screens/register_as_reader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 200, 174, 125),
                  Color(0xFF765827)
                ])),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(
                      color: Color(0xffc8ae7d),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x22765827),
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ]),
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Image.asset(
                    'assets/images/readbook-vector.png',
                    height: 275,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to Fontana.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF333333),
                            fontFamily:
                                GoogleFonts.dmSerifDisplay().fontFamily),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Explore this limitless world in the palm of your hand!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 18,
                            fontFamily: GoogleFonts.merriweather().fontFamily),
                      ),
                      const SizedBox(height: 40),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const LoginPage())));
                          },
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size(screenWidth, 60)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF765827))),
                          child: Text(
                            'Sign in',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.merriweather().fontFamily),
                          )),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const ReaderRegistrationPage())));
                          },
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size(screenWidth, 60)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color(0xFF765827),
                                fontSize: 18,
                                fontFamily:
                                    GoogleFonts.merriweather().fontFamily),
                          ))
                    ],
                  )),
            ])));
  }
}
