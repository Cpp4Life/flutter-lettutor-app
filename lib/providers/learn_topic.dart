import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/index.dart';
import '../helpers/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class LearnTopicProvider with ChangeNotifier {
  final String _baseURL = Config.baseUrl;
  final List<LearnTopic> _learnTopics = [];

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
      await Analytics.crashEvent(
        'fetchAndSetLearnTopics',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }
}
