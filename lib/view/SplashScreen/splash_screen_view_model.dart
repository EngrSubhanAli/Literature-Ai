import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/BlockedScreen/blocked_screen.dart';
import 'package:mvvm/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:mvvm/view/testChat.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_screen.dart';

class SplashScreenViewModel extends ChangeNotifier {
  Future<void> isUserLoggedIn(bool onboardingDone) async {
    bool check = await FirebaseDBService().checkUserIsLoggedIn();

    if (check) {
      await FirebaseDBService().getUser().then((value) => {
            if (userData!.blocked == true)
              {
                Get.offAll(
                  const BlockedScreen(),
                )
              }
            else
              {
                Get.offAll(
                  // MessageChatScreen(),
                  AppMainScreen(),
                )
              }
          });
    } else {
      if (onboardingDone) {
        Get.offAll(
          const SignInScreen(),
        );
      }
    }
  }
}
