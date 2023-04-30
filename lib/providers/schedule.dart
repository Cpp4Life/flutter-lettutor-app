import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../helpers/index.dart';
import '../models/index.dart';

class ScheduleProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;
  List<Schedule> _schedules = [];
  List<BookingInfo> _bookingInfo = [];

  List<Schedule> get schedules {
    return [..._schedules];
  }

  List<BookingInfo> get bookings {
    return [..._bookingInfo];
  }

  ScheduleProvider(this._authToken, this._schedules);

  Future fetchAndSetSchedules(String tutorId) async {
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
      _removeOutDatedSchedule();
      _groupSchedule();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future bookClass(String scheduleDetailIds, Function callback) async {
    try {
      // * e.g: POST https://domain.com/booking
      final url = Uri.parse('$_baseURL/booking');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'scheduleDetailIds': [scheduleDetailIds],
        }),
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      _updateBookedStatus(scheduleDetailIds);
      await callback();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future cancelBooking(String scheduleDetailIds, Function callback) async {
    try {
      // * e.g: DELETE https://domain.com/booking
      final url = Uri.parse('$_baseURL/booking');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.delete(
        url,
        headers: headers,
        body: jsonEncode({
          'scheduleDetailIds': [scheduleDetailIds],
        }),
      );
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(decodedResponse['message']);
      }
      await callback();
      _bookingInfo.removeWhere((element) => element.id == scheduleDetailIds);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future fetchAndSetUpcomingClass({required int page, required int perPage}) async {
    try {
      // * e.g: https://domain.com/booking/list/student?page=#&perPage=#&dateTimeLte=#&orderBy=meeting&sortBy=desc
      final now = DateTime.now().millisecondsSinceEpoch;
      final url = Uri.parse(
          '$_baseURL/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=asc');
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['data']['rows'] as List<dynamic>;
      _bookingInfo = Generic.fromJSON<List<BookingInfo>, BookingInfo>(jsonList);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void _updateBookedStatus(String scheduleDetailIds) {
    _schedules.forEach((schedule) {
      final idx = schedule.scheduleDetails!
          .indexWhere((element) => element.id == scheduleDetailIds);
      if (idx != -1) {
        schedule.scheduleDetails![idx].isBooked = true;
        return;
      }
    });
  }

  void _removeOutDatedSchedule() {
    // only get schedules that is greater or equal to the current day
    _schedules = _schedules.where((element) {
      final now = DateTime.now();
      final startTime = DateTime.fromMillisecondsSinceEpoch(element.startTimestamp!);
      return startTime.isAfter(now) || isDateEqual(startTime, now);
    }).toList();
    _schedules.sort((s1, s2) => s1.startTimestamp!.compareTo(s2.startTimestamp!));
  }

  void _groupSchedule() {
    Map<String, List<ScheduleDetails>> timestamp = {};
    final List<Schedule> newSchedule = [];

    // get all periods of a day
    _schedules.forEach((element) {
      final startTime = DateTime.fromMillisecondsSinceEpoch(element.startTimestamp!);
      final formattedDate = DateFormat('yyyy-MM-dd').format(startTime);
      if (timestamp.containsKey(formattedDate)) {
        timestamp[formattedDate]!.addAll(element.scheduleDetails!);
      } else {
        timestamp[formattedDate] = List.from(element.scheduleDetails!);
        newSchedule.add(element);
      }
    });

    // combine all periods into the same day
    timestamp.forEach((key, value) {
      final index = newSchedule.indexWhere((element) {
        final startTime = DateTime.fromMillisecondsSinceEpoch(element.startTimestamp!);
        final formattedDate = DateFormat('yyyy-MM-dd').format(startTime);
        return formattedDate == key;
      });
      newSchedule[index].scheduleDetails = value;
    });

    // set _schedules
    _schedules = newSchedule;
  }
}
