// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/view/user_side_screens/auth/user_sign_in_screen/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  Future<void> _markOnboardingShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingShown', true);
  }

  // final Color kDarkBlueColor = const Color(0xFF053149);
  late PageController _pageController;
  int _pageindex = 0;
  final List<OnboardComponent> _onboardpages = [
    OnboardComponent(
      imageIcon: generatestories,
      title: "GENERATE STORY",
      descriptiom: "Lorem Ipsum is dummy text of the printing"
          " and typesettin industry, derived from"
          "a Latin passage by Cicero",
    ),
    OnboardComponent(
      imageIcon: analyze,
      title: "ANALYZE",
      descriptiom: "Lorem Ipsum is dummy text of the printing"
          " and typesettin industry, derived from"
          "a Latin passage by Cicero",
    ),
    OnboardComponent(
      imageIcon: topstories,
      title: "TOP STORIES",
      descriptiom: "Lorem Ipsum is dummy text of the printing"
          " and typesettin industry, derived from"
          "a Latin passage by Cicero",
    ),
    OnboardComponent(
      imageIcon: recomend,
      title: "RECOMMENDED",
      descriptiom: "Lorem Ipsum is dummy text of the printing"
          " and typesettin industry, derived from"
          "a Latin passage by Cicero",
    ),
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              SizedBox(height: 120.h),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _pageindex = value;
                    });
                  },
                  itemCount: _onboardpages.length,
                  itemBuilder: (context, index) => _onboardpages[index],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardpages.length,
                  (index) => Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 4.h,
                        width: 28.w,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Adjust the margin as needed
                        decoration: BoxDecoration(
                          color: _pageindex == index
                              ? selected
                              : blackColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalSizedBox(vertical: 40.h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                    if (_pageindex == 3) {
                      _markOnboardingShown();
                      print("make ths onboard off");
                      Get.offAll(const SignInScreen());
                    }
                  });
                  // print(_pageController.toString());
                },
                child: const CustomGradientButton(
                  buttonText: "Next",
                ),
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () {
                  // Get.to(const SignUpScreen());
                  _markOnboardingShown();
                  Get.offAll(const SignInScreen());
                },
                child: CustomText(
                  text: "Skip",
                  fontSize: 13.sp,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OnboardComponent extends StatelessWidget {
  String imageIcon;
  String title;
  String descriptiom;
  OnboardComponent({
    Key? key,
    required this.imageIcon,
    required this.title,
    required this.descriptiom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          logo,
          height: 90.h,
          width: 55.w,
        ),
        CustomText(
          text: "LITERATURE.AI",
          fontSize: 32.sp,
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
        VerticalSizedBox(vertical: 40.h),
        CustomText(
          text: "Crafting World with Words.",
          fontSize: 16.sp,
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
        VerticalSizedBox(vertical: 40.h),
        Image.asset(
          imageIcon,
          width: 35.w,
          height: 35.h,
        ),
        VerticalSizedBox(vertical: 12.h),
        CustomText(
          text: title,
          fontSize: 20.sp,
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
        VerticalSizedBox(vertical: 25.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomText(
            textAlign: TextAlign.center,
            text: descriptiom,
            fontSize: 16.sp,
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
