import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/index.dart';
import '../models/index.dart' as model;
import '../services/index.dart';

class TutorProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  List<model.Tutor> _tutors = [];
  List<model.FavoriteTutor> _favoriteTutors = [];
  final String? _authToken;

  TutorProvider(this._authToken, this._tutors);

  List<model.Tutor> get tutors {
    return [..._tutors];
  }

  List<model.FavoriteTutor> get favoriteTutors {
    return [..._favoriteTutors];
  }

  Future fetchAndSetTutors({required int page, required int perPage}) async {
    try {
      // * e.g: GET https://domain.com/tutor/more?perPage=#&page=#
      final url = Uri.parse('$_baseURL/tutor/more?perPage=$perPage&page=$page');
      final headers = model.Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw model.HttpException(decodedResponse['message']);
      }
      final tutorsList = decodedResponse['tutors']['rows'] as List<dynamic>;
      final favoriteList = decodedResponse['favoriteTutor'] as List<dynamic>;
      _tutors = Generic.fromJSON<List<model.Tutor>, model.Tutor>(tutorsList);
      _favoriteTutors =
          Generic.fromJSON<List<model.FavoriteTutor>, model.FavoriteTutor>(favoriteList);
      notifyListeners();
    } catch (error) {
      await Analytics.crashEvent(
        'fetchAndSetTutors',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future fetchAndSetTutorsWithFilters(
      {required int page,
      required int perPage,
      List<String> specialties = const [],
      String search = ''}) async {
    try {
      // * e.g POST https://domain.com/tutor/search
      final url = Uri.parse('$_baseURL/tutor/search');
      final headers = model.Http.getHeaders(token: _authToken as String);
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
        throw model.HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['rows'] as List<dynamic>;
      _tutors = Generic.fromJSON<List<model.Tutor>, model.Tutor>(jsonList);
      notifyListeners();
    } catch (error) {
      await Analytics.crashEvent(
        'fetchAndSetTutorsWithFilters',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future<model.Tutor> searchTutorByID(String id) async {
    try {
      // * e.g: GET https://domain.com/tutor/:tutorId
      final url = Uri.parse('$_baseURL/tutor/$id');
      final headers = model.Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw model.HttpException(decodedResponse['message']);
      }
      return Generic.fromJSON<model.Tutor, void>(decodedResponse);
    } catch (error) {
      await Analytics.crashEvent(
        'searchTutorByID',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future<List<model.Feedback>> getTutorFeedbacks({
    required int page,
    required int perPage,
    required String tutorId,
  }) async {
    try {
      // * e.g: GET https://domain.com/feedback/v2/:id?page=#&perPage=#
      final url = Uri.parse('$_baseURL/feedback/v2/$tutorId?page=$page&perPage=$perPage');
      final headers = model.Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw model.HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['data']['rows'];
      final feedbacks = Generic.fromJSON<List<model.Feedback>, model.Feedback>(jsonList);
      feedbacks.sort((f1, f2) => f2.createdAt!.millisecondsSinceEpoch
          .compareTo(f1.createdAt!.millisecondsSinceEpoch));
      return feedbacks;
    } catch (error) {
      await Analytics.crashEvent(
        'getTutorFeedbacks',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future toggleFavorite(String tutorId) async {
    try {
      // * e.g: POST https://domain.com/user/manageFavoriteTutor
      final url = Uri.parse('$_baseURL/user/manageFavoriteTutor');
      final headers = model.Http.getHeaders(token: _authToken as String);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(
          {'tutorId': tutorId},
        ),
      );
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        throw model.HttpException(decodedResponse['message']);
      }
      final index =
          _favoriteTutors.indexWhere((element) => element.tutorInfo!.userId == tutorId);
      if (index != -1) {
        _favoriteTutors.removeAt(index);
      }
      notifyListeners();
    } catch (error) {
      await Analytics.crashEvent(
        'toggleFavorite',
        exception: error.toString(),
        fatal: true,
      );
      rethrow;
    }
  }
}
