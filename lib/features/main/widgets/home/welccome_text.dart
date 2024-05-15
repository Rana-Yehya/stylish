import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget welcomeText() {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'hey Halal, ',
          style: TextStyle(
            color: AppColors.helloText,
            fontSize: 16.sp,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
            height: 0.10.h,
          ),
        ),
        TextSpan(
          text: 'Good Afternoon!',
          style: TextStyle(
            color: AppColors.greetingText,
            fontSize: 16.sp,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
            height: 0.10.h,
          ),
        ),
      ],
    ),
  );
}
