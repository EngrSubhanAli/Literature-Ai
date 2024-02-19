import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool _condition = true;

  bool get condition => _condition;

  void toggleCondition(bool condition) {
    _condition = condition;
    notifyListeners(); // Notify listeners about the change
  }
}
