import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/index.dart';
import '../models/index.dart';

class TutorProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  List<Tutor> _tutors = [];
  final String? _authToken;

  TutorProvider(this._authToken, this._tutors);

  List<Tutor> get tutors {
    return [..._tutors];
  }

  Future fetchAndSetTutors({required int page, required int perPage}) async {
    try {
      // * e.g: https://domain.com/tutor/more?perPage=#&page=#
      final url = Uri.parse('$_baseURL/tutor/more?perPage=$perPage&page=$page');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['tutors']['rows'] as List<dynamic>;
      _tutors = Generic.fromJSON<List<Tutor>, Tutor>(jsonList);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future fetchAndSetTutorsWithFilters(
      {required int page,
      required int perPage,
      List<String> specialties = const [],
      String search = ''}) async {
    try {
      // * e.g https://domain.com/tutor/search
      final url = Uri.parse('$_baseURL/tutor/search');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(
          {
            'filters': {
              'specialties': specialties,
            },
            'page': page,
            'perPage': perPage,
            'search': search,
          },
        ),
      );
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['rows'] as List<dynamic>;
      _tutors = Generic.fromJSON<List<Tutor>, Tutor>(jsonList);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
