import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/index.dart';
import '../models/index.dart';

class CourseProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;

  CourseProvider(this._authToken);

  Future<List<CourseCategory>> fetchAndSetCourseCategory() async {
    try {
      final url = Uri.parse('$_baseURL/content-category');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      return Generic.fromJSON<List<CourseCategory>, CourseCategory>(
          decodedResponse['rows']);
    } catch (e) {
      rethrow;
    }
  }
}
