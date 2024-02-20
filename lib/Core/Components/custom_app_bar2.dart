import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/view/home_screen/home_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CusotmAppBar2 extends StatelessWidget {
  Color color;
  String text;

  CusotmAppBar2({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 60.h,
      child: Row(
        children: [
          HorizontalSizedBox(horizontalSpace: 8.sp),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              backarrow,
              height: 30.sp,
              width: 30.sp,
            ),
          ),
          const Spacer(),
          CustomText(
            text: text,
            fontSize: 19.sp,
            color: blackColor,
            fontWeight: FontWeight.bold,
          ),
          const Spacer(),
          HorizontalSizedBox(horizontalSpace: 40.w),
        ],
      ),
    );
  }
}
