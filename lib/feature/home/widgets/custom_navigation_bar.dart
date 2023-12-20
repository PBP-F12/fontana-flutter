import 'package:bookshelve_flutter/feature/home/widgets/admin_navigation_bar.dart';
import 'package:bookshelve_flutter/feature/home/widgets/author_navigation_bar.dart';
import 'package:bookshelve_flutter/feature/home/widgets/reader_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatefulWidget {
  final int index;
  final Function onTap;

  CustomNavigationBar({super.key, required this.index, required this.onTap});

  @override
  State<CustomNavigationBar> createState() =>
      _CustomNavigationBarState(index: index, onTap: onTap);
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int index;
  Function onTap;

  _CustomNavigationBarState({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    if (request.role == 'ADMIN') {
      return AdminNavigationBar(index: index, onTap: onTap);
    } else if (request.role == 'AUTHOR') {
      return AuthorNavigationBar(index: index, onTap: onTap);
    } else {
      return ReaderNavigationBar(index: index, onTap: onTap);
    }
  }
}
