// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/custom_app_bar2.dart';
import 'package:mvvm/Core/Components/custom_appbar.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/view/home_screen/home_screen.dart';

// ignore: must_be_immutable
class StoryDetailScreen extends StatefulWidget {
  String imageURL;
  String name;
  String time;
  String title;
  String description;
  int? rank;
  int likes;
  int dislikes;
  StoryDetailScreen({
    Key? key,
    required this.imageURL,
    this.rank,
    required this.name,
    required this.time,
    required this.title,
    required this.description,
    required this.likes,
    required this.dislikes,
  }) : super(key: key);

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: 1.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    background), // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                CusotmAppBar2(color: Colors.transparent, text: "Full Story"),
                VerticalSizedBox(vertical: 20.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 65.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            bage2,
                          ), // Replace with your image asset path
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: widget.rank.toString(),
                            fontSize: 28.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          VerticalSizedBox(vertical: 35.h),
                        ],
                      ),
                    ),
                  ],
                ),
                const VerticalSizedBox(vertical: 10),
                CustomText(
                  text: "Top Rated Stories",
                  fontSize: 23.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
                VerticalSizedBox(vertical: 15.h),
                Row(
                  children: [
                    const HorizontalSizedBox(horizontalSpace: 13),
                    Image.asset(
                      widget.imageURL,
                      height: 40.h,
                      width: 40.w,
                    ),
                    HorizontalSizedBox(horizontalSpace: 10.w),
                    CustomText(
                      text: widget.name,
                      fontSize: 12.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    HorizontalSizedBox(horizontalSpace: 25.w),
                    CustomText(
                      text: widget.time,
                      fontSize: 10.sp,
                      color: greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                    const Spacer(),
                    const ReportPostButton(),
                  ],
                ),
                VerticalSizedBox(vertical: 15.h),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: widget.title,
                      fontSize: 18.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VerticalSizedBox(vertical: 10.h),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: widget.description,
                      fontSize: 15.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    const HorizontalSizedBox(horizontalSpace: 15),
                    Image.asset(
                      like,
                      height: 17.h,
                      width: 17.w,
                    ),
                    HorizontalSizedBox(horizontalSpace: 7.sp),
                    CustomText(
                      text: widget.likes.toString(),
                      fontSize: 9.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w300,
                    ),
                    HorizontalSizedBox(horizontalSpace: 15.sp),
                    Transform.rotate(
                      angle: 3.14,
                      child: Image.asset(
                        like,
                        height: 17.h,
                        width: 17.w,
                      ),
                    ),
                    HorizontalSizedBox(horizontalSpace: 7.sp),
                    CustomText(
                      text: widget.dislikes.toString(),
                      fontSize: 9.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                const CustomGradientButton(buttonText: "Done")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
