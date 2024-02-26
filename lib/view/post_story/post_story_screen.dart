import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/edit_profile/edit_profile_screen.dart';
import 'package:mvvm/view/generate_story/generate_story_screen.dart';
import 'package:mvvm/view/post_story/post_story_view_model.dart';
import 'package:provider/provider.dart';

class PostStoryScreen extends StatefulWidget {
  const PostStoryScreen({super.key});

  @override
  State<PostStoryScreen> createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
final storyProvider =Provider.of<PostStoryViewModel>(context,listen: false);
storyProvider.disposeLoginControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storyProvider =Provider.of<PostStoryViewModel>(context);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: SizedBox(
        height: 1.sh,
        child: Form(
          key: formKey,
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
                   validator: (value) {
                        if (value == "" ) {
                          return 'Story tittle cannot be empty';
                        }
          
                        return null;
                      },
                controller: storyProvider.titleController,
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
                 validator: (value) {
                        if (value == "" ) {
                          return 'Story body cannot be empty';
                        }
          
                        return null;
                      },
                maxlength: 500,
                customLines: 5,
                scrollarea: 10,
                controller: storyProvider.bodycController,
                obscureText: false,
                hintText: "",
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {
               Get.to(GenerateStoryScreen(preresponse: "",));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Image.asset(
                    ai,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              InkWell(
                onTap:storyProvider.isLoading?(){}: () async {


 if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await storyProvider.uploadServeyData()

          .then((value) {
        if (value != "Sucess") {
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
                Fluttertoast.showToast(
            msg: "Story Uploaded SucessFully",
            // toastLength: Toast
            //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            timeInSecForIosWeb: 1, // Time duration for iOS and web
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.back();
          
        }
      });
    }
          
                },
                
                child:storyProvider.isLoading?const CircularProgressIndicator(): const CustomGradientButton(buttonText: "Post Now")),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    )));
  }
  
}
