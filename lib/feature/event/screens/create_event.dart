import 'dart:convert';

import 'package:bookshelve_flutter/feature/event/models/book.dart';
import 'package:bookshelve_flutter/feature/event/screens/event_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookshelve_flutter/feature/home/widgets/left_drawer.dart';

class CreateEventPage extends StatefulWidget {
    const CreateEventPage({super.key});

    @override
    State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {


   List<Book> list = <Book>[];
   final _formKey = GlobalKey<FormState>();
   String _eventName = "";
   String _description = "";
   String _location = "";
   String _posterLink = "";
   String _eventDate = "";
   String _bookTopic = "";

@override
  void initState() {
    super.initState();
    _bookTopic = ''; // Initialize _bookTopic here
  }

    Future<List<Book>> fetchBook() async {
      var url = Uri.parse('http://127.0.0.1:8000/json/');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List<Book> list_book = [];
      for (var d in data) {
        if (d != null) {
          list_book.add(Book.fromJson(d));
        }
      }
      return list_book;
    }

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Create New Event',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          
          drawer: const LeftDrawer(),

          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        labelText: "Event Date",
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
                    future: fetchBook(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (!snapshot.hasData) {
                        return const Center(
                          child: Text(
                            "No events available.",
                            style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                        );
                      }
                      else {
                        list = snapshot.data;
                        _bookTopic = list[0].pk;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: _bookTopic,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _bookTopic = value!;
                              });
                            },
                            items: list.map<DropdownMenuItem<String>>((Book value) {
                              return DropdownMenuItem<String>(
                                value: value.pk,
                                child: Text(value.fields.bookTitle),
                              );
                            }).toList(),
                          )
                        );
                      }
                    }
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                        ),
                        onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                                // Kirim ke Django dan tunggu respons
                                
                                final response = await request.postJson(
                                "http://127.0.0.1:8000/event/create-flutter/",
                                jsonEncode(<String, String>{
                                    'event_name': _eventName,
                                    'location': _location,
                                    'description': _description,
                                    'poster_link': _posterLink,
                                    'event_date': _eventDate,
                                    'book_id': _bookTopic,
                                }));
                                if (response.statusCode == 200) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                    content: Text("New Event Created!"),
                                    ));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => EventPage()),
                                    );
                                } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
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
                ]
              )
            ),
          ),
        );
    }
}