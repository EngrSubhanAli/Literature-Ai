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
import 'package:mvvm/view/forget_password/forget_passwor_view_model.dart';
import 'package:mvvm/view/forget_password/forget_success.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool? platform;
  final formKey=GlobalKey<FormState>();
  @override
  void initState() {
    platform = Platform.isAndroid;
    final forgetPasswordProvider =
        Provider.of<ForgetPasswordViewModel>(context, listen: false);
    forgetPasswordProvider.disposezForgetPasswordControllers();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
      final forgetPasswordProvider =
        Provider.of<ForgetPasswordViewModel>(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                      validator: (value) {
          if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value.toString()) ==
              false) {
            return 'Please enter a valid email address';
          }
          return null;
                },
                      placeholder: "Enter your email",
                      textController: forgetPasswordProvider.emailController,
                      suffixicon: const SizedBox(),
                      obscure: false,
                      prefixIcon: Icons.email,
                    ),
                    VerticalSizedBox(vertical: 100.h),
                    GestureDetector(
                      onTap:forgetPasswordProvider.isLoading?(){}: () {
                        _sendCode(forgetPasswordProvider);
                  
                        // Get.to(const ForgetSuccess());
                      },
                      child:forgetPasswordProvider.isLoading?const CircularProgressIndicator(): const CustomGradientButton(buttonText: "Continue"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
  Future<void> _sendCode(ForgetPasswordViewModel forgetpasswordProvider) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await forgetpasswordProvider.sendForgetPasswordLink().then((value) {
        if (value != "Sucess") {
          print("Hiiiiiii22"+value.toString());
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
        } else {
                  print("Hiiiiiii11"+value.toString());
          Get.to(const ForgetSuccess());
          

     
        }
      });
    }
  }
}
