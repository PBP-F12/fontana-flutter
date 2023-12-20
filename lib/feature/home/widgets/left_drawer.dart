import 'package:bookshelve_flutter/feature/event/screens/event_page.dart';
import 'package:bookshelve_flutter/feature/auth/screens/login.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_page.dart';
import 'package:bookshelve_flutter/feature/bookmark/screens/bookmark_page.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:bookshelve_flutter/feature/publish/screens/author_book_page.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftDrawer extends StatelessWidget {
  final CookieRequest request;

  const LeftDrawer(this.request, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff765827),
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff66461f),
                    Color(0xff765827),
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  Text(
                    'Hello, ${request.username}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffeac696),
                        fontFamily: GoogleFonts.dmSerifDisplay().fontFamily),
                  ),
                ],
              ),
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_filled, color: Color(0xffeac696)),
            title: Text(
              'Home',
              style: TextStyle(
                  color: const Color(0xffeac696),
                  fontSize: 16,
                  fontFamily: GoogleFonts.merriweather().fontFamily),
            ),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(request),
                  ));
            },
          ),
          request.isAuthor() || request.isReader()
              ? ListTile(
                  leading: const Icon(Icons.forum_outlined,
                      color: Color(0xffeac696)),
                  title: Text('Forum',
                      style: TextStyle(
                          color: const Color(0xffeac696),
                          fontSize: 16,
                          fontFamily: GoogleFonts.merriweather().fontFamily)),
                  // Bagian redirection ke ShopFormPage
                  onTap: () {
                    // TODO: Buatlah routing ke ShopFormPage di sini,
                    // setelah halaman ShopFormPage sudah dibuat.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumMainPage(request: request),
                        ));
                  },
                )
              : const SizedBox.shrink(),
          request.isReader()
              ? ListTile(
                  leading:
                      const Icon(Icons.book_rounded, color: Color(0xffeac696)),
                  title: Text('Bookmark',
                      style: TextStyle(
                          color: const Color(0xffeac696),
                          fontSize: 16,
                          fontFamily: GoogleFonts.merriweather().fontFamily)),
                  // Bagian redirection ke ShopFormPage
                  onTap: () {
                    // TODO: Buatlah routing ke ShopFormPage di sini,
                    // setelah halaman ShopFormPage sudah dibuat.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBookmarkPage(request),
                        ));
                  },
                )
              : const SizedBox.shrink(),
          ListTile(
            leading: const Icon(Icons.event, color: Color(0xffeac696)),
            title: Text('Event',
                style: TextStyle(
                    color: const Color(0xffeac696),
                    fontSize: 16,
                    fontFamily: GoogleFonts.merriweather().fontFamily)),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              // TODO: Buatlah routing ke ShopFormPage di sini,
              // setelah halaman ShopFormPage sudah dibuat.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventPage(request),
                  ));
            },
          ),
          request.isAuthor()
              ? ListTile(
                  leading: const Icon(Icons.auto_stories_outlined,
                      color: Color(0xffeac696)),
                  title: Text('My Books',
                      style: TextStyle(
                          color: const Color(0xffeac696),
                          fontSize: 16,
                          fontFamily: GoogleFonts.merriweather().fontFamily)),
                  // Bagian redirection ke ShopFormPage
                  onTap: () {
                    // TODO: Buatlah routing ke ShopFormPage di sini,
                    // setelah halaman ShopFormPage sudah dibuat.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthorBookPage(request),
                        ));
                  },
                )
              : const SizedBox.shrink(),
          ListTile(
            leading:
                const Icon(Icons.logout_outlined, color: Color(0xffeac696)),
            title: Text('Logout',
                style: TextStyle(
                    color: const Color(0xffeac696),
                    fontSize: 16,
                    fontFamily: GoogleFonts.merriweather().fontFamily)),
            onTap: () async {
              final response =
                  await request.logout('http://127.0.0.1:8000/auth/api/logout');

              if (response['status'] == 200) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              } else {
                // TODO handle error logout
              }
            },
          ),
        ],
      ),
    );
  }
}
