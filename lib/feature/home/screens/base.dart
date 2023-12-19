import 'package:bookshelve_flutter/feature/bookmark/screens/bookmark_page.dart';
import 'package:bookshelve_flutter/feature/event/screens/event_page.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_page.dart';
import 'package:bookshelve_flutter/feature/home/screens/home.dart';
import 'package:bookshelve_flutter/feature/home/widgets/custom_navigation_bar.dart';
import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';
import 'package:bookshelve_flutter/feature/publish/screens/author_book_page.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    final List<Widget> adminPages = [HomePage(request), EventPage(request)];
    final List<Widget> authorPages = [
      HomePage(request),
      EventPage(request),
      ForumMainPage(request: request),
      AuthorBookPage(request)
    ];
    final List<Widget> readerPages = [
      HomePage(request),
      EventPage(request),
      ForumMainPage(request: request),
      MyBookmarkPage(request)
    ];

    List<Widget> userPages;
    switch (request.role) {
      case 'ADMIN':
        userPages = adminPages;
        break;
      case 'AUTHOR':
        userPages = authorPages;
        break;
      default:
        userPages = readerPages;
        break;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 174, 125),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(74, 255, 255, 255),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: Image.asset(
              'assets/images/logo.png', // Ganti dengan path logo Anda
            ),
          ),
        ),
      ),
      drawer: LeftDrawer(request),
      body: userPages[pageIndex],
      bottomNavigationBar: CustomNavigationBar(
          index: pageIndex,
          onTap: (int newValue) {
            setState(() {
              pageIndex = newValue;
            });
          }),
    );
  }
}
