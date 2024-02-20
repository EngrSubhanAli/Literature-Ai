import 'package:flutter/material.dart';
import 'package:mvvm/Core/constant/constan.dart';

class HomeProvider extends ChangeNotifier {
  bool _condition = true;
  bool get condition => _condition;
  void toggleCondition(bool condition) {
    _condition = condition;

    notifyListeners(); // Notify listeners about the change
  }

  String _setStateForHome = AppConstants.fromhome;
  String get setStateForHome => _setStateForHome;
  void setStateforHome(String setStateforHome) {
    _setStateForHome = setStateforHome;

    notifyListeners(); // Notify listeners about the change
  }
}
