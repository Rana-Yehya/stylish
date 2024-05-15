import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ratingDelivaryPriceTime({
  required double rating,
  required double delivery,
  required double price,
}) {
  return Row(
    children: [
      Icon(
        Icons.star_border,
        size: 20.dg,
        color: AppColors.primary,
      ),
      Text(
        '4.7', // TODO: Add restuarant rating
        style: TextStyle(
          color: AppColors.blackIconBackground,
          fontSize: 16.sp,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(width: 24.w),
      Icon(
        Icons.delivery_dining_rounded,
        size: 20.dg,
        color: AppColors.primary,
      ),
      Text(
        'Free', // TODO: Add restuarant delivery fees
        style: TextStyle(
          color: AppColors.blackIconBackground,
          fontSize: 16.sp,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(width: 24.w),
      Icon(
        Icons.timer_outlined,
        size: 20.dg,
        color: AppColors.primary,
      ),
      Text(
        '20 min', // TODO: Add restuarant delivery time
        style: TextStyle(
          color: AppColors.blackIconBackground,
          fontSize: 16.sp,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}
