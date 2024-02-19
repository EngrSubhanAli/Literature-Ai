import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/models/post_data_model.dart';
import 'package:mvvm/view/story_detail_screen/story_detail_screen.dart';

class TopRatedStories extends StatefulWidget {
  const TopRatedStories({super.key});

  @override
  State<TopRatedStories> createState() => _TopRatedStoriesState();
}

class _TopRatedStoriesState extends State<TopRatedStories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    HorizontalSizedBox(horizontalSpace: 15.w),
                    Icon(
                      Icons.menu,
                      size: 25.sp,
                    ),
                    HorizontalSizedBox(horizontalSpace: 30.sp),
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
                  ],
                ),
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
                        size: 20.sp,
                      ),
                    ),
                    CustomText(
                      text: "Top Rated Stories",
                      fontSize: 23.sp,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                VerticalSizedBox(vertical: 15.h),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoryDetailScreen(
                                  imageURL: posts[index].imageUrl,
                                  rank: posts[index].rank,
                                  name: posts[index].name,
                                  time: posts[index].time,
                                  title: posts[index].title,
                                  description: posts[index].description,
                                  likes: posts[index].likes,
                                  dislikes: posts[index].dislikes,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff3FFAFE),
                                  Color(0xfB71C5FF),
                                  Color(0xff6D94FD),
                                  Color(0xffB463FD),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 13,
                                  offset: const Offset(3, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      badge,
                                      height: 58.h,
                                      width: 51.w,
                                    ),
                                    Positioned(
                                      left: 20.sp,
                                      top: 8.sp,
                                      child: CustomText(
                                        text: (index + 1).toString(),
                                        fontSize: 15.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VerticalSizedBox(vertical: 10.h),
                                    SizedBox(
                                      width: 0.80.sw,
                                      child: CustomText(
                                        text: posts[index].title,
                                        fontSize: 14.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.8.sw,
                                      child: Text(
                                        posts[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    VerticalSizedBox(vertical: 12.h),
                                  ],
                                ),
                              ],
                            ),
                          ),
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

// EditProfileCustomTextfield

class EditProfileCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int? customLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxlength;
  final bool obscureText;
  final TextInputType? keyboardType;
  // final Function(String)? onChanged;

  const EditProfileCustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.maxlength,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    // this.onChanged,
    this.customLines,
  });

  @override
  State<EditProfileCustomTextField> createState() =>
      _EditProfileCustomTextFieldState();
}

class _EditProfileCustomTextFieldState
    extends State<EditProfileCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: const Color(0xff8E8870)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2),
          child: TextField(
            maxLength: widget.maxlength,
            maxLines: null,
            minLines: widget.customLines,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: blackColor),
              prefixIcon:
                  widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              suffixIconColor: blackColor,
              prefixIconColor: blackColor,
              suffixIcon:
                  widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
              border: InputBorder.none,
            ),
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
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