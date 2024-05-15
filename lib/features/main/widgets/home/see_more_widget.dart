import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget seeMoreWidget({required String textOnLeft}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          textOnLeft,
          style: TextStyle(
            color: AppColors.blackTextFromField,
            fontSize: 20.sp,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "See All",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blackMedium,
                fontSize: 16.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 10.dg,
            ),
          ],
        ),
      ],
    ),
  );
}
