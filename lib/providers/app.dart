import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';

class AppProvider with ChangeNotifier {
  static late Language _language;

  Language get language {
    return _language;
  }

  set setLanguageTo(Language lang) {
    _language = lang;
    notifyListeners();
  }

  static Future init() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('language')) {
      _language = English();
      return;
    }
    final lang = prefs.getString('language');
    _language = (lang == Locale.vi.name ? Vietnamese() : English());
  }
}
