import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/custom_appbar.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/Core/constant/constan.dart';
import 'package:mvvm/models/post_data_model.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:mvvm/view/home_screen/status_stories.dart';
import 'package:mvvm/view/profile_section/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

bool profilescreen = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeScreenViewModel>(context, listen: true);
    return homeprovider.condition == true
        ? SafeArea(
            child: Scaffold(
                body: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Expanded(
                    // height: posts.length * 0.41.sh,
                    // width: 1.sw,
                    child: Column(
                      children: [
                        SizedBox(height: 70.h),
                        // status
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: StatusSectionHomeScreen(),
                        ),
                        VerticalSizedBox(vertical: 10.h),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: CustomText(
                              text: "Stories",
                              fontSize: 27.sp,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        VerticalSizedBox(vertical: 10.h),
                        // Stories
                        const StoriesSectionHomeScreen(),
                      ],
                    ),
                  ),
                ),
                
                CusotmAppBar(color: whiteColor, from: AppConstants.fromhome),
                  Positioned(
                      bottom: 40.h,
                      right: 15.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.poststory);
                        },
                        child: Image.asset(
                          addbutton,
                          height: 70.h,
                          width: 70.w,
                        ),
                      ),
                    ),
              ],
            )),
          )
        : const ProfileScreen();
  }
}

class StatusSectionHomeScreen extends StatefulWidget {
  const StatusSectionHomeScreen({super.key});

  @override
  State<StatusSectionHomeScreen> createState() =>
      _StatusSectionHomeScreenState();
}

class _StatusSectionHomeScreenState extends State<StatusSectionHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Timestamp twentyFourHoursAgo = Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 24)));
    return SizedBox(
      height: 100.h,
      width: 1.sw,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Stroies")
            
            .orderBy("createdAt", descending: true)
            .where('createdAt', isGreaterThanOrEqualTo: twentyFourHoursAgo)
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
        itemCount:snapshot.data!.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index)  {

       



          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StatuStoriesScreen(
                            snapshot:snapshot.data!.docs[index] ,
                            )));
                  },
                  child: Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          storycontainer,
                        ), // Replace with your image asset path
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: snapshot.data!.docs[index]["storyTittle"],
                          fontSize: 5.sp,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            textAlign: TextAlign.center,
                             snapshot.data!.docs[index]["storyBody"].toString(),
                            overflow: TextOverflow
                                .ellipsis, // or TextOverflow.clip for clipping without ellipsis
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 3.sp,
                              color: blackColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 7.h),
                CustomText(
                  text:  snapshot.data!.docs[index]["username"],
                  fontSize: 10.sp,
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          );
        },
      );
          
         } 
    ));
  }
}

class StoriesSectionHomeScreen extends StatelessWidget {
  const StoriesSectionHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Posts")
          .orderBy("createdAt", descending: true)
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
            List hiddenStories = snapshot.data!.docs[index]["hidenBy"];
            return hiddenStories.contains(userData!.uid)
                ? Container()
                : StoryItemWidget(
                    index: index,
                    snapshot: snapshot.data!.docs[index],
                  );
          },
        );
      },
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
    final homeprovider = Provider.of<HomeScreenViewModel>(context, listen: true);
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
              ReportPostButton(
                snapshot: widget.snapshot,
              ),
            ],
          ),
          VerticalSizedBox(vertical: 14.h),
          Row(
            children: [
              HorizontalSizedBox(horizontalSpace: 5.w),
              CustomText(
                text: widget.snapshot["storyTittle"],
                fontSize: 14.sp,
                color: blackColor,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          VerticalSizedBox(vertical: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: widget.snapshot["storyBody"],
                fontSize: 11.sp,
                color: blackColor,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          ///
          SizedBox(height: 14.h),
          Row(
            children: [
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

//
//Report post

// ignore: must_be_immutable
class ReportPostButton extends StatefulWidget {
  DocumentSnapshot snapshot;
  ReportPostButton({super.key, required this.snapshot});

  @override
  State<ReportPostButton> createState() => _ReportPostButtonState();
}

class _ReportPostButtonState extends State<ReportPostButton> {
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeScreenViewModel>(context, listen: true);
    return PopupMenuButton<String>(
      color: whiteColor,
      surfaceTintColor: whiteColor,
      elevation: 5,
      position: PopupMenuPosition.under,
      offset: Offset(-20.sp, -12.sp),
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_vert,
        size: 18.sp,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            onTap: () async {
               homeprovider.hideStory(widget.snapshot);

            },
          height: 25.h,
          value: 'hide',
          child: Row(
            children: [
              const HorizontalSizedBox(horizontalSpace: 7),
              Icon(
                Icons.visibility_off,
                size: 12.sp,
                color: blackColor,
              ),
              const HorizontalSizedBox(horizontalSpace: 10),
              const CustomText(
                text: "Hide",
                fontSize: 12,
                color: blackColor,
                fontWeight: FontWeight.w300,
              ),
              HorizontalSizedBox(horizontalSpace: 40.w),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
       onTap: () {
              homeprovider.reportUser(widget.snapshot);

            },
          value: 'Report',
          height: 25.h,
          child: Row(
            children: [
              const HorizontalSizedBox(horizontalSpace: 7),
              Icon(
                Icons.report,
                size: 12.sp,
                color: blackColor,
              ),
              const HorizontalSizedBox(horizontalSpace: 10),
              const CustomText(
                text: "Report User",
                fontSize: 12,
                color: blackColor,
                fontWeight: FontWeight.w300,
              ),
              HorizontalSizedBox(horizontalSpace: 40.w),
            ],
          ),
        ),
      ],
      onSelected: (String value) {
        // Handle reporting logic here
      },
    );
  }
}
