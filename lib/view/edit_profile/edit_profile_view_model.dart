import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';

class EditProfileViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

//////loading state function/////
  void changeLoadingState() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  /////Dispose Funtion/////
  void disposeLoginControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmpassController = TextEditingController();
  }

  Future<void> editProfile(String emailController,String passController ,String nameController ) async {
    changeLoadingState();
    notifyListeners();
    bool inavalidUserName = false;
    bool invalidemail = false;
    bool passwordinavild = false;
    bool passswordidnotmatch = false;
    if (nameController != "") {
      if (nameController.length < 3) {
        inavalidUserName = true;
        showToast("Username should be atleast 3 characters");
        changeLoadingState();
        notifyListeners();
      }
    }

    if (emailController != "") {
      if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(emailController.toString()) !=
          true) {
        invalidemail = true;
        showToast("Enter a valid email address");
        changeLoadingState();
        notifyListeners();
      }
    }

    if (passController != "") {
      if (passController.length < 8) {
        passwordinavild = true;
        showToast("Password should be atleast 8 characters");
        changeLoadingState();
        notifyListeners();
      }
    }

    if (passController != confirmpassController.text) {
      passswordidnotmatch = true;
      showToast("Password donot Match");
      changeLoadingState();
      notifyListeners();
    }

    if (inavalidUserName == false &&
        invalidemail == false &&
        passswordidnotmatch == false &&
        passwordinavild == false) {
      if (nameController != "") {
        userData!.username = nameController;
        showToast("UserName changed");
      }

      if (emailController != "") {
        await changeEmail(emailController, userData!.password!);
        userData!.email = emailController;
        showToast("Email changed");
      }

      if (passController != "") {
        await changePassword(passController);
        userData!.password = passController;

        showToast("Password changed");
      }
      await FirebaseDBService.userCollection
          .doc(userData!.uid)
          .set(userData!.toMap());

      debugPrint("changes Doneeeeeee");
      changeLoadingState();
      notifyListeners();
    }
  }

  showToast(String value) {
    Fluttertoast.showToast(
      msg: value,
      // toastLength: Toast
      //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // Time duration for iOS and web
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> changePassword(String newPassword) async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the user is signed in
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: userData!.password!);

        // Re-authenticate the user with the credential
        await user.reauthenticateWithCredential(credential);
        // Update the user's password
        await user.updatePassword(newPassword);

        debugPrint('Password changed successfully.');
      } else {
        debugPrint('No user signed in.');
      }
    } catch (e) {
      debugPrint('Failed to change password: $e');
    }
  }

  Future<void> changeEmail(String newEmail, String password) async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the user is signed in
      if (user != null) {
        // Create a credential using the user's email and password

        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);

        // Re-authenticate the user with the credential
        await user.reauthenticateWithCredential(credential);

        // Update the user's email address
        await user.delete();

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: newEmail, password: password);

        debugPrint('Email address changed successfully.');
      } else {
        debugPrint('No user signed in.');
      }
    } catch (e) {
      debugPrint('Failed to change email address: $e');
    }
  }
}
