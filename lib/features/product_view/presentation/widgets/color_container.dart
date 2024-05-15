import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget colorContainer({required Color color, bool? selected}) {
  return Container(
    width: 50.w,
    height: 50.h,
    margin: EdgeInsets.only(right: 16.w),
    decoration: ShapeDecoration(
      color: color,
      shape: CircleBorder(
        side: BorderSide(
          color: AppColors.primary,
          width: selected != null ? 2.w : 1.w,
        ),
      ),
    ),
  );
}
