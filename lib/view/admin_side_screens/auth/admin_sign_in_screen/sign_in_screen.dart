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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? platform;
  @override
  void initState() {
    platform = Platform.isAndroid;

    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
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
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
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
                  text: "Login to your account",
                  fontSize: 24.sp,
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text:
                      "Enter your information below or continue with  account",
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
                  title: "Password",
                  placeholder: "Create Password",
                  textController: passController,
                  suffixicon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: greyColor,
                  ),
                  obscure: true,
                  prefixIcon: Icons.lock,
                ),
                VerticalSizedBox(vertical: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.forgetpass);
                        // Get.to(const ForgetPassword());
                      },
                      child: CustomText(
                        text: "Forgot Password",
                        fontSize: 14.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
                VerticalSizedBox(vertical: 20.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.bottombarscreen);
                  },
                  child: const CustomGradientButton(buttonText: "Continue"),
                ),
                VerticalSizedBox(vertical: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Don't have an account?",
                      fontSize: 14.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.signUp);

                        // Get.to(const SignInScreen());
                      },
                      child: CustomText(
                        text: " Sign Up",
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
        ),
      )),
    );
  }
}
