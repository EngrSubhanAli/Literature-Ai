// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mvvm/Core/Components/app_button.dart';

import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/edit_profile/edit_profile_screen.dart';
import 'package:mvvm/view/generate_story/generate_story_screen.dart';

List<String> genre = [];

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key});

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  TextEditingController autherController = TextEditingController();
  TextEditingController bookController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    genre = [];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (() {
                      Get.back();
                    }),
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  CustomText(
                    text: "Analyze",
                    fontSize: 19.sp,
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: 1.sh,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 60),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      VerticalSizedBox(vertical: 20.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: "Select Genre",
                            fontSize: 16.sp,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalSizedBox(vertical: 20.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Action",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Adventure",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Comedy",
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Death game",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Fantasy",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Satire",
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Historical",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Thriller",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Horror",
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Science fiction",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Historical fiction",
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Science fiction",
                            ),
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Historical fiction",
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            SelectGenreContainer(
                              isSelected: false,
                              title: "Speculative",
                            ),
                          ],
                        ),
                      ),
                      VerticalSizedBox(vertical: 20.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: "Author Name",
                            fontSize: 16.sp,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      EditProfileCustomTextField(
                        validator: (value) {
                          if (value == null) {
                            return 'Auther name cannot be empty';
                          }

                          return null;
                        },
                        controller: autherController,
                        obscureText: false,
                        scrollarea: 5,
                        maxLines: 1,
                        hintText: "",
                      ),
                      VerticalSizedBox(vertical: 30.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: "Book Name",
                            fontSize: 16.sp,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalSizedBox(vertical: 10.h),
                      EditProfileCustomTextField(
                        validator: (value) {
                          if (value == null) {
                            return 'Book name cannot be empty';
                          }

                          return null;
                        },
                        controller: bookController,
                        obscureText: false,
                        scrollarea: 4,
                        maxLines: 1,
                        hintText: "",
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            String message =
                                "Provide me review of the following book :   \nAuthor Name: ${autherController.text}\nBook Name: ${bookController.text}\nGenre :$genre";

                            Get.to(GenerateStoryScreen(
                              preresponse: message,
                            ));
                          }
                        },
                        child:
                            const CustomGradientButton(buttonText: "Generate"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class SelectGenreContainer extends StatefulWidget {
  String title;
  bool isSelected;
  SelectGenreContainer({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  State<SelectGenreContainer> createState() => _SelectGenreContainerState();
}

class _SelectGenreContainerState extends State<SelectGenreContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          if (genre.contains(widget.title)) {
            genre.remove(widget.title);
          }else{
            genre.add(widget.title);
          }

          setState(() {
            widget.isSelected = !widget.isSelected;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            // color: widget.isSelected == true
            //     ? baseColor.withOpacity(0.8)
            //     : whiteColor,
            gradient: LinearGradient(
              colors: widget.isSelected == true
                  ? [
                      const Color(0xFFB463FD),
                      const Color(0xFF6D94FD),
                      const Color(0xFF71C5FF),
                      const Color(0xFF3FFAFE),
                    ]
                  : [whiteColor, whiteColor],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: lightGrey,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 5, top: 5),
            child: CustomText(
              text: widget.title,
              fontSize: 16.sp,
              color: widget.isSelected == true ? whiteColor : greyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
