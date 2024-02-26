// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/custom_app_bar2.dart';

import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StoryDetailScreen extends StatefulWidget {
  int? rank;

  DocumentSnapshot snapshot;
  StoryDetailScreen({
    Key? key,
    this.rank,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  List likedBy = [];
  List dislikedBy = [];
  @override
  void initState() {
    // TODO: implement initState
    likedBy = widget.snapshot["likedBy"];
    dislikedBy = widget.snapshot["dislikedBy"];
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeprovider =
        Provider.of<HomeScreenViewModel>(context, listen: true);
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
                            text: (widget.rank! + 1).toString(),
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
                  text:widget.rank==0? "First Ranked Story":widget.rank==1? "Second Ranked Story":widget.rank==2? "Third Ranked Story":widget.rank==3? "Fourth Ranked Story":widget.rank==4? "Fifth Ranked Story":widget.rank==5? "Sixth Ranked Story":"Seventh Ranked Story",
                  fontSize: 23.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
                VerticalSizedBox(vertical: 15.h),
                Row(
                  children: [
                    const HorizontalSizedBox(horizontalSpace: 13),
                    if (widget.snapshot["picUrl"] == "")
                      Image.asset(
                        profil2,
                        height: 40.h,
                        width: 40.w,
                      ),
                    if (widget.snapshot["picUrl"] != "")
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.snapshot["picUrl"],
                                ))),
                      ),
                    HorizontalSizedBox(horizontalSpace: 10.w),
                    CustomText(
                      text: widget.snapshot["username"],
                      fontSize: 12.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    HorizontalSizedBox(horizontalSpace: 25.w),
                    CustomText(
                      text: DateFormat('h:mm a  MMM d ,y ')
                          .format(widget.snapshot["createdAt"].toDate()),
                      fontSize: 10.sp,
                      color: greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                    const Spacer(),
                    //  ReportPostButton(),
                  ],
                ),
                VerticalSizedBox(vertical: 15.h),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: widget.snapshot["storyTittle"],
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
                      text: widget.snapshot["storyBody"],
                      fontSize: 15.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        homeprovider.toggleLike(
                            widget.snapshot); // widget.selected = true;

                        if (likedBy.contains(userData!.uid)) {
                          likedBy.remove(userData!.uid);
                        } else {
                          likedBy.add(userData!.uid);

                          if (dislikedBy.contains(userData!.uid)) {
                            dislikedBy.remove(userData!.uid);
                          }
                        }

                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            likedBy.contains(userData!.uid) == false
                                ? like
                                : liked,
                            height: 17.h,
                            width: 17.w,
                          ),
                          HorizontalSizedBox(horizontalSpace: 7.sp),
                          CustomText(
                            text: likedBy.length.toString(),
                            fontSize: 9.sp,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                    HorizontalSizedBox(horizontalSpace: 15.sp),
                    InkWell(
                      onTap: () {
                        homeprovider.toggleDislike(widget.snapshot);
                        if (dislikedBy.contains(userData!.uid)) {
                          dislikedBy.remove(userData!.uid);
                        } else {
                          dislikedBy.add(userData!.uid);

                          if (dislikedBy.contains(userData!.uid)) {
                            likedBy.remove(userData!.uid);
                          }
                        }
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Transform.rotate(
                            angle: 3.14,
                            child: Image.asset(
                              dislikedBy.contains(userData!.uid) == false
                                  ? like
                                  : liked,
                              height: 17.h,
                              width: 17.w,
                            ),
                          ),
                          HorizontalSizedBox(horizontalSpace: 7.sp),
                          CustomText(
                            text: dislikedBy.length.toString(),
                            fontSize: 9.sp,
                            color: blackColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.h),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const CustomGradientButton(buttonText: "Done"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
