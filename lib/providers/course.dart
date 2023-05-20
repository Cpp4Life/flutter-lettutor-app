import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/index.dart';
import '../helpers/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class CourseProvider with ChangeNotifier {
  final String _baseURL = Config.baseUrl;
  final String? _authToken;

  List<Course> _courses = [];

  List<Course> get courses {
    return [..._courses];
  }

  CourseProvider(this._authToken, this._courses);

  Future<List<CourseCategory>> fetchAndSetCourseCategory() async {
    try {
      // * e.g: https://domain.com/content-category
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
      await Analytics.crashEvent(
        'fetchAndSetCourseCategory',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future fetchAndSetCoursesWithPagination({
    required int page,
    required int size,
    String q = '',
    String categoryId = '',
  }) async {
    try {
      // * e.g: GET https://domain.com/course?page=#&size=#
      // * e.g: GET https://domain.com/course?page=#&size=#&q=""
      // * e.g: GET https://domain.com/course?page=#&size=#&categoryId[]=""
      // * e.g: GET https://domain.com/course?page=#&size=#&q=""&categoryId[]=""
      String urlBuilder = '$_baseURL/course?page=$page&size=$size';
      if (q.isNotEmpty) {
        urlBuilder += '&q=$q';
      }
      if (categoryId.isNotEmpty) {
        urlBuilder += '&categoryId[]=$categoryId';
      }

      final url = Uri.parse(urlBuilder);
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['data']['rows'] as List<dynamic>;
      _courses = Generic.fromJSON<List<Course>, Course>(jsonList);
      notifyListeners();
    } catch (e) {
      await Analytics.crashEvent(
        'fetchAndSetCourses',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future<Course> findCourseById(String id) async {
    try {
      // * e.g: https://domain.com/course/:courseId
      final url = Uri.parse('$_baseURL/course/$id');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      return Generic.fromJSON<Course, void>(decodedResponse['data']);
    } catch (e) {
      await Analytics.crashEvent(
        'findCourseById',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }
}
