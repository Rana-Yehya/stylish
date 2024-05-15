import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWithTwoButtonsStacked extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback leftIconOnTap;
  final VoidCallback rightIconOnTap;
  const ImageWithTwoButtonsStacked(
      {super.key,
      required this.leftIcon,
      required this.rightIcon,
      required this.leftIconOnTap,
      required this.rightIconOnTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 375.w,
          height: 320.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF98A8B8), // TODO: Add restuarant image
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: leftIconOnTap,
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: ShapeDecoration(
                    color: AppColors.white,
                    shape: const OvalBorder(),
                  ),
                  child: Icon(
                    leftIcon,
                    color: AppColors.blackIconBackground,
                  ),
                ),
              ),
              /*
              SizedBox(width: 16.w),
              Text(
                restaurantView,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              
              const Spacer(),
              */
              GestureDetector(
                onTap: rightIconOnTap,
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: ShapeDecoration(
                    color: AppColors.white,
                    shape: const OvalBorder(),
                  ),
                  child: Icon(
                    rightIcon,
                    color: AppColors.blackIconBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
