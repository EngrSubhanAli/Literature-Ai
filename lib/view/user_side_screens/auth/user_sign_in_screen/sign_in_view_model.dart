import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/bottom_navigation/bottom_navigation_bar.dart';

class LogInViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void disposeLoginControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<String> loginUser() async {
    changeLoadingState();

    String status = await FirebaseDBService()
        .loginUser(emailController.text, passwordController.text);
    changeLoadingState();
    if (status == "Sucess") {
      Get.offAll(
        AppMainScreen(),
      );

      return status;
    }
    return status;
  }

  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
