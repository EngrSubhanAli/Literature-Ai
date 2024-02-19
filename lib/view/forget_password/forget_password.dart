import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/Components/textfield_container.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
              padding: EdgeInsets.only(top: 100.sp),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      logo,
                      width: 90.w,
                      height: 55.h,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  CustomText(
                    text: "Forget Password",
                    fontSize: 24.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text:
                        "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.",
                    textAlign: TextAlign.center,
                    fontSize: 14.sp,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 20.h),
                  TextFieldContainer(
                    title: "Email",
                    placeholder: "Enter your email",
                    textController: emailController,
                    suffixicon: const SizedBox(),
                    obscure: false,
                    prefixIcon: Icons.email,
                  ),
                  VerticalSizedBox(vertical: 100.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.forgetsuccess);
                      // Get.to(const ForgetSuccess());
                    },
                    child: const CustomGradientButton(buttonText: "Continue"),
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
