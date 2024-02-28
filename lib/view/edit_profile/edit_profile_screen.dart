import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/Core/Components/app_button.dart';
import 'package:mvvm/Core/Components/custom_appbar.dart';
import 'package:mvvm/Core/Components/edit_password.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/Core/constant/constan.dart';
import 'package:mvvm/services/firebase_db/firebase_db.dart';
import 'package:mvvm/view/edit_profile/edit_profile_view_model.dart';
import 'package:mvvm/view/home_screen/home_screen_view_model.dart';
import 'package:mvvm/view/profile_section/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        ('No image selected.');
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final storyProvider =
        Provider.of<EditProfileViewModel>(context, listen: false);
    storyProvider.disposeLoginControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeprovider =
        Provider.of<HomeScreenViewModel>(context, listen: true);

    final editProfileProvider =
        Provider.of<EditProfileViewModel>(context, listen: true);
    editProfileProvider.disposeLoginControllers();
    return homeprovider.condition == true
        ? SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      height: 0.93.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              background), // Replace with your image asset path
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            VerticalSizedBox(vertical: 80.sp),
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
                                HorizontalSizedBox(horizontalSpace: 20.w),
                                if (userData!.picUrl == "")
                                  image == null
                                      ? GestureDetector(
                                          onTap: () {
                                            getImage();
                                            print("not pressing");
                                          },
                                          child: Image.asset(
                                            profil2,
                                            width: 100.w,
                                            height: 100.h,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            getImage();
                                            print("not pressing");
                                          },
                                          child: Container(
                                            height: 100.h,
                                            width: 100.w,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: Image.file(
                                                image!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
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
                                HorizontalSizedBox(horizontalSpace: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalSizedBox(vertical: 12.h),
                                    CustomText(
                                      text: userData!.username!,
                                      fontSize: 23.sp,
                                      color: blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: userData!.email!,
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
                              validator: (value) {
                                if (value == null) {
                                  return 'Kindly enter a valid username';
                                }

                                return null;
                              },
                              controller: editProfileProvider.nameController,
                              scrollarea: 4,
                              hintText: userData!.username!,
                              prefixIcon: Icons.person,
                            ),
                            VerticalSizedBox(vertical: 30.h),
                            EditProfileCustomTextField(
                              validator: (value) {
                                if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(value.toString()) ==
                                    false) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              controller: editProfileProvider.emailController,
                              scrollarea: 4,
                              hintText: userData!.email!,
                              prefixIcon: Icons.email,
                            ),
                            VerticalSizedBox(vertical: 30.h),
                            EditPassowrdWidget(
                              controller: editProfileProvider.passController,
                              validator: (value) {
                                if (value!.length > 8) {
                                  return 'Password should be atleast 8 characters';
                                }
                                return null;
                              },
                              hintText: "Type new password",
                            ),
                            VerticalSizedBox(vertical: 30.h),
                            EditPassowrdWidget(
                              controller:
                                  editProfileProvider.confirmpassController,
                              hintText: "Confirm new password",
                              validator: (value) {
                                if (editProfileProvider
                                        .confirmpassController.text !=
                                    editProfileProvider.passController.text) {
                                  return 'Passwords donot match';
                                }
                                return null;
                              },
                            ),
                            VerticalSizedBox(vertical: 50.h),
                            InkWell(
                                onTap: editProfileProvider.isLoading
                                    ? () {}
                                    : () async {
                                        await editProfileProvider.editProfile(
                                            editProfileProvider
                                                .emailController.text,
                                            editProfileProvider
                                                .passController.text,
                                            editProfileProvider
                                                .nameController.text);
                                        setState(() {});
                                      },
                                child: editProfileProvider.isLoading
                                    ? const CircularProgressIndicator()
                                    : const CustomGradientButton(
                                        buttonText: "Save")),
                            VerticalSizedBox(vertical: 20.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CusotmAppBar(
                    color: Colors.transparent,
                    from: AppConstants.fromeidt,
                  ),
                ],
              ),
            ),
          )
        : const ProfileScreen();
  }
}
// EditProfileCustomTextfield

//
typedef FormValidator = String? Function(String?);

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
  final FormValidator? validator;

  final TextInputType? keyboardType;
  // final Function(String)? onChanged;

  const EditProfileCustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.scrollarea,
    required this.validator,
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
              child: TextFormField(
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
                validator: widget.validator,
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
