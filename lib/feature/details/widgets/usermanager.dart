import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to get reader's name from the server
Future<String> getUserName(int id) async {
  var url = Uri.parse('http://localhost:8000/readername/$id/');
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['name']; // Extracting the name
    } else {
      // Handle the case when the server response is not 200
      throw Exception('Failed to load reader name, status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any errors that occur during the HTTP request
    throw Exception('Error occurred while fetching reader name: $e');
  }
}