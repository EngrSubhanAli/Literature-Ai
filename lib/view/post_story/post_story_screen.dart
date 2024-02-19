import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/edit_profile/edit_profile_screen.dart';

class PostStoryScreen extends StatefulWidget {
  const PostStoryScreen({super.key});

  @override
  State<PostStoryScreen> createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: SizedBox(
        height: 1.sh,
        child: Column(
          children: [
            VerticalSizedBox(vertical: 20.h),
            Row(
              children: [
                HorizontalSizedBox(horizontalSpace: 15.w),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                const Spacer(),
                CustomText(
                  text: "Post Story",
                  fontSize: 19.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                HorizontalSizedBox(horizontalSpace: 25.w),
              ],
            ),
            SizedBox(height: 40.h),
            Row(
              children: [
                HorizontalSizedBox(horizontalSpace: 25.w),
                CustomText(
                  text: "Title",
                  fontSize: 16.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            EditProfileCustomTextField(
              controller: titlecontroller,
              scrollarea: 4,
              hintText: "",
              obscureText: false,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                HorizontalSizedBox(horizontalSpace: 25.w),
                CustomText(
                  text: "Input Story Description",
                  fontSize: 16.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            EditProfileCustomTextField(
              maxlength: 500,
              customLines: 5,
              scrollarea: 10,
              controller: desccontroller,
              obscureText: false,
              hintText: "",
            ),
            SizedBox(height: 70.h),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.generatestory);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Image.asset(
                  ai,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            const CustomGradientButton(buttonText: "Post Now"),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    )));
  }
}
