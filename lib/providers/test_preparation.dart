import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/index.dart';
import '../helpers/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class TestPreparationProvider with ChangeNotifier {
  final String _baseURL = Config.baseUrl;
  List<TestPreparation> _tests = [];

  List<TestPreparation> get tests {
    return [..._tests];
  }

  Future<List<TestPreparation>> fetchAndSetTests() async {
    try {
      // * e.g: https://domain.com/test-preparation
      final url = Uri.parse('$_baseURL/test-preparation');
      final response = await http.get(url);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      _tests = Generic.fromJSON<List<TestPreparation>, TestPreparation>(decodedResponse);
      return [..._tests];
    } catch (error) {
      await Analytics.crashEvent(
        'fetchAndSetTests',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }
}
