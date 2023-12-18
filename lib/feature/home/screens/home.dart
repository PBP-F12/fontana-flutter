import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';
import 'package:bookshelve_flutter/feature/home/models/book.dart';
import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final CookieRequest request;

  const HomePage(this.request, {super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Fontana';

  @override
  State<HomePage> createState() => _HomePageState(request);
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  CookieRequest request = CookieRequest();

  _HomePageState(CookieRequest request) {
    this.request = request;
  }

  static const int pageSize = 30; // Number of items per page
  int currentPage = 0; // Current page index
  List<Book> allBooks = []; // List to hold all books
  bool isLoading =
      true; // Flag to show a loading spinner while books are fetched

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    setState(() {
      isLoading = true; // Show loading spinner
    });

    var url = Uri.parse('http://localhost:8000/api/book/flutter');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      setState(() {
        allBooks = data.map((e) => Book.fromJson(e)).toList();
        isLoading = false; // Hide loading spinner
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false; // Hide loading spinner even on error
      });
    }
  }

  // Calculate the total number of pages
  int get totalPage => (allBooks.length / pageSize).ceil();

  // Get subset of data for the current page
  List<Book> getBooksForCurrentPage() {
    int startIndex = currentPage * pageSize;
    int endIndex = min(startIndex + pageSize, allBooks.length);
    return allBooks.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<Book> booksToShow = getBooksForCurrentPage();
    List<Book> topBooks =
        allBooks.take(10).toList(); // Take the first 10 books for the carousel

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Stack for the library image and text
                  Stack(
                    children: [
                      // Background Image
                      Container(
                        height: 200, // Set the desired height
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/library_bg.jpg', // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Dark overlay for better text readability
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.black
                            .withOpacity(0.5), // Adjust opacity as needed
                      ),
                      // Text in the dead center of the image
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fontana',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 234, 198, 150),
                                  fontFamily:
                                      GoogleFonts.merriweather().fontFamily,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Adjust the spacing between the two texts
                              Text(
                                'The only spring you need',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 234, 198, 150),
                                  fontFamily:
                                      GoogleFonts.merriweather().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Rest of the widgets
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style: TextStyle(
                          fontFamily: GoogleFonts.merriweather().fontFamily),
                      decoration: InputDecoration(
                        hintText: 'Search for books...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(125, 255, 255, 255),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'See The Top!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  // CarouselSlider for Popular Books
                  CarouselSlider(
                    items: topBooks.map((book) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetails(book: book),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              decoration: BoxDecoration(
                                color:
                                    Colors.white, // Added for better contrast
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  // Shadow for each carousel item
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                  image:
                                      NetworkImage(book.fields.bookCoverLink),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  book.fields.bookTitle,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    backgroundColor: Colors.black
                                        .withOpacity(0.5), // For readability
                                    color: Colors.white,
                                    fontFamily:
                                        GoogleFonts.merriweather().fontFamily,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      padEnds: false,
                      viewportFraction:
                          0.8, // Adjust based on how much of each card should be visible
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  // GridView.builder for Recommended Books
                  GridView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling within a SingleChildScrollView
                    shrinkWrap: true, // to fit within SingleChildScrollView
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: booksToShow.length,
                    itemBuilder: (context, index) {
                      var book = booksToShow[index];
                      return buildRecommendedBookCard(book);
                    },
                  ),
                  // Pagination Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: currentPage > 0
                              ? Colors.blue
                              : Colors
                                  .grey, // Change color based on availability
                        ),
                        onPressed: currentPage > 0
                            ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                            : null,
                      ),
                      Text(
                        'Halaman ${currentPage + 1} dari $totalPage',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: currentPage < totalPage - 1
                              ? Colors.blue
                              : Colors
                                  .grey, // Change color based on availability
                        ),
                        onPressed: currentPage < totalPage - 1
                            ? () {
                                setState(() {
                                  currentPage++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildRecommendedBookCard(Book book) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetails(book: book),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(255, 200, 174, 125),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  book.fields.bookCoverLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.fields.bookTitle,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontFamily: GoogleFonts.merriweather().fontFamily),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
