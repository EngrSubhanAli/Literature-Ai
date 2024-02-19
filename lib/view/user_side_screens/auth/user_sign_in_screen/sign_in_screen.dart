import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

class UserSignInScreen extends StatelessWidget {
  const UserSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.home);
              //Getx Navigation
              //Get.toNamed(RoutesName.homeGetx);
            },
            child: const Text('User Sign In Screen')),
      ),
    );
  }
}
