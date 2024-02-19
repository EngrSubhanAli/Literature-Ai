import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/colors.dart';

class AppButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AppButton(
      {super.key,
      this.height,
      this.width,
      this.text,
      this.color,
      this.textColor,
      this.onPressed,
      this.radius,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 10),
          ),
        ),
        child: Center(
          child: Text(
            text ?? 'Button',
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 20,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

///gradeint button

class CustomGradientButton extends StatelessWidget {
  final String buttonText;

  const CustomGradientButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 0.85.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            10.0), // Adjust the value for more or less rounding
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB463FD), // Replace with your first color
            Color(0xFF6D94FD),
            Color(0xFF71C5FF), // Replace with your third color
            Color(0xFF3FFAFE), // Replace with your third color
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 18,
            offset: const Offset(13, 12),
          ),
        ],
      ),
      child: Center(
        child: CustomText(
          text: buttonText,
          fontSize: 18.sp,
          color: whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
