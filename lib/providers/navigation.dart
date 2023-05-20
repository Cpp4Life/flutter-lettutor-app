import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  late int _index = 0;

  int get index {
    return _index;
  }

  void moveToTab(int idx, {bool isLogout = false}) {
    _index = idx;
    if (!isLogout) notifyListeners();
  }
}
