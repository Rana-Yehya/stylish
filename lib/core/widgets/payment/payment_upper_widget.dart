import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentUpperWidget extends StatelessWidget {
  const PaymentUpperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 45.w,
              height: 45.h,
              decoration: ShapeDecoration(
                color: AppColors.greyIconBackground,
                shape: const OvalBorder(),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.blackIconBackground,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              "Payment",
              style: TextStyle(
                color: AppColors.blackIconBackground,
                fontSize: 17.sp,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                  width: 85.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.greyIconBackground,
                  ),
                  //TODO: Chamge it to image payment process
                  child: Center(
                    child: Icon(Icons.payment),
                  ));
            }),
        SizedBox(height: 20.h),
      ],
    );
  }
}
