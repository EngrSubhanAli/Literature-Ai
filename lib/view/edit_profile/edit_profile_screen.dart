import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/custom_appbar.dart';
import 'package:mvvm/Core/Components/edit_password.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/Core/constant/constan.dart';
import 'package:mvvm/view/home_screen/home_provider.dart';
import 'package:mvvm/view/profile_section/profile_screen.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
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
                      CusotmAppBar(
                        color: Colors.transparent,
                        from: AppConstants.fromeidt,
                      ),
                      VerticalSizedBox(vertical: 20.sp),
                      Row(
                        children: [
                          HorizontalSizedBox(horizontalSpace: 15.sp),
                          CustomText(
                            text: "Edit Profile",
                            fontSize: 27.sp,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            profilepic,
                            width: 110.w,
                            height: 110.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSizedBox(vertical: 12.h),
                              CustomText(
                                text: "Jason Born",
                                fontSize: 23.sp,
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: "jasonborn@yourdomain.com",
                                fontSize: 16.sp,
                                color: blackColor.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              )
                            ],
                          ),
                        ],
                      ),
                      VerticalSizedBox(vertical: 20.h),
                      // textfields
                      EditProfileCustomTextField(
                        controller: nameController,
                        scrollarea: 4,
                        hintText: "Lolla Smith",
                        prefixIcon: Icons.person,
                      ),
                      VerticalSizedBox(vertical: 30.h),
                      EditProfileCustomTextField(
                        controller: nameController,
                        scrollarea: 4,
                        hintText: "lolla_smith@example.com",
                        prefixIcon: Icons.email,
                      ),
                      VerticalSizedBox(vertical: 30.h),
                      EditPassowrdWidget(
                        controller: passController,
                      ),
                      VerticalSizedBox(vertical: 30.h),
                      EditPassowrdWidget(
                        controller: confirmpassController,
                      ),
                      VerticalSizedBox(vertical: 50.h),
                      const CustomGradientButton(buttonText: "Save")
                    ],
                  ),
                ),
              ),
            ),
          )
        : const ProfileScreen();
  }
}
// EditProfileCustomTextfield

//
class EditProfileCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int? customLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxlength;
  final int? maxLines;
  final bool obscureText;
  final double scrollarea;

  final TextInputType? keyboardType;
  // final Function(String)? onChanged;

  const EditProfileCustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.scrollarea,
    this.prefixIcon,
    this.maxlength,
    this.maxLines,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: widget.scrollarea * 20.0),
              child: TextField(
                maxLength: widget.maxlength,
                maxLines: widget.maxLines,
                minLines: widget.customLines,
                controller: widget.controller,
                onChanged: (text) {
                  // Limiting the text field to 4 lines
                  if (widget.controller.text.split('\n').length > 4) {
                    setState(() {
                      // Remove excess lines beyond 4
                      widget.controller.text =
                          widget.controller.text.split('\n').take(4).join('\n');
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: blackColor),
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon)
                      : null,
                  suffixIconColor: blackColor,
                  prefixIconColor: blackColor,
                  suffixIcon: widget.suffixIcon != null
                      ? Icon(widget.suffixIcon)
                      : null,
                  border: InputBorder.none,
                ),
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
              ),
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
