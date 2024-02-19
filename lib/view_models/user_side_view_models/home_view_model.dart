import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // This method is used to change the current index of the bottom navigation bar
  /// [index] is the index of the bottom navigation bar
  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
