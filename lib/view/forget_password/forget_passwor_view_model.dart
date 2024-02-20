import 'package:flutter/material.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';



class ForgetPasswordViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void disposezForgetPasswordControllers() {
    emailController = TextEditingController();
  }

  Future<String> sendForgetPasswordLink() async {
    changeLoadingState();

    String status = await FirebaseDBService().forgetPassword(
      emailController.text,
    );
    changeLoadingState();
    if (status == "Sucess") {
      return status;
    }
    return status;
  }

  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}