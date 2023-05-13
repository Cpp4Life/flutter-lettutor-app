import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';

class AppProvider with ChangeNotifier {
  static late Language _language;

  Language get language {
    return _language;
  }

  static set updateChange(String value) {}

  static init() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.get('language');
    _language = lang == Locale.vi ? Vietnamese() : Vietnamese();
  }
}
