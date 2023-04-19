import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/index.dart';
import '../models/index.dart';

class LearnTopicProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  List<LearnTopic> _learnTopics = [];

  List<LearnTopic> get learnTopics {
    return [..._learnTopics];
  }

  Future<List<LearnTopic>> fetchAndSetLearnTopics() async {
    try {
      // * e.g: https://domain.com/learn-topic
      final url = Uri.parse('$_baseURL/learn-topic');
      final response = await http.get(url);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      return Generic.fromJSON<List<LearnTopic>, LearnTopic>(decodedResponse);
    } catch (error) {
      rethrow;
    }
  }
}
