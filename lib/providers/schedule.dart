import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScheduleProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;

  ScheduleProvider(this._authToken);
}
