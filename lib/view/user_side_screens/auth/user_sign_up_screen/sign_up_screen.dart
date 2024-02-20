import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/Components/textfield_container.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_screen.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_up_screen/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? platform;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    platform = Platform.isAndroid;

    final registerProvider =
        Provider.of<SignUpViewModel>(context, listen: false);
    registerProvider.disposesignupControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<SignUpViewModel>(context);
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
                  text: "Create your account",
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
                  title: "UserName",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a valid username';
                    }
                    return null;
                  },
                  placeholder: "Enter your username",
                  textController: registerProvider.userNameController,
                  suffixicon: const SizedBox(),
                  obscure: false,
                  prefixIcon: Icons.person,
                ),
                VerticalSizedBox(vertical: 10.h),
                TextFieldContainer(
                  title: "Email",
                  placeholder: "Enter your email",
                  validator: (value) {
                    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value.toString()) ==
                        false) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  textController: registerProvider.emailController,
                  suffixicon: const SizedBox(),
                  obscure: false,
                  prefixIcon: Icons.email,
                ),
                VerticalSizedBox(vertical: 10.h),
                TextFieldContainer(
                  title: "Mobile Number",
                  placeholder: "Your mobile number",
                  textController: registerProvider.phoneController,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Enter a valid phone number';
                    }

                    return null;
                  },
                  suffixicon: const SizedBox(),
                  obscure: false,
                  prefixIcon: Icons.phone_iphone,
                ),
                VerticalSizedBox(vertical: 10.h),
                TextFieldContainer(
                  title: "Password",
                  placeholder: "Create Password",
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Password must contain 8 characters';
                    }

                    return null;
                  },
                  textController: registerProvider.passwordController,
                  suffixicon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: greyColor,
                  ),
                  obscure: true,
                  prefixIcon: Icons.lock,
                ),
                VerticalSizedBox(vertical: 30.h),
                InkWell(
                    onTap: registerProvider.isLoading
                        ? () {}
                        : () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await registerProvider
                                  .saveRegisteredUser(context)
                                  .then((value) {
                                if (value != "Sucess") {
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
                    child:registerProvider.isLoading?const CircularProgressIndicator(): const CustomGradientButton(buttonText: "Continue")),
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
        ),
      )),
    );
  }
}
