import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/models/post_data_model.dart';

class MyStoriesScreen extends StatefulWidget {
  const MyStoriesScreen({super.key});

  @override
  State<MyStoriesScreen> createState() => _MyStoriesScreenState();
}

class _MyStoriesScreenState extends State<MyStoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              children: [
                Icon(
                  Icons.menu,
                  size: 25.sp,
                ),
                const Spacer(),
                Image.asset(
                  logo,
                  height: 35.h,
                  width: 55.w,
                ),
                HorizontalSizedBox(horizontalSpace: 10.w),
                CustomText(
                  text: "LITERATURE.AI",
                  fontSize: 17.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                HorizontalSizedBox(horizontalSpace: 20.w),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: AppMainScreen(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 0.37.sh * posts.length,
            child: Column(
              children: [
                VerticalSizedBox(vertical: 20.sp),
                Row(
                  children: [
                    HorizontalSizedBox(horizontalSpace: 15.sp),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25.sp,
                        color: blackColor,
                      ),
                    ),
                    CustomText(
                      text: "My Stories",
                      fontSize: 27.sp,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                VerticalSizedBox(vertical: 30.h),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  posts[index].imageUrl,
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                HorizontalSizedBox(horizontalSpace: 10.w),
                                CustomText(
                                  text: posts[index].name,
                                  fontSize: 12.sp,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                HorizontalSizedBox(horizontalSpace: 25.w),
                                CustomText(
                                  text: posts[index].time,
                                  fontSize: 12.sp,
                                  color: greyColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                const Spacer(),
                                Image.asset(
                                  trash,
                                  height: 22.h,
                                  width: 22.w,
                                ),
                              ],
                            ),
                            VerticalSizedBox(vertical: 14.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: posts[index].title,
                                fontSize: 14.sp,
                                color: blackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            VerticalSizedBox(vertical: 10.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: posts[index].description,
                                fontSize: 11.sp,
                                color: blackColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Row(
                              children: [
                                Image.asset(
                                  like,
                                  height: 17.h,
                                  width: 17.w,
                                ),
                                HorizontalSizedBox(horizontalSpace: 7.sp),
                                CustomText(
                                  text: posts[index].likes.toString(),
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
                                  text: posts[index].likes.toString(),
                                  fontSize: 9.sp,
                                  color: blackColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileScreenCustomContainer extends StatelessWidget {
  ProfileScreenCustomContainer({
    super.key,
    required this.title,
    required this.black,
    required this.icon,
  });
  String title;
  String icon;
  bool black;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: 0.44.sw,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.black.withOpacity(0.35),
          ),
        ),
        child: Row(
          children: [
            HorizontalSizedBox(horizontalSpace: 10.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSizedBox(vertical: 10.h),
                Image.asset(
                  icon,
                  width: 38.w,
                  height: 38.h,
                ),
                VerticalSizedBox(vertical: 10.h),
                CustomText(
                  text: title,
                  fontSize: 17.sp,
                  color: black == true ? blackColor : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ));
  }
}
