// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';

// ignore: must_be_immutable
class StatuStoriesScreen extends StatefulWidget {
  String imageUrl;
  String name;
  String time;
  String title;
  String description;
  StatuStoriesScreen({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<StatuStoriesScreen> createState() => _StatuStoriesScreenState();
}

class _StatuStoriesScreenState extends State<StatuStoriesScreen> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StoryView(
          storyItems: [
            StoryItem(
              Container(
                height: 1.sh,
                width: 1.sh,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(background2),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.imageUrl,
                            height: 40.h,
                            width: 40.w,
                          ),
                          HorizontalSizedBox(horizontalSpace: 10.w),
                          CustomText(
                            text: widget.name,
                            fontSize: 12.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                          HorizontalSizedBox(horizontalSpace: 25.w),
                          CustomText(
                            text: widget.time,
                            fontSize: 10.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.w300,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: widget.title,
                          fontSize: 20.sp,
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    VerticalSizedBox(vertical: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomText(
                        text: widget.description,
                        fontSize: 18.sp,
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    VerticalSizedBox(vertical: 60.h),
                    const Spacer(),
                  ],
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
            StoryItem(
              Container(
                height: 1.sh,
                width: 1.sh,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(background2),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: <Widget>[
                    // const SizedBox(height: 30),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.imageUrl,
                            height: 40.h,
                            width: 40.w,
                          ),
                          HorizontalSizedBox(horizontalSpace: 10.w),
                          CustomText(
                            text: widget.name,
                            fontSize: 12.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                          HorizontalSizedBox(horizontalSpace: 25.w),
                          CustomText(
                            text: widget.time,
                            fontSize: 10.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.w300,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Second Post",
                          fontSize: 20.sp,
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    VerticalSizedBox(vertical: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomText(
                        text: widget.description,
                        fontSize: 18.sp,
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    VerticalSizedBox(vertical: 60.h),
                    const Spacer(),
                  ],
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          ],
          controller: storyController,
        ),
      ),
    );
  }
}
