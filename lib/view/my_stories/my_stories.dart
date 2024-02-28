import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Core/Components/custom_app_bar2.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/models/post_data_model.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:mvvm/view_models/user_side_view_models/home_view_model.dart';
import 'package:provider/provider.dart';

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
        // bottomNavigationBar: AppMainScreen(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 1.sh,
            child: Column(
              children: [
                VerticalSizedBox(vertical: 20.sp),
                CusotmAppBar2(text: "My Stories", color: whiteColor),
                VerticalSizedBox(vertical: 30.h),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Posts")
                      .orderBy("createdAt", descending: true)
                      .where("uid", isEqualTo: userData!.uid)
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
                      itemCount: snapshot.data!.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return StoryItemWidget(
                          index: index,
                          snapshot: snapshot.data!.docs[index],
                        );
                      },
                    );
                  },
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
class StoryItemWidget extends StatefulWidget {
  int index;
  QueryDocumentSnapshot snapshot;
  StoryItemWidget({
    super.key,
    required this.index,
    required this.snapshot,
  });

  @override
  State<StoryItemWidget> createState() => _StoryItemWidgetState();
}

class _StoryItemWidgetState extends State<StoryItemWidget> {
  bool likeActive = false;
  bool dislikeActive = false;
  List likedBy = [];
  List dislikedBy = [];

  @override
  Widget build(BuildContext context) {
    likedBy = widget.snapshot["likedBy"];
    dislikedBy = widget.snapshot["dislikedBy"];
    final homeprovider =
        Provider.of<HomeScreenViewModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
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
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: whiteColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Logout",
                              fontSize: 18.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            VerticalSizedBox(vertical: 10.h),
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 20,
                              text:
                                  "Are you sure you wanna delete this story ?",
                              fontSize: 15.sp,
                              color: blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Perform action on cancel
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: greyColor.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.only(
                                    left: 25.sp,
                                    right: 25.sp,
                                    top: 6.sp,
                                    bottom: 6.sp,
                                  ),
                                  child: CustomText(
                                    text: "Cancel",
                                    fontSize: 15.sp,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  homeprovider.deleteStory(widget.snapshot);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.only(
                                    left: 30.sp,
                                    right: 40.sp,
                                    top: 6.sp,
                                    bottom: 6.sp,
                                  ),
                                  child: CustomText(
                                    text: "Yes",
                                    fontSize: 15.sp,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    trash,
                    height: 22.h,
                    width: 22.w,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
          VerticalSizedBox(vertical: 14.h),
          CustomText(
            customAlignment: Alignment.centerLeft,
            maxLines: 20,
            width: 0.9.sw,
            text: widget.snapshot["storyTittle"],
            fontSize: 14.sp,
            color: blackColor,
            fontWeight: FontWeight.w700,
          ),
          VerticalSizedBox(vertical: 10.h),
          CustomText(
            width: 0.9.sw,
            customAlignment: Alignment.centerLeft,
            maxLines: 50,
            text: widget.snapshot["storyBody"],
            fontSize: 11.sp,
            color: blackColor,
            fontWeight: FontWeight.w300,
          ),

          ///
          SizedBox(height: 14.h),
          Row(
            children: [
              HorizontalSizedBox(horizontalSpace: 15.sp),
              InkWell(
                onTap: () {
                  homeprovider
                      .toggleLike(widget.snapshot); // widget.selected = true;
                },
                child: Row(
                  children: [
                    Image.asset(
                      likedBy.contains(userData!.uid) == false ? like : liked,
                      height: 17.h,
                      width: 17.w,
                    ),
                    HorizontalSizedBox(horizontalSpace: 7.sp),
                    CustomText(
                      text: widget.snapshot["likedBy"].length.toString(),
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
                      text: widget.snapshot["dislikedBy"].length.toString(),
                      fontSize: 9.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
// class ProfileScreenCustomContainer extends StatelessWidget {
//   ProfileScreenCustomContainer({
//     super.key,
//     required this.title,
//     required this.black,
//     required this.icon,
//   });
//   String title;
//   String icon;
//   bool black;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 100.h,
//         width: 0.44.sw,
//         decoration: BoxDecoration(
//           color: whiteColor,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 14,
//               offset: const Offset(0, 4),
//             ),
//           ],
//           border: Border.all(
//             color: Colors.black.withOpacity(0.35),
//           ),
//         ),
//         child: Row(
//           children: [
//             HorizontalSizedBox(horizontalSpace: 10.sp),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 VerticalSizedBox(vertical: 10.h),
//                 Image.asset(
//                   icon,
//                   width: 38.w,
//                   height: 38.h,
//                 ),
//                 VerticalSizedBox(vertical: 10.h),
//                 CustomText(
//                   text: title,
//                   fontSize: 17.sp,
//                   color: black == true ? blackColor : Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }
