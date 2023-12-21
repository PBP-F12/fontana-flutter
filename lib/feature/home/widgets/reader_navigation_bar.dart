import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReaderNavigationBar extends StatefulWidget {
  int index;
  Function onTap;

  ReaderNavigationBar({super.key, required this.index, required this.onTap});

  @override
  State<ReaderNavigationBar> createState() =>
      _ReaderNavigationBarState(index: index, onTap: onTap);
}

class _ReaderNavigationBarState extends State<ReaderNavigationBar> {
  int index;
  Function onTap;

  _ReaderNavigationBarState({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return CurvedNavigationBar(
      index: index,
      items: const [
        Icon(Icons.home_filled, color: FontanaColor.brown2),
        Icon(Icons.event, color: FontanaColor.brown2),
        Icon(Icons.forum_outlined, color: FontanaColor.brown2),
        Icon(Icons.book_rounded, color: FontanaColor.brown2),
        Icon(Icons.person, color: FontanaColor.brown2)
      ],
      onTap: (int index) {
        onTap(index);
      },
      color: const Color(0xffeac696),
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: const Color(0xfff8ede3),
      animationDuration: const Duration(milliseconds: 300),
      height: 50,
    );
  }
}
