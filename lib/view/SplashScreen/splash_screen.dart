import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isOnboardingShown = false;
  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingShown = prefs.getBool('onboardingShown') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     RoutesName.onboarding,
    //     (route) => false,
    //   );
    // });
    //Getx Navigation call like that
    // Future.delayed(const Duration(seconds: 3), () {
    //  Get.offNamed(RoutesName.signUpGetx);}
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
              VerticalSizedBox(vertical: 150.h),
              Image.asset(
                logo,
                width: 170.w,
                height: 108.h,
              ),
              VerticalSizedBox(vertical: 20.h),
              CustomText(
                text: "Welcome To LITERATURE.AI",
                textAlign: TextAlign.center,
                color: blackColor,
                fontSize: 27.sp,
                fontWeight: FontWeight.bold,
              ),
              VerticalSizedBox(vertical: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  text: "Lorem Ipsum is dummy text of the printing"
                      " and typesetting industry, derived from a Latin "
                      "passage by Cicero",
                  textAlign: TextAlign.center,
                  color: blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () async {
                    _isOnboardingShown == true
                        ? Navigator.pushNamed(context, RoutesName.signIn)
                        : Navigator.pushNamed(context, RoutesName.onboarding);
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('splash', false);
                    print(_isOnboardingShown);
                    print("this is splash screen");
                  },
                  child: Image.asset(
                    tryliterature,
                    width: double.infinity,
                    height: 108.h,
                  ),
                ),
              ),
              VerticalSizedBox(vertical: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
