import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/models/post_data_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_screen/home_provider.dart';
import 'package:mvvm/view/home_screen/status_stories.dart';
import 'package:mvvm/view/profile_section/profile_screen.dart';
import 'package:provider/provider.dart';

bool profilescreen = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context, listen: true);
    return homeprovider.condition == true
        ? SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      setState(() {
                        homeprovider.toggleCondition(false);
                      });
                    },
                    child: Column(
                      children: [
                        VerticalSizedBox(vertical: 20.h),
                        Icon(
                          Icons.menu,
                          size: 25.sp,
                        ),
                      ],
                    ),
                  ),
                  title: Column(
                    children: [
                      VerticalSizedBox(vertical: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HorizontalSizedBox(horizontalSpace: 25.w),
                          Image.asset(
                            logo,
                            height: 35.h,
                            width: 55.w,
                          ),
                          HorizontalSizedBox(horizontalSpace: 5.w),
                          CustomText(
                            text: "LITERATURE.AI",
                            fontSize: 17.sp,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        height: 2.8.sh,
                        width: 1.sw,
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            VerticalSizedBox(vertical: 15.h),
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
                    Positioned(
                      bottom: 40.h,
                      right: -15.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.poststory);
                        },
                        child: Image.asset(
                          addbutton,
                          height: 100.h,
                          width: 100.w,
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
    return SizedBox(
      height: 100.h,
      width: 1.sw,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: posts.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StatuStoriesScreen(
                              imageUrl: posts[index].imageUrl,
                              name: posts[index].name,
                              time: posts[index].time,
                              title: posts[index].title,
                              description: posts[index].description,
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
                          text: posts[index].title,
                          fontSize: 5.sp,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            posts[index].description,
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
                  text: posts[index].name,
                  fontSize: 10.sp,
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// class StatusSectionHomeScreen extends StatelessWidget {
//   const StatusSectionHomeScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100.h,
//       width: 1.sw,
//       child: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: posts.length,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.sp),
//             child: Column(
//               children: [
//                 Container(
//                   height: 70.h,
//                   width: 70.w,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                         storycontainer,
//                       ), // Replace with your image asset path
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomText(
//                         text: posts[index].title,
//                         fontSize: 5.sp,
//                         color: blackColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                           textAlign: TextAlign.center,
//                           posts[index].description,
//                           overflow: TextOverflow
//                               .ellipsis, // or TextOverflow.clip for clipping without ellipsis
//                           maxLines: 4,
//                           style: TextStyle(
//                             fontSize: 3.sp,
//                             color: blackColor,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 7.h),
//                 CustomText(
//                   text: posts[index].name,
//                   fontSize: 10.sp,
//                   color: blackColor,
//                   fontWeight: FontWeight.w500,
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class StoriesSectionHomeScreen extends StatelessWidget {
  const StoriesSectionHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return StoryItemWidget(
            index: index,
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class StoryItemWidget extends StatefulWidget {
  int index;
  StoryItemWidget({
    super.key,
    required this.index,
  });

  @override
  State<StoryItemWidget> createState() => _StoryItemWidgetState();
}

class _StoryItemWidgetState extends State<StoryItemWidget> {
  bool likeActive = false;
  bool dislikeActive = false;

  void toggleLike() {
    setState(() {
      likeActive = !likeActive;
      dislikeActive = false;
    });
  }

  void toggleDislike() {
    setState(() {
      dislikeActive = !dislikeActive;
      likeActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                posts[widget.index].imageUrl,
                height: 40.h,
                width: 40.w,
              ),
              HorizontalSizedBox(horizontalSpace: 10.w),
              CustomText(
                text: posts[widget.index].name,
                fontSize: 12.sp,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
              HorizontalSizedBox(horizontalSpace: 25.w),
              CustomText(
                text: posts[widget.index].time,
                fontSize: 10.sp,
                color: greyColor,
                fontWeight: FontWeight.w400,
              ),
              const Spacer(),
              const ReportPostButton(),
            ],
          ),
          VerticalSizedBox(vertical: 14.h),
          Row(
            children: [
              HorizontalSizedBox(horizontalSpace: 5.w),
              CustomText(
                text: posts[widget.index].title,
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
                text: posts[widget.index].description,
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
              GestureDetector(
                onTap: () {
                  toggleLike(); // widget.selected = true;
                },
                child: Image.asset(
                  likeActive == false ? like : liked,
                  height: 17.h,
                  width: 17.w,
                ),
              ),
              HorizontalSizedBox(horizontalSpace: 7.sp),
              CustomText(
                text: posts[widget.index].likes.toString(),
                fontSize: 9.sp,
                color: blackColor,
                fontWeight: FontWeight.w300,
              ),
              HorizontalSizedBox(horizontalSpace: 15.sp),
              GestureDetector(
                onTap: () {
                  toggleDislike();
                },
                child: Transform.rotate(
                  angle: 3.14,
                  child: Image.asset(
                    dislikeActive == false ? like : liked,
                    height: 17.h,
                    width: 17.w,
                  ),
                ),
              ),
              HorizontalSizedBox(horizontalSpace: 7.sp),
              CustomText(
                text: posts[widget.index].likes.toString(),
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
  }
}

//
//Report post
class ReportPostButton extends StatelessWidget {
  const ReportPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 1,
      padding: EdgeInsets.zero,
      icon: GestureDetector(
        child: Icon(
          Icons.more_vert,
          size: 18.sp,
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
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
          value: 'Block',
          height: 25.h,
          child: Row(
            children: [
              const HorizontalSizedBox(horizontalSpace: 7),
              Icon(
                Icons.block,
                size: 12.sp,
                color: blackColor,
              ),
              const HorizontalSizedBox(horizontalSpace: 10),
              const CustomText(
                text: "Block User",
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
