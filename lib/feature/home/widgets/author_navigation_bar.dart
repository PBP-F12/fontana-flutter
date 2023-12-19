import 'package:bookshelve_flutter/feature/event/screens/event_page.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_page.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorNavigationBar extends StatefulWidget {
  int index;
  Function onTap;

  AuthorNavigationBar({super.key, required this.index, required this.onTap});

  @override
  State<AuthorNavigationBar> createState() =>
      _AuthorNavigationBarState(index: index, onTap: onTap);
}

class _AuthorNavigationBarState extends State<AuthorNavigationBar> {
  int index;
  Function onTap;

  _AuthorNavigationBarState({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return CurvedNavigationBar(
        index: index,
        items: const [
          Icon(Icons.home_filled, color: Color(0xff66461f)),
          Icon(Icons.event, color: Color(0xff66461f)),
          Icon(Icons.forum_outlined, color: Color(0xff66461f)),
          Icon(Icons.auto_stories_outlined, color: Color(0xff66461f)),
        ],
        onTap: (int index) {
          onTap(index);
        },
        color: const Color(0xffeac696),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xfff8ede3),
        animationDuration: const Duration(milliseconds: 300));
  }
}
