import 'dart:convert';

import 'package:bookshelve_flutter/constant/urls.dart';
import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/event/screens/event_page.dart';
import 'package:flutter/material.dart';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEventPage extends StatefulWidget {
  final CookieRequest request;

  const CreateEventPage(this.request, {super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState(request);
}

class _CreateEventPageState extends State<CreateEventPage> {
  List<Book> list = <Book>[];

  late Future<dynamic> books;

  final _formKey = GlobalKey<FormState>();
  String _eventName = "";
  String _description = "";
  String _location = "";
  String _posterLink = "";
  String _eventDate = "";
  String _bookTopic = "";
  CookieRequest request = CookieRequest();

  _CreateEventPageState(CookieRequest request) {
    this.request = request;
  }

  Future<dynamic> fetchBooks() async {
    final response = await request.get('${Urls.backendUrl}/json/');
    return response;
  }

  @override
  void initState() {
    super.initState();
    books = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc8ae7d),
      appBar: AppBar(
        title: Text('Create Event',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: GoogleFonts.merriweather().fontFamily)),
        backgroundColor: Color.fromARGB(255, 132, 112, 73),
      ),
      drawer: LeftDrawer(request),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Event Name",
                labelText: "Event Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _eventName = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Event Name field is required";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Event Date",
                labelText: "Event Date (YYYY-MM-DD)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _eventDate = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Event Date field is required";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Location",
                labelText: "Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _location = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Location field is required";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Description",
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _description = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Description field is required";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Poster Link",
                labelText: "Poster Link",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _posterLink = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Poster Link field is required";
                }
                return null;
              },
            ),
          ),
          FutureBuilder(
              future: books,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(
                        'Connection done but got error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const Text('Connection done but no data.');
                  }

                  List<dynamic> books = snapshot.data;

                  return DropdownButton<String>(
                      isExpanded: true,
                      value: _bookTopic,
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            _bookTopic = value;
                          });
                        }
                      },
                      items: [
                        const DropdownMenuItem(
                          value: '',
                          child: Text('-'),
                        ),
                        ...books.map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                              value: value['pk'],
                              child: Text(value['fields']['book_title']));
                        }).toList()
                      ]);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('error');
                }
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 132, 112, 73)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Kirim ke Django dan tunggu respons

                    final response = await request.postJson(
                        "${Urls.backendUrl}/event/api/create",
                        jsonEncode(<String, String>{
                          'event_name': _eventName,
                          'location': _location,
                          'description': _description,
                          'poster_link': _posterLink,
                          'event_date': _eventDate,
                          'book_id': _bookTopic,
                        }));
                    if (response['status'] == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("New Event Created!"),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventPage(request)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("There has been a mistake, please try again."),
                      ));
                    }
                  }
                },
                child: const Text(
                  "Pubish Event",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
