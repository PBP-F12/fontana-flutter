import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class MyBookmarkPage extends StatefulWidget {
  final CookieRequest request;

  const MyBookmarkPage(this.request, {Key? key}) : super(key: key);

  final String title = 'My Bookmark';

  @override
  State<MyBookmarkPage> createState() => _MyBookmarkPageState(request);
}

class _MyBookmarkPageState extends State<MyBookmarkPage> {
  late Future<dynamic> bookmarkedBooks;
  int bookmarkTotal = 1; // initial id

  CookieRequest request = CookieRequest();

  _MyBookmarkPageState(CookieRequest request) {
    this.request = request;
  }

  Future<dynamic> getBookmarks() async {
    final response = await request.get('http://localhost:8000/bookmark/ajax');
    return response['bookmarks'];
  }

  @override
  void initState() {
    super.initState();
    bookmarkedBooks = getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(74, 255, 255, 255),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/library_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: const Color.fromARGB(255, 200, 174, 125),
          child: FutureBuilder(
            future: bookmarkedBooks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No data'));
                }

                List<dynamic> bookmarks = snapshot.data;

                return ListView.builder(
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks[index];
                    return _buildBookItem(bookmark);
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('Failed to fetch'),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   heroTag: 'btn2',
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   tooltip: 'Back to Home',
          //   child: const Icon(Icons.home),
          //   backgroundColor: const Color(0xFF1E8449),
          // ),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildBookItem(dynamic bookmark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350,
        height: 600,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              bookmark['bookCover'],
              width: 300,
              height: 450,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              bookmark['bookTitle'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.merriweather().fontFamily,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Author: ' + bookmark['authorUsername'],
              style: TextStyle(
                fontFamily: GoogleFonts.merriweather().fontFamily,
              ), //textstyle
            ), //text
            SizedBox(height: 8),
            IconButton(
              icon: Icon(Icons.bookmark, size: 50.0),
              onPressed: () async {
                print('deleted ' + bookmark['bookId']);
                await request.delete(
                    'http://localhost:8000/bookmark/api/delete/' +
                        bookmark['bookId']);

                setState(() {
                  bookmarkedBooks = getBookmarks();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
