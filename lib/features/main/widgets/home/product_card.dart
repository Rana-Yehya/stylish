import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/features/main/widgets/home/discount_widget.dart';
import 'package:stylish/features/main/widgets/home/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget productCard(
    {required VoidCallback onTap,
    required String image,
    required String name,
    required String description,
    required double oldPrice,
    required double sale,
    required double rating,
    required int reviewCount}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: 280.h,
      width: 160.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //    width: 170.w,
            height: 90.h,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.contain,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            color: AppColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 4.h),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 10.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  sale != 0
                      ? '\$${oldPrice - oldPrice * (sale / 100)}'
                      : '\$$oldPrice',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                sale != 0
                    ? discountWidget(oldPrice: oldPrice, sale: sale)
                    : Card(),
                //    ratingWidget(rating: rating, reviewCount: reviewCount),
                //    const RestaurantRatingDelivaryPriceTime(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
