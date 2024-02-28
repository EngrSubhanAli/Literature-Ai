import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/Core/constant/constan.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/bottom_navigation/bottom_navigation_bar.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:mvvm/view/post_story/post_story_view_model.dart';
import 'package:mvvm/view/profile_section/profile_view_model.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final homeprovider =
        Provider.of<HomeScreenViewModel>(context, listen: true);
    final profileProvider =
        Provider.of<ProfileViewModel>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage(background), // Replace with your image asset path
              fit: BoxFit.cover,
            ),
          ),
          child: profileProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 65.h,
                        child: Row(
                          children: [
                            HorizontalSizedBox(horizontalSpace: 15.sp),
                            GestureDetector(
                              onTap: () {
                                if (homeprovider.setStateForHome ==
                                    AppConstants.fromhome) {
                                  homeprovider.currentIndexCondition(0);
                                  homeprovider.toggleCondition(true);
                                }
                                if (homeprovider.setStateForHome ==
                                    AppConstants.fromeidt) {
                                  homeprovider.currentIndexCondition(1);
                                  homeprovider.toggleCondition(true);
                                }
                              },
                              child: Image.asset(
                                burger,
                                height: 31.h,
                                width: 31.w,
                              ),
                            ),
                            const Spacer(),
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
                            HorizontalSizedBox(horizontalSpace: 42.w),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.sp),
                        child: CustomText(
                          text: "Menu",
                          customAlignment: Alignment.centerLeft,
                          fontSize: 27.sp,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VerticalSizedBox(vertical: 5.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            if (userData!.picUrl == "")
                              Image.asset(
                                profil2,
                                width: 110.w,
                                height: 110.h,
                              ),
                            if (userData!.picUrl != "")
                              Container(
                                width: 110.w,
                                height: 110.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          userData!.picUrl!,
                                        ))),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: userData!.username!,
                                  fontSize: 20.sp,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: userData!.email!,
                                  fontSize: 15.sp,
                                  color: blackColor.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.topstory);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.sp, vertical: 14.sp),
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
                                  Image.asset(
                                    toprated,
                                    width: 45.w,
                                    height: 45.h,
                                  ),
                                  HorizontalSizedBox(horizontalSpace: 15.sp),
                                  CustomText(
                                    text: "Top Rated Story",
                                    fontSize: 17.sp,
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              )),
                        ),
                      ),
                      VerticalSizedBox(vertical: 20.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.generatestory);
                              },
                              child: ProfileScreenCustomContainer(
                                title: "Generate Story",
                                black: true,
                                icon: generatestoriesprofile,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.analyze);
                              },
                              child: ProfileScreenCustomContainer(
                                title: "Analyze",
                                black: true,
                                icon: analyzeStoriesP,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 20.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.recomend);
                              },
                              child: ProfileScreenCustomContainer(
                                title: "Recommend",
                                black: true,
                                icon: recommendP,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.mystories);
                              },
                              child: ProfileScreenCustomContainer(
                                title: "My Stories",
                                black: true,
                                icon: mystories,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 20.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, RoutesName.signIn);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: whiteColor,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Divider(),
                                          VerticalSizedBox(vertical: 10.h),
                                          CustomText(
                                            textAlign: TextAlign.center,
                                            text:
                                                "Are you sure you wanna Logout from your account ?",
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
                                                  color: greyColor
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                // Perform action on cancel

                                                homeprovider
                                                    .currentIndexCondition(0);

                                                await FirebaseDBService()
                                                    .logoutUser();

                                                Get.offAll(
                                                    const SignInScreen());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: pinkColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                              child: ProfileScreenCustomContainer(
                                title: "Logout",
                                black: true,
                                icon: logout,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: profileProvider.isLoading
                                  ? () {}
                                  : () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: whiteColor,
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                  text: "Delete account",
                                                  fontSize: 18.sp,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Divider(),
                                                VerticalSizedBox(
                                                    vertical: 10.h),
                                                CustomText(
                                                  textAlign: TextAlign.center,
                                                  text:
                                                      "Are you sure you wanna delete your account permanently?",
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: greyColor
                                                            .withOpacity(0.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      homeprovider
                                                          .currentIndexCondition(
                                                              0);
                                                      print(
                                                          "${homeprovider.currentIndex} ................");
                                                      Navigator.pop(context);
                                                      await profileProvider
                                                          .deleteUser()
                                                          .then((value) {
                                                        if (value != "Sucess") {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg: value,
                                                            // toastLength: Toast
                                                            //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
                                                            gravity: ToastGravity
                                                                .BOTTOM, // Top, Center, Bottom
                                                            timeInSecForIosWeb:
                                                                1, // Time duration for iOS and web
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                        } else {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "User deleted SucessFully",
                                                            // toastLength: Toast
                                                            //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
                                                            gravity: ToastGravity
                                                                .BOTTOM, // Top, Center, Bottom
                                                            timeInSecForIosWeb:
                                                                1, // Time duration for iOS and web
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                          Get.back();
                                                        }
                                                      });
                                                      ;
                                                      // Perform action on cancel
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: pinkColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                        left: 40.sp,
                                                        right: 40.sp,
                                                        top: 6.sp,
                                                        bottom: 6.sp,
                                                      ),
                                                      child: CustomText(
                                                        text: "Yes",
                                                        fontSize: 15.sp,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                              child: ProfileScreenCustomContainer(
                                title: "Delete Account",
                                black: false,
                                icon: delete,
                              ),
                            ),
                          ],
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
