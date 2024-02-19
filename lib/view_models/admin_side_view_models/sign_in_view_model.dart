import 'package:flutter/material.dart';

class AdminSignInViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // This method is used to change the loading state
  // If the value of [_isLoading] is true, it will be changed to false and vice versa
  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
