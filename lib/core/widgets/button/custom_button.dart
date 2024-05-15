import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton({
  required VoidCallback onTap,
  required String text,
  Color? color,
  Color? borderColor,
  Color? textColor,
  bool enabled = true,
}) {
  return ElevatedButton(
    onPressed: enabled ? onTap : null,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        color ?? AppColors.primary,
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      ),
      side: MaterialStateProperty.all(
        BorderSide(
          color: borderColor ?? AppColors.primary,
        ),
      ),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    ),
    child: Center(
      child: enabled
          ? Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? AppColors.white,
                fontSize: 14.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            )
          : LoadingAnimationWidget.waveDots(
              color: Colors.white,
              size: 24,
            ),
    ),
  );
}
