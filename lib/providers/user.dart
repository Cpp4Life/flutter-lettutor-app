import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../helpers/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class UserProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;
  User? _user;

  UserProvider(this._authToken);

  User get user {
    return _user ?? User(id: const Uuid().v4());
  }

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
      _user = Generic.fromJSON<User, void>(decodedResponse['user']);
      notifyListeners();
      return _user!;
    } catch (e) {
      await Analytics.crashEvent(
        'getUserInfo',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future updateUserInfo({
    String? name,
    String? country,
    String? birthday,
    String? level,
    String? phone,
    List<String>? learnTopics,
    List<String>? testPreparations,
    required Function callback,
  }) async {
    try {
      // * e.g: PUT https://domain.com/user/info
      final url = Uri.parse('$_baseURL/user/info');
      final headers = Http.getHeaders(token: _authToken as String);

      final body = {};
      if (name != null) body.addEntries({'name': name}.entries);
      if (country != null) body.addEntries({'country': country}.entries);
      if (birthday != null) body.addEntries({'birthday': birthday}.entries);
      if (level != null) body.addEntries({'level': level}.entries);
      if (phone != null) body.addEntries({'phone': phone}.entries);
      if (learnTopics != null) body.addEntries({'learnTopics': learnTopics}.entries);
      if (testPreparations != null) {
        body.addEntries({'testPreparations': testPreparations}.entries);
      }

      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        await callback();
      } else {
        throw HttpException('Failed to update user\'s profile! Please try again later');
      }
    } catch (e) {
      await Analytics.crashEvent(
        'updateUserInfo',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future uploadAvatar(String path, String fileName, Function callback) async {
    try {
      // * e.g: POST https://domain.com/user/uploadAvatar
      final url = Uri.parse('$_baseURL/user/uploadAvatar');
      final request = http.MultipartRequest('POST', url);
      final headers = Http.getHeaders(token: _authToken as String);
      final image = await http.MultipartFile.fromPath(
        'avatar',
        path,
        filename: fileName,
      );
      request.files.add(image);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        await callback();
      } else {
        throw HttpException('Oops! Cannot update your avatar.');
      }
    } catch (e) {
      await Analytics.crashEvent(
        'uploadAvatar',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future<int> getTotalLessonTime() async {
    try {
      // * e.g: GET https://domain.com/call/total
      final url = Uri.parse('$_baseURL/call/total');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      return decodedResponse['total'];
    } catch (e) {
      await Analytics.crashEvent(
        'getTotalLessonTime',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }

  Future<BookingInfo?> getUpcoming() async {
    try {
      // * e.g: GET https://domain.com/booking/next?dateTime=#
      final dateTime = DateTime.now().millisecondsSinceEpoch;
      final url = Uri.parse('$_baseURL/booking/next?dateTime=$dateTime');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(
        url,
        headers: headers,
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['data'];
      List<BookingInfo> upcomingLessons =
          Generic.fromJSON<List<BookingInfo>, BookingInfo>(jsonList);
      upcomingLessons.sort(
        (l1, l2) => l1.scheduleDetailInfo!.startPeriodTimestamp!
            .compareTo(l2.scheduleDetailInfo!.startPeriodTimestamp!),
      );

      upcomingLessons = upcomingLessons
          .where((element) => element.scheduleDetailInfo!.endPeriodTimestamp! > dateTime)
          .toList();

      return upcomingLessons.isEmpty ? null : upcomingLessons.first;
    } catch (e) {
      await Analytics.crashEvent(
        'getUpcoming',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }
}
