import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor_app/helpers/index.dart';

import '../models/index.dart';

class UserProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;

  UserProvider(this._authToken);

  Future<User> getUserInfo() async {
    try {
      // * e.g: GET https://domain.com/user/info
      final url = Uri.parse('$_baseURL/user/info');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      return Generic.fromJSON<User, void>(decodedResponse['user']);
    } catch (e) {
      rethrow;
    }
  }

  Future updateUserInfo(
    String name,
    String country,
    String birthday,
    String level,
    List<String> learnTopics,
    List<String> testPreparations,
    Function callback,
  ) async {
    try {
      // * e.g: PUT https://domain.com/user/info
      final url = Uri.parse('$_baseURL/user/info');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode({
          'name': name,
          'country': country,
          'birthday': birthday,
          'level': level,
          'learnTopics': learnTopics,
          'testPreparations': testPreparations,
        }),
      );
      if (response.statusCode == 200) {
        await callback();
      } else {
        throw HttpException('Failed to update user\'s profile! Please try again later');
      }
    } catch (e) {
      rethrow;
    }
  }
}
