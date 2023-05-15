import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/index.dart';
import '../helpers/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class AuthProvider with ChangeNotifier {
  final String _baseURL = Config.baseUrl;
  User? _user;
  Token? _accessToken;
  Token? _refreshToken;
  Timer? _authTimer;

  bool get isAuth {
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

  User get user {
    return _user!;
  }

  _saveToSharedPreference(dynamic decodedResponse) async {
    _user = Generic.fromJSON<User, void>(decodedResponse['user']);
    _accessToken = Generic.fromJSON<Token, void>(decodedResponse['tokens']['access']);
    _refreshToken = Generic.fromJSON<Token, void>(decodedResponse['tokens']['refresh']);
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(
      {
        'accessToken': _accessToken?.token,
        'accessTokenExp': _accessToken?.expires?.toIso8601String(),
        'refreshToken': _refreshToken?.token,
        'refreshTokenExp': _refreshToken?.expires?.toIso8601String(),
        'userID': _user?.id,
      },
    );
    prefs.setString('userData', userData);
  }

  _authenticate(
      String email, String password, String urlSegment, Function callback) async {
    try {
      // * e.g: https://domain.com/auth/login
      // * e.g: https://domain.com/auth/register
      final url = Uri.parse('$_baseURL/auth/$urlSegment');
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
      await callback();
      notifyListeners();
      _saveToSharedPreference(decodedResponse);
    } catch (error) {
      await Analytics.crashEvent(
        '_authenticate',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  login(String email, String password, Function callback) async {
    return _authenticate(email, password, 'login', callback);
  }

  register(String email, String password, Function callback) async {
    return _authenticate(email, password, 'register', callback);
  }

  _oauth(String accessToken, String urlSegment, Function callback) async {
    try {
      // * e.g: POST https://domain.com/auth/facebook
      // * e.g: POST https://domain.com/auth/google
      final url = Uri.parse('$_baseURL/auth/$urlSegment');
      final body = {'access_token': accessToken};
      final response = await http.post(url, body: body);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      await callback();
      notifyListeners();
      _saveToSharedPreference(decodedResponse);
    } catch (error) {
      await Analytics.crashEvent(
        '_oauth',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  googleLogin(String accessToken, Function callback) async {
    return _oauth(accessToken, 'google', callback);
  }

  facebookLogin(String accessToken, Function callback) async {
    return _oauth(accessToken, 'facebook', callback);
  }

  forgetPassword(String email, Function callback) async {
    try {
      // * e.g: https://domain.com/user/forgotPassword
      final url = Uri.parse('$_baseURL/user/forgotPassword');
      final response = await http.post(
        url,
        body: {
          'email': email,
        },
      );
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 400 || response.statusCode == 500) {
        throw HttpException(decodedResponse['message']);
      }
      await callback();
    } catch (error) {
      await Analytics.crashEvent(
        'forgetPassword',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedUserData = jsonDecode(prefs.getString('userData')!);
      if (extractedUserData == null) {
        return false;
      }

      final accessTokenExp = DateTime.parse(extractedUserData['accessTokenExp']);
      final refreshTokenExp = DateTime.parse(extractedUserData['refreshTokenExp']);

      // access token and refresh token expired
      if (_isExpired(accessTokenExp) && _isExpired(refreshTokenExp)) {
        return false;
      }

      // refresh token not expired then fetch new access token
      final url = Uri.parse('$_baseURL/auth/refresh-token');
      final response = await http.post(
        url,
        body: {
          'refreshToken': extractedUserData['refreshToken'],
          'timezone': '7',
        },
      );
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      _user = Generic.fromJSON<User, void>(decodedResponse['user']);
      _accessToken = Generic.fromJSON<Token, void>(decodedResponse['tokens']['access']);
      _refreshToken = Generic.fromJSON<Token, void>(decodedResponse['tokens']['refresh']);
      notifyListeners();
      _autoLogout();
      return true;
    } catch (error) {
      await Analytics.crashEvent(
        'tryAutoLogin',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  void logout() async {
    _user = null;
    _accessToken = null;
    _refreshToken = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeToExp = _accessToken!.expires!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExp), logout);
  }

  bool _isExpired(DateTime date) {
    return date.isBefore(DateTime.now());
  }
}
