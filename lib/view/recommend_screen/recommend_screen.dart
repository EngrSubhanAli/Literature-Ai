import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/custom_app_bar2.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/Components/textfield_container.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';

import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/generate_story/generate_story_screen.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  TextEditingController author1 = TextEditingController();
  TextEditingController author2 = TextEditingController();
  TextEditingController author3 = TextEditingController();
  TextEditingController book1 = TextEditingController();
  TextEditingController book2 = TextEditingController();
  TextEditingController book3 = TextEditingController();
  TextEditingController genre1 = TextEditingController();
  TextEditingController genre2 = TextEditingController();
  TextEditingController genre3 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    author1 = TextEditingController();
    author2 = TextEditingController();
    author3 = TextEditingController();
    book1 = TextEditingController();
    book2 = TextEditingController();
    book3 = TextEditingController();
    genre1 = TextEditingController();
    genre2 = TextEditingController();
    genre3 = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CusotmAppBar2(text: "Recommend", color: Colors.transparent),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VerticalSizedBox(vertical: 30.h),
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
              controller: author1,
              valdator: (value) {
                if (value == "") {
                  return 'You need to add atleast 1  favourite author';
                }

                return null;
              },
              hint: "",
              number: 1,
            ),
            VerticalSizedBox(vertical: 20.h),
            RecommendTextField(
              controller: author2,
              valdator: (value) {
                return null;
              },
              hint: "Optional",
              number: 2,
            ),
            VerticalSizedBox(vertical: 20.h),
            RecommendTextField(
              controller: author3,
              valdator: (value) {
                return null;
              },
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
              controller: book1,
              hint: "",
              valdator: (value) {
                if (value == "") {
                  return 'You need to add atleast 1  favourite book';
                }

                return null;
              },
              number: 1,
            ),
            VerticalSizedBox(vertical: 20.h),
            RecommendTextField(
              controller: book2,
              hint: "Optional",
              valdator: (value) {
                return null;
              },
              number: 2,
            ),
            VerticalSizedBox(vertical: 20.h),
            RecommendTextField(
              controller: book3,
              valdator: (value) {
                return null;
              },
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
              controller: genre1,
              number: 1,
              valdator: (value) {
                if (value == "") {
                  return 'You need to add atleast 1  favourite genre';
                }

                return null;
              },
            ),
            VerticalSizedBox(vertical: 20.h),
            RecommendTextField(
              controller: genre2,
              valdator: (value) {
                return null;
              },
              hint: "Optional",
              number: 2,
            ),
            VerticalSizedBox(vertical: 20.h),
            RecommendTextField(
              controller: genre3,
              valdator: (value) {
                return null;
              },
              hint: "Optional",
              number: 3,
            ),
            const VerticalSizedBox(vertical: 40),
            GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  String message =
                      "Based on the following books authors , book names and genre suggest me 5  books\nHere is the list of Authors : \n${author1.text}\n${author2.text}\n${author3.text}\nHere is the list of Books : \n${book1.text}\n${book2.text}\n${book3.text}\nHere is the list of Genre : \n${genre1.text}\n${genre2.text}\n${genre3.text}";

                  Get.to(GenerateStoryScreen(
                    preresponse: message,
                  ));
                }
              },
              child: const CustomGradientButton(buttonText: "Generate"),
            ),
            const VerticalSizedBox(vertical: 40),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RecommendTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  int number;
  FormValidator valdator;
  RecommendTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.number,
      required this.valdator});
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
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: lightGrey,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            validator: valdator,
          ),
        ),
      ],
    );
  }
}
