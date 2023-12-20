import 'package:bookshelve_flutter/feature/auth/widgets/custom_text_field.dart';
import 'package:bookshelve_flutter/feature/publish/utils/publish_author_book.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublishFormPage extends StatefulWidget {
  final CookieRequest request;

  PublishFormPage(this.request, {super.key});

  @override
  State<PublishFormPage> createState() => _PublishFormPageState();
}

class _PublishFormPageState extends State<PublishFormPage> {
  // controller to get user's input
  TextEditingController _bookTitleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _bookCoverLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Publish Your Book',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 200, 174, 125),
      ),
      backgroundColor: Color.fromARGB(255, 200, 174, 125),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Start your journey with Fontana',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.brown.shade900,
                fontWeight: FontWeight.w700,
                fontSize: 36,
                fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'The world awaits your literary masterpiece!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF333333),
                fontStyle: FontStyle.italic,
                fontSize: 18.0,
                fontFamily: GoogleFonts.merriweather().fontFamily,
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.brown.shade900), // Adjust border properties as needed
                borderRadius: BorderRadius.circular(24.0),
                gradient: LinearGradient(
                    colors: [Colors.brown.shade200, Colors.brown.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(_bookTitleController, 'Book Title',
                      const Icon(Icons.history_edu),
                      hintText: 'Type your book title here'),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    _descriptionController,
                    'Description',
                    const Icon(Icons.title),
                    hintText: 'Share a glimpse of your book\'s storyline',
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    _bookCoverLinkController,
                    'Book Cover Link',
                    const Icon(Icons.link),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      String? validationMessage = _validateInputs();
                      if (validationMessage == null) {
                        // All fields are valid
                        var response = await publishAuthorBook(
                            request,
                            _bookTitleController.text,
                            _descriptionController.text,
                            _bookCoverLinkController.text,
                            context,
                            mounted);

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('Book published successfully!'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Failed to publish :('),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Input Error'),
                            content: Text(validationMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade600,
                    ),
                    child: Text(
                      'Publish',
                      style: TextStyle(
                        color: Colors.brown.shade50,
                        fontFamily: GoogleFonts.merriweather().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateInputs() {
    if (_bookTitleController.text.isEmpty) {
      return 'Please enter a book title';
    }
    if (_descriptionController.text.isEmpty) {
      return 'Please enter a book description';
    }
    if (_bookCoverLinkController.text.isEmpty) {
      return 'Please enter a book cover link';
    }
    return null; // Return null if all inputs are valid
  }
}
