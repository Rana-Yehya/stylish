import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sizeContainer({required String size, Color? selectedColor}) {
  return Container(
    margin: EdgeInsets.only(right: 8.w),
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    decoration: ShapeDecoration(
      color: AppColors.transparent,
      shape: CircleBorder(
        side: BorderSide(color: selectedColor ?? AppColors.transparent),
      ),
    ),
    child: Center(
      child: Text(
        size,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 14.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
