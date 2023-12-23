import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  final CookieRequest request;

  const EditProfilePage({super.key, required this.request});

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState(request: request);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final CookieRequest request;

  _EditProfilePageState({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FontanaColor.creamy2,
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: Text('Edit Profile',
            style: TextStyle(
                color: FontanaColor.black,
                fontFamily: GoogleFonts.merriweather().fontFamily)),
        backgroundColor: FontanaColor.creamy0,
      ),
      body: Center(
          child: Column(
        children: [],
      )),
    );
  }
}
