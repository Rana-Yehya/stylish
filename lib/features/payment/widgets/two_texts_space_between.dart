import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget twoTextsSpaceBetween({
  required String textOnLeft,
  required String textOnRight,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        textOnLeft,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 18.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        textOnRight,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 16.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
