import 'dart:io';
import 'package:bookshelve_flutter/utils/cookie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

Future<bool> pickImage(CookieRequest request) async {
  if (kIsWeb) {
    throw Exception('Error');
  } else {
    if (Platform.isAndroid) {
      var picked = await FilePicker.platform.pickFiles();

      if (picked != null) {
        print(picked.files.first.name);
        // Perform the file upload here
        bool isSuccess =
            await request.uploadProfilePicture(picked.files.first.path!);
        return isSuccess;
      }

      return false;
    } else {
      throw Exception('Error');
    }
  }
}
