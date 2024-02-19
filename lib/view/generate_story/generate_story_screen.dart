import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';

class GenerateStoryScreen extends StatefulWidget {
  const GenerateStoryScreen({super.key});

  @override
  State<GenerateStoryScreen> createState() => _GenerateStoryScreenState();
}

class _GenerateStoryScreenState extends State<GenerateStoryScreen> {
  TextEditingController generateStory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: 1.sh,
        child: Column(
          children: [
            VerticalSizedBox(vertical: 40.h),
            Row(
              children: [
                HorizontalSizedBox(horizontalSpace: 20.w),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                HorizontalSizedBox(horizontalSpace: 20.w),
                CustomText(
                  text: "LITERATURE.AI",
                  fontSize: 16.sp,
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomText(
                textAlign: TextAlign.center,
                text: "Get Help From LITERATURE.AI About Your Story",
                fontSize: 16.sp,
                color: greyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: const Color(0xff8E8870)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 3, bottom: 3, right: 3),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 6 * 20.0),
                      child: TextField(
                        maxLines: null, // Allow unlimited lines initially
                        keyboardType: TextInputType.multiline,
                        controller: generateStory,
                        onChanged: (text) {
                          // Limiting the text field to 4 lines
                          if (generateStory.text.split('\n').length > 4) {
                            setState(() {
                              // Remove excess lines beyond 4
                              generateStory.text = generateStory.text
                                  .split('\n')
                                  .take(4)
                                  .join('\n');
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: blackColor),
                          suffixIconColor: blackColor,
                          prefixIconColor: blackColor,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              send,
                              height: 15.h,
                              width: 15.w,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        // obscureText: widget.obscureText,
                        // keyboardType: widget.keyboardType,
                        // onChanged: widget.onChanged,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            VerticalSizedBox(vertical: 20.h),
          ],
        ),
      ),
    ));
  }
}
