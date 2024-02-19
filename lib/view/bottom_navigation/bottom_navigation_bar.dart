import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/analyze_screen/analyze_screen.dart';
import 'package:mvvm/view/edit_profile/edit_profile_screen.dart';
import 'package:mvvm/view/generate_story/generate_story_screen.dart';
import 'package:mvvm/view/home_screen/home_provider.dart';
import 'package:mvvm/view/home_screen/home_screen.dart';
import 'package:mvvm/view/recommend_screen/recommend_screen.dart';
import 'package:provider/provider.dart';

int currentIndex = 0;

// ignore: must_be_immutable
class AppMainScreen extends StatefulWidget {
  AppMainScreen({super.key});

  List<Widget> screens = [
    const HomeScreen(),
    const EditProfileScreen(),
    const AnalyzeScreen(),
    const GenerateStoryScreen(),
    const RecommendScreen(),
  ];
  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FabCircularMenuPlus(
          ringDiameterLimitFactor: 0.55,
          ringWidth: -10,
          ringColor: Colors.transparent,
          ringWidthLimitFactor: 0.5,
          fabSize: 65.sp,
          fabCloseColor: baseColor,
          fabOpenIcon: Image.asset(
            mainmenu,
            width: 90.w,
            height: 90.h,
          ),
          fabCloseIcon: const Icon(
            Icons.close,
            color: whiteColor,
          ),
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.analyze);
              },
              child: Image.asset(
                analyzeStoriesP,
                height: 67.h,
                width: 67.w,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.generatestory);
              },
              child: Image.asset(
                g,
                height: 67.h,
                width: 67.w,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.recomend);
              },
              child: Image.asset(
                recommendP,
                height: 67.h,
                width: 67.w,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 70,
        color: Colors.transparent,
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    home,
                    height: 18.h,
                  ),
                  VerticalSizedBox(vertical: 5.h),
                  CustomText(
                    text: "HOME",
                    fontSize: 12.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w800,
                  ),
                  currentIndex == 0 && homeprovider.condition != false
                      ? Container(
                          height: 8.h,
                          width: 8.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: blackColor,
                          ),
                        )
                      : const SizedBox(),
                  // ignore: unrelated_type_equality_checks
                ],
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                  setState(() {});
                  homeprovider.toggleCondition(true);
                });
              },
            ),
            SizedBox(width: 50.w),
            IconButton(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalSizedBox(vertical: 3.h),
                  Image.asset(
                    profile,
                    height: 18.h,
                  ),
                  VerticalSizedBox(vertical: 5.h),
                  CustomText(
                    text: "PROFILE",
                    fontSize: 12.sp,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  currentIndex == 1 && homeprovider.condition != false
                      ? Container(
                          height: 8.h,
                          width: 8.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: blackColor,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      body: widget.screens[currentIndex],
    );
  }
}
// 