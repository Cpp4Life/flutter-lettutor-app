import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  late int _index = 0;

  int get index {
    return _index;
  }

  set index(int idx) {
    _index = idx;
    notifyListeners();
  }
}
