import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentLowerWidget extends StatelessWidget {
  const PaymentLowerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 28.h),
        Row(
          children: [
            Text(
              "Total",
              style: TextStyle(
                color: AppColors.greyText,
                fontSize: 14.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400,
              ),
            ),
            // TODO: Add total price
            Text(
              '\$96',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blackIconBackground,
                fontSize: 30.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 28.h),
        customButton(
          onTap: () {},
          text: "Pay And Confirm",
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
