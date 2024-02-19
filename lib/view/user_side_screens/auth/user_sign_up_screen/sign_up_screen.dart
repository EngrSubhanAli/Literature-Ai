import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/Components/textfield_container.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/view/admin_side_screens/auth/admin_sign_in_screen/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? platform;
  @override
  void initState() {
    platform = Platform.isAndroid;
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          // height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage(background), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 45.h),
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
                text: "Create your account",
                fontSize: 24.sp,
                color: blackColor,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: "Enter your information below or continue with  account",
                textAlign: TextAlign.center,
                fontSize: 14.sp,
                color: greyColor,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 16.h),
              TextFieldContainer(
                title: "Email",
                placeholder: "Enter your email",
                textController: emailController,
                suffixicon: const SizedBox(),
                obscure: false,
                prefixIcon: Icons.email,
              ),
              VerticalSizedBox(vertical: 10.h),
              TextFieldContainer(
                title: "Mobile Number",
                placeholder: "Your mobile number",
                textController: phoneController,
                suffixicon: const SizedBox(),
                obscure: false,
                prefixIcon: Icons.phone_iphone,
              ),
              VerticalSizedBox(vertical: 10.h),
              TextFieldContainer(
                title: "Password",
                placeholder: "Create Password",
                textController: passwordController,
                suffixicon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: greyColor,
                ),
                obscure: true,
                prefixIcon: Icons.lock,
              ),
              VerticalSizedBox(vertical: 30.h),
              const CustomGradientButton(buttonText: "Continue"),
              VerticalSizedBox(vertical: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account?",
                    fontSize: 14.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, RoutesName.signIn);
                      // print(RoutesName.signIn);
                      Get.to(const SignInScreen());
                    },
                    child: CustomText(
                      text: " Log in",
                      fontSize: 14.sp,
                      color: baseColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              VerticalSizedBox(vertical: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SizedBox(
                  width: 1.sw,
                  child: Row(
                    children: [
                      Container(
                        height: 1.h,
                        width: 120.w,
                        color: greyColor,
                      ),
                      const Spacer(),
                      CustomText(
                        text: "OR",
                        fontSize: 14.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                      const Spacer(),
                      Container(
                        height: 1.h,
                        width: 120.w,
                        color: greyColor,
                      ),
                    ],
                  ),
                ),
              ),
              VerticalSizedBox(vertical: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Platform.isAndroid == platform
                      ? Image.asset(
                          google,
                          width: 140.w,
                          height: 80.h,
                        )
                      : Image.asset(
                          apple,
                          width: 140.w,
                          height: 80.h,
                        ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
