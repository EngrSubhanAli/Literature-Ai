import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/Components/textfield_container.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_view_model.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  bool? platform;
  @override
  void initState() {
    platform = Platform.isAndroid;
    final loginProvider = Provider.of<LogInViewModel>(context, listen: false);
    loginProvider.disposeLoginControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LogInViewModel>(context);
    final homeProvider = Provider.of<HomeScreenViewModel>(context);
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
            child: Form(
              key: formKey,
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
                    maxLines: 20,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 16.h),
                  TextFieldContainer(
                    title: "Email",
                    validator: (value) {
                      if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value.toString()) ==
                          false) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    placeholder: "Enter your email",
                    textController: loginProvider.emailController,
                    suffixicon: const SizedBox(),
                    obscure: false,
                    prefixIcon: Icons.email,
                  ),
                  VerticalSizedBox(vertical: 10.h),
                  TextFieldContainer(
                    title: "Password",
                    validator: (value) {
                      if (value == null || value.trim().length < 8) {
                        return 'Password must contain 8 characters';
                      }

                      return null;
                    },
                    placeholder: "Create Password",
                    textController: loginProvider.passwordController,
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
                          text: "Forgot Password ?",
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
                    onTap: loginProvider.isLoading
                        ? () {}
                        : () async {
                            homeProvider.currentIndexCondition(0);
                            homeProvider.toggleCondition(true);
                            print(homeProvider.currentIndex);
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await loginProvider.loginUser().then((value) {
                                if (value != "Sucess") {
                                  value = value.replaceAll(
                                      "[firebase_auth/invalid-credential] ",
                                      "");

                                  Fluttertoast.showToast(
                                    msg: value,
                                    // toastLength: Toast
                                    //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
                                    gravity: ToastGravity
                                        .BOTTOM, // Top, Center, Bottom
                                    timeInSecForIosWeb:
                                        1, // Time duration for iOS and web
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              });
                            }
                          },
                    child: loginProvider.isLoading
                        ? const CircularProgressIndicator()
                        : const CustomGradientButton(buttonText: "Continue"),
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
                              width: 120.w,
                              height: 70.h,
                            )
                          : Image.asset(
                              apple,
                              width: 120.w,
                              height: 70.h,
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
