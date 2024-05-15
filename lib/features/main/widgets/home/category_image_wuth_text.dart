import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget categoryImageWithText(
    {required String assetName, required String text}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 60.h,
        width: 60.w,
        decoration: ShapeDecoration(
          shape: OvalBorder(),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(assetName),
          ),
        ),
        // child: Image.asset(assetName),
      ),
      SizedBox(height: 4.h),
      Text(
        text.substring(0, 1).toUpperCase() + text.substring(1),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.lightBlack,
          fontSize: 10.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
