import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_screen.dart';

class ProfileViewModel extends ChangeNotifier {
 

  bool _isLoading = false;
  bool get isLoading => _isLoading;

//////loading state function/////
  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }


  ///Upload Story////
  Future<String> deleteUser() async {
    changeLoadingState();
    try {

      await FirebaseDBService().reauthenticateAndDeleteAccount();
       Get.offAll(const SignInScreen());
      changeLoadingState();
      return "Sucess";
    } catch (e) {
      changeLoadingState();
      return e.toString();
    }
  }
}
