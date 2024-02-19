import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

class ForgetSuccess extends StatefulWidget {
  const ForgetSuccess({super.key});

  @override
  State<ForgetSuccess> createState() => _ForgetSuccessState();
}

class _ForgetSuccessState extends State<ForgetSuccess> {
  bool? platform;
  @override
  void initState() {
    platform = Platform.isAndroid;

    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage(background), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Padding(
              padding: EdgeInsets.only(top: 120.sp),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      doneGig,
                      width: 240.w,
                      height: 240.h,
                    ),
                  ),
                  VerticalSizedBox(vertical: 60.h),
                  CustomText(
                    text:
                        "Reset password link has been send to your email please login to your email",
                    textAlign: TextAlign.center,
                    fontSize: 14.sp,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                  VerticalSizedBox(vertical: 70.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signIn);
                      // Get.to(const SignInScreen());
                    },
                    child: const CustomGradientButton(buttonText: "Done"),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
