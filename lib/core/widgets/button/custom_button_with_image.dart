import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButtonWithImage({
  required VoidCallback onTap,
  required String text,
  required String assetName,
  Color? color,
  Color? borderColor,
  Color? textColor,
  bool enabled = true,
}) {
  return ElevatedButton(
    onPressed: enabled ? onTap : null,
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(
        color ?? AppColors.primary,
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      side: MaterialStateProperty.all(
        BorderSide(
          color: borderColor ?? AppColors.primary,
        ),
      ),
    ),
    child: enabled
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetName,
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(width: 8.w),
              Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor ?? AppColors.white,
                  fontSize: 14.sp,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )
        : LoadingAnimationWidget.waveDots(
            color: Colors.white,
            size: 24,
          ),
  );
}
