import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';

class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final String rating;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.rating,
    required this.imageUrl,
  });
}

class MyBookmarkPage extends StatefulWidget {
  final CookieRequest request;

  const MyBookmarkPage(this.request, {super.key});

  final String title = 'My Bookmark';

  @override
  State<MyBookmarkPage> createState() => _MyBookmarkPageState(request);
}

class _MyBookmarkPageState extends State<MyBookmarkPage> {
  late Future<dynamic> bookmarkedBooks;
  int bookmarkTotal = 1; // id awal

  CookieRequest request = CookieRequest();

  _MyBookmarkPageState(CookieRequest request) {
    this.request = request;
  }

  Future<dynamic> getBookmarks() async {
    final response = await request.get('http://localhost:8000/bookmark/ajax');

    // print('here');
    // print(response);
    // print(response['bookmarks'][0]);

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
        backgroundColor: const Color(0xFFE5E5E5), // Warna krem
        title: Text(widget.title),
      ),
      body: Container(
        color: const Color(0xFFE5E5E5), // Warna krem
        child: FutureBuilder(
          future: bookmarkedBooks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('no data'));
              }

              List<dynamic> bookmarks  = snapshot.data;

              // return Text('success');

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
                child: Text('failed to fetch'),
              );
            }
          }),
        // child: ListView.builder(
        //   itemCount: bookmarkedBooks.length,
        //   itemBuilder: (context, index) {
        //     final book = bookmarkedBooks[index];
        //     return _buildBookItem(book);
        //   },
        // ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'Back to Home',
            child: const Icon(Icons.home),
            backgroundColor: const Color(0xFF1E8449), // Warna hijau
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {
              setState(() {
                // bookmarkedBooks.add(
                //   Book(
                //     id: bookmarkTotal,
                //     title: 'Book with id$bookmarkTotal',
                //     author: '-',
                //     category: '-',
                //     rating: 'NA/5',
                //     imageUrl: 'assets/book_placeholder.jpg', // Ganti dengan path gambar yang sesuai
                //   ),
                // );
                // bookmarkTotal++;
              });
            },
            tooltip: 'Bookmark',
            child: const Icon(Icons.bookmark),
            backgroundColor: const Color(0xFF1E8449), // Warna hijau
          ),
        ],
      ),
    );
  }

  Widget _buildBookItem(dynamic bookmark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8), // Ubah padding card agar lebih kecil
        decoration: BoxDecoration(
          color: Colors.white, // Warna krem untuk latar belakang card
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
              bookmark['bookCover'], // Ganti dengan path gambar yang sesuai
              width: 80, // Sesuaikan ukuran gambar sesuai kebutuhan Anda
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              bookmark['bookTitle'],
              style: TextStyle(
                fontSize: 16, // Ubah ukuran teks agar lebih kecil
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Author: ' + bookmark['authorUsername']),
            SizedBox(height: 8),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                setState(() {
                  // bookmarkedBooks.remove(book);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
