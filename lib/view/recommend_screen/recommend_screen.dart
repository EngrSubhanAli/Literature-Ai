import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/colors.dart';

import 'package:mvvm/utils/routes/routes_name.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        Get.back();
                      }),
                      child: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    CustomText(
                      text: "Recommend ",
                      fontSize: 19.sp,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              VerticalSizedBox(vertical: 50.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  CustomText(
                    text: "Favorite Author ",
                    fontSize: 16.sp,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "",
                number: 1,
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "Optional",
                number: 2,
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "Optional",
                number: 3,
              ),

              //favourite book
              VerticalSizedBox(vertical: 30.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  CustomText(
                    text: "Favorite Book ",
                    fontSize: 16.sp,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "",
                number: 1,
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "Optional",
                number: 2,
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "Optional",
                number: 3,
              ),
              //favourite genre
              VerticalSizedBox(vertical: 30.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  CustomText(
                    text: "Favorite Genre ",
                    fontSize: 16.sp,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "",
                number: 1,
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "Optional",
                number: 2,
              ),
              VerticalSizedBox(vertical: 20.h),
              RecommendTextField(
                hint: "Optional",
                number: 3,
              ),
              const VerticalSizedBox(vertical: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.generatestory);
                },
                child: const CustomGradientButton(buttonText: "Generate"),
              ),
              const VerticalSizedBox(vertical: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RecommendTextField extends StatelessWidget {
  String hint;
  int number;
  RecommendTextField({
    super.key,
    required this.hint,
    required this.number,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15.w),
        Container(
          height: 25.h,
          width: 25.w,
          decoration: const BoxDecoration(
            color: Color(0xffD9D9D9),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(number.toString()),
            ),
          ),
        ),
        HorizontalSizedBox(horizontalSpace: 10.w),
        Container(
          width: 0.8.sw,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: blackColor.withOpacity(0.4)),
            color: whiteColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: lightGrey,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
