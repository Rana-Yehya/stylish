import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget discountWidget({required double oldPrice, required double sale}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '\$$oldPrice',
          style: TextStyle(
            color: AppColors.lightgrey,
            fontSize: 12.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        TextSpan(
          text: ' $sale% Off',
          style: TextStyle(
            color: AppColors.discount,
            fontSize: 10.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
