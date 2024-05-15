import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ratingWidget({required double rating, required int reviewCount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        rating.toString(),
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
      RatingBarIndicator(
          rating: rating,
          itemSize: 24.dg,
          itemBuilder: (context, index) => Icon(
                Icons.star,
                color: AppColors.yellow,
              )),
      Text(
        reviewCount.toString(),
        style: TextStyle(
          color: AppColors.grey,
          fontSize: 14.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
