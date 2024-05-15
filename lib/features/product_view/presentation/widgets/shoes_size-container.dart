import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget shoesSizeContainer({required String size, Color? selectedColor}) {
  return Container(
    margin: EdgeInsets.only(right: 8.w),
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(
            width: 1.5.w, color: selectedColor ?? AppColors.transparent),
        borderRadius: BorderRadius.circular(4.r),
      ),
    ),
    child: Text(
      size,
      style: TextStyle(
        color: AppColors.primary,
        fontSize: 14.sp,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
