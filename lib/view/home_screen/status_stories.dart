// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/home_screen/home_screen.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import 'package:mvvm/Core/constant/assets.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:mvvm/Core/constant/colors.dart';

// ignore: must_be_immutable
class StatuStoriesScreen extends StatefulWidget {
  DocumentSnapshot snapshot;

  StatuStoriesScreen({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<StatuStoriesScreen> createState() => _StatuStoriesScreenState();
}

class _StatuStoriesScreenState extends State<StatuStoriesScreen> {
  final storyController = StoryController();
  List<StoryItem> storyItemList = [];
  bool loading = true;

  Future<void> fetchStories() async {
    storyItemList = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> storiesSnapshot =
        await FirebaseDBService().fetchUserStories(widget.snapshot);

    for (int i = 0; i < storiesSnapshot.length; i++) {
      Duration difference = DateTime.now()
          .difference(storiesSnapshot[i].data()["createdAt"].toDate());
      debugPrint(difference.toString());
      DateTime dateTime =
          storiesSnapshot[i].data()["createdAt"].toDate().subtract(difference);
      debugPrint(dateTime.toString());
      String timeAgo = timeago.format(dateTime, locale: 'en_short');
      debugPrint(timeAgo.toString());
      timeAgo = timeAgo.replaceAll("~", "");

      storyItemList.add(StoryItem(
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
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
                child: Row(
                  children: [
                    if (widget.snapshot["picUrl"] == "")
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  profil2,
                                ))),
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
                      text: timeAgo,
                      fontSize: 10.sp,
                      color: greyColor,
                      fontWeight: FontWeight.w400,
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
                    text: storiesSnapshot[i].data()['storyTittle'],
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
                  text: storiesSnapshot[i].data()['storyBody'],
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
      ));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchStories();

    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    child: const Center(child: LinearProgressIndicator())),
              )
            : StoryView(
                storyItems: storyItemList,
                controller: storyController,
              ),
      ),
    );
  }
}
