import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';
import 'package:mvvm/view/home_screen/home_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CusotmAppBar extends StatelessWidget {
  Color color;
  String from;
  CusotmAppBar({super.key, required this.color, required this.from});

  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context, listen: true);
    return Container(
      color: color,
      height: 65.h,
      child: Row(
        children: [
          HorizontalSizedBox(horizontalSpace: 15.sp),
          GestureDetector(
            onTap: () {
              debugPrint("............................$from");
              // print("hiiiiiii");
              homeprovider.setStateforHome(from);
              homeprovider.toggleCondition(false);
            },
            child: Icon(
              Icons.menu,
              size: 30.sp,
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
          HorizontalSizedBox(horizontalSpace: 40.w),
        ],
      ),
    );
  }
}
