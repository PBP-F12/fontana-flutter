import 'package:bookshelve_flutter/constant/urls.dart';
import 'package:bookshelve_flutter/feature/details/models/book_details.dart';
import 'package:bookshelve_flutter/feature/details/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'dart:convert';
import 'package:bookshelve_flutter/feature/onboarding/widgets/custom_text_button.dart';
import 'package:bookshelve_flutter/feature/details/widgets/ratingstars.dart';

class AddReview extends StatefulWidget {
  final BookDetail bookDetail;
  final CookieRequest request;

  const AddReview({Key? key, required this.bookDetail, required this.request})
      : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState(request, bookDetail);
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController reviewTextController = TextEditingController();
  int _reviewRating = 0;
  String _reviewText = " ";
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the form

  final CookieRequest request;
  final BookDetail bookDetail;

  _AddReviewState(this.request, this.bookDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 174, 125),
      appBar: AppBar(
        title: Text(
          widget.bookDetail.title,
          style: TextStyle(
            fontFamily: GoogleFonts.merriweather().fontFamily,
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(74, 255, 255, 255),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    height: 370,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.2, 1.0],
                        colors: [
                          Color.fromARGB(255, 60, 47, 25),
                          Color.fromARGB(255, 200, 174, 125),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.bookDetail.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.bookDetail.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontFamily: GoogleFonts.merriweather().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Author: ${widget.bookDetail.author.username}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontFamily: GoogleFonts.merriweather().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      controller: reviewTextController,
                      style: TextStyle(
                          fontFamily: GoogleFonts.merriweather().fontFamily),
                      decoration: InputDecoration(
                        labelText: "Review Text",
                        hintText: "Review Text",
                        hintStyle: TextStyle(
                            fontFamily: GoogleFonts.merriweather().fontFamily),
                        labelStyle: TextStyle(
                          color: const Color(0xff765827),
                          fontFamily: GoogleFonts.merriweather().fontFamily,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF765827), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      maxLines: 4, // Set the max lines as needed
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your review';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Rating: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontFamily: GoogleFonts.merriweather().fontFamily,
                          ),
                        ),
                        StarRating(
                          maxRating: 5,
                          onChanged: (rating) {
                            setState(() {
                              _reviewRating = rating;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _reviewText = reviewTextController.text;
                          var response = await request.postJson(
                              '${Urls.backendUrl}/details/review/addflutter/${widget.bookDetail.id}/',
                              jsonEncode({
                                'book_id': widget.bookDetail.id,
                                'content': _reviewText,
                                'rating': _reviewRating
                              }));
                          if (response['status'] == 200) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("New Review Created!"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetails(
                                      bookId: widget.bookDetail.id,
                                      request: request)),
                            );
                          } else if (response['status'] == 403) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  "Authors are not allowed to add reviews."),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Error creating review."),
                            ));
                          }
                        }
                      },
                      buttonText: "Submit Review",
                      variant: 'primary', // You can customize the variant here
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }
}
