import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';

class AuthProvider with ChangeNotifier {
  final String? _url = dotenv.env['BASE_URL'];
  User? _user;
  Token? _accessToken;
  Token? _refreshToken;

  bool get isAuth {
    debugPrint('isAuth called');
    print(_accessToken?.token != null);
    return _accessToken?.token != null;
  }

  String? get token {
    if (_accessToken?.token != null &&
        _accessToken?.expires != null &&
        _accessToken!.expires!.isAfter(DateTime.now())) {
      return _accessToken?.token;
    }

    return null;
  }

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
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 400 || response.statusCode == 500) {
        throw HttpException(decodedResponse['message']);
      }
      _user = User.fromJSON(decodedResponse['user']);
      _accessToken = Token.fromJSON(decodedResponse['tokens']['access']);
      _refreshToken = Token.fromJSON(decodedResponse['tokens']['refresh']);
      await callback();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
        {
          'token': _accessToken?.token,
          'expiryDate': _accessToken?.expires?.toIso8601String(),
          'userID': _user?.id,
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  login(String email, String password, Function callback) async {
    return _authenticate(email, password, 'login', callback);
  }

  register(String email, String password, Function callback) async {
    return _authenticate(email, password, 'register', callback);
  }
}
