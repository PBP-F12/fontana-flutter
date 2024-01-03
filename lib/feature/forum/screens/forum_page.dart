import 'package:bookshelve_flutter/constant/color.dart';
import 'package:bookshelve_flutter/feature/forum/models/forum.dart';
import 'package:bookshelve_flutter/feature/forum/screens/forum_create_form.dart';
import 'package:bookshelve_flutter/feature/forum/widgets/forum_card.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForumMainPage extends StatefulWidget {
  final CookieRequest request;

  const ForumMainPage({super.key, required this.request});

  @override
  _ForumMainPageState createState() => _ForumMainPageState(request: request);
}

class _ForumMainPageState extends State<ForumMainPage> {
  late Future<List<Forum>> forums;

  CookieRequest request;

  _ForumMainPageState({required this.request});

  @override
  void initState() {
    super.initState();
    forums = request.getForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc8ae7d),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          backgroundColor: FontanaColor.brown2,
          onPressed: () async {
            // Navigate to the forum creation page and wait for the result
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForumCreationPage(request),
              ),
            );

            setState(() {
              forums = request.getForums();
            });
          },
          child: const Icon(Icons.add, color: FontanaColor.creamy0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Image
                Container(
                  height: 200, // Set the desired height
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/library_bg_2.jpg', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                // Dark overlay for better text readability
                Container(
                  height: 200,
                  width: double.infinity,
                  color:
                      Colors.black.withOpacity(0.5), // Adjust opacity as needed
                ),
                // Text in the dead center of the image
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forum',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 234, 198, 150),
                            fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
                          ),
                        ),
                        SizedBox(
                            height:
                                8), // Adjust the spacing between the two texts
                        Text(
                          'Discuss with people. Talk about books you like.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 234, 198, 150),
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: forums,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('error'));
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('no data'));
                    }

                    List<Forum> forums = snapshot.data!;

                    // return Text('success');

                    return Column(children: [
                      for (var i = 0; i < forums.length; i++)
                        ForumCard(forum: forums[i], index: i)
                    ]);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text('failed to fetch'),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
