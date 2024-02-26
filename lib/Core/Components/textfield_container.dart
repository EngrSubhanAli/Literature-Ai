import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/constant/colors.dart';

typedef FormValidator = String? Function(String?);

// ignore: must_be_immutable
class TextFieldContainer extends StatefulWidget {
  final String title;
  final String placeholder;
  final Widget suffixicon;
  bool obscure = false;
  final TextEditingController textController;
  final IconData prefixIcon;
  final FormValidator? validator;

  TextFieldContainer(
      {super.key,
      required this.title,
      required this.placeholder,
      required this.textController,
      required this.suffixicon,
      required this.prefixIcon,
      required this.obscure,
      required this.validator});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  bool visible = false;
  void toggleObscure() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            width: 2,
            color: const Color(0xffE9ECEF), // Adjust border color as needed
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(
                widget.prefixIcon,
                color: lightGrey,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  TextFormField(
                    validator: widget.validator,
                    style: TextStyle(
                      color: baseColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                    controller: widget.textController,
                    obscureText: visible,
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      suffixIcon: widget.obscure == true
                          ? GestureDetector(
                              onTap: () {
                                toggleObscure();
                                // print("pressedd.......togled$visible");
                              },
                              child: visible == false
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            )
                          : const SizedBox(),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
