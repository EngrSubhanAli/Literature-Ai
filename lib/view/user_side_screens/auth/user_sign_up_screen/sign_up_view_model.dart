import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvm/models/user_data_model.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/bottom_navigation/bottom_navigation_bar.dart';

class SignUpViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();

  void disposesignupControllers() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
  }

  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<String> saveRegisteredUser(BuildContext context) async {
    changeLoadingState();

    UserModel userData = UserModel(
        uid: "",
        email: emailController.text,
        blocked: false,
        createdAt: DateTime.now(),
        password: passwordController.text,
        picUrl: "",
        reported: false,
        username: userNameController.text);
        String status = await FirebaseDBService().registerUser(userData);
    changeLoadingState();
    if (status == "Sucess") {
    // ignore: use_build_context_synchronously
   Get.offAll(AppMainScreen());

      return status;
    }
    return status;
  }
}
