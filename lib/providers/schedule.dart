import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/index.dart';
import '../models/index.dart';

class ScheduleProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;
  List<Schedule> _schedules = [];

  List<Schedule> get schedules {
    return [..._schedules];
  }

  ScheduleProvider(this._authToken, this._schedules);

  Future getTutorSchedules(String tutorId) async {
    try {
      // * e.g: https://domain.com/schedule
      final url = Uri.parse('$_baseURL/schedule');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'tutorId': tutorId,
        }),
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      _schedules = Generic.fromJSON<List<Schedule>, Schedule>(decodedResponse['data']);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
