import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvm/Core/Components/custom_app_bar2.dart';
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
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              VerticalSizedBox(vertical: 5.sp),
              CusotmAppBar2(
                color: whiteColor,
                text: "Top Rated Stories",
              ),
              VerticalSizedBox(vertical: 10.h),
              Expanded(
                child: StreamBuilder(
                      stream: FirebaseFirestore.instance
            .collection("Posts")
            .orderBy("likes", descending: true)
            .limit(7)
            .snapshots(),

                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 225.h,
              width: 1.sw,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading data',
              ),
            );
          }
         return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var snapshotvalue =snapshot.data!.docs[index]; 
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 15.sp,
                          right: 15.sp,
                          bottom: 15.sp,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        StoryDetailScreen(
                                          snapshot: snapshot.data!.docs[index],
                               
                                  rank: index,
                            
                        
                                ),
                                transitionDuration: const Duration(
                                    seconds: 0), // No transition duration
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
                                      width: 0.75.sw,
                                      child: CustomText(
                                        text:snapshotvalue["storyTittle"],
                                        fontSize: 14.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.75.sw,
                                      child: Text(
                                       snapshotvalue["storyBody"],
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
                  );
                 }
            
                  
                ),
              ),
            ],
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
