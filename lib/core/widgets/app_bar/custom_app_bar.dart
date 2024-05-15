import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_images.dart';

Widget customAppBar() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconButton(
        //   onPressed: () {},
        //   iconSize: 32.dg,
        //   icon: Icon(
        //     Icons.menu,
        //     color: AppColors.blackIconBackground,
        //   ),
        // ),
        Image.asset(
          AppImages.logo,
          width: 110.w,
        ),
        // Container(
        //   width: 40.w,
        //   height: 40.h,
        //   decoration: ShapeDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(
        //           "https://imgs.search.brave.com/_QS-C_ZdFRoEEb83lITyO3dY1Y6syO6ywUb65b2ZRcQ/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/dzNzY2hvb2xzLmNv/bS9ob3d0by9pbWdf/YXZhdGFyLnBuZw"),
        //       fit: BoxFit.fill,
        //     ),
        //     shape: CircleBorder(),
        //   ),
        // ),
      ],
    ),
  );
}
