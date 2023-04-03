import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/index.dart';

class AuthProvider with ChangeNotifier {
  final String? _url = dotenv.env['BASE_URL'];

  _authenticate(
      String email, String password, String urlSegment, Function callback) async {
    try {
      final url = Uri.parse('$_url/auth/$urlSegment');
      final body = {
        'email': email,
        'password': password,
      };

      if (urlSegment == 'register') {
        body.addEntries({'source': 'null'}.entries);
      }

      final response = await http.post(url, body: body);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await callback();
      } else {
        throw HttpException(decodedResponse['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  login(String email, String password) async {}

  register(String email, String password, Function callback) async {
    return _authenticate(email, password, 'register', callback);
  }
}
