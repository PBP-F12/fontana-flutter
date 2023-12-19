import 'package:bookshelve_flutter/feature/event/screens/event_page.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_page.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {
  final int index;

  const CustomNavigationBar(this.index, {super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState(index);
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final int index;

  _CustomNavigationBarState(this.index);

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return CurvedNavigationBar(
        index: index,
        items: const [
          Icon(Icons.home_filled, color: Color(0xff66461f)),
          Icon(Icons.forum_outlined, color: Color(0xff66461f)),
          Icon(Icons.book_rounded, color: Color(0xff66461f)),
          Icon(Icons.add_shopping_cart, color: Color(0xff66461f)),
          Icon(Icons.auto_stories_outlined, color: Color(0xff66461f)),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(request),
                  ));
              break;
            case 1:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForumMainPage(request),
                  ));
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(request),
                  ));
              break;
            case 3:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventPage(request),
                  ));
              break;
            case 4:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(request),
                  ));
              break;
          }
        },
        color: const Color(0xffeac696),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xfff8ede3),
        animationDuration: const Duration(milliseconds: 300));
  }
}
