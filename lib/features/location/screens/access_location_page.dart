import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/core/location/current_location_helper.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AccessLocationPage extends StatelessWidget {
  const AccessLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<AuthController>(
          builder: (BuildContext context, AuthController model, Widget? child) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Access \nLocation',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 36.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Stylish',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' wants to access ypur location to get you the best sales and stores around you',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  customButton(
                    enabled: !model.isLoading,
                    onTap: () async {
                      getIt<LocationHelper>().determinePosition().then((value) {
                        value.fold(
                          (failure) => Fluttertoast.showToast(
                              msg: failure.messege,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.sp),
                          (position) {
                            model.addLocation(
                              lat: position.latitude,
                              lng: position.longitude,
                            );
                            context.pushReplacement('/login');
                          },
                        );
                      });
                    },
                    text: "Give Access",
                    //assetName: AppImages.google,
                  ),
                  // SizedBox(height: 16.h),
                  // customButton(
                  //   color: AppColors.white,
                  //   borderColor: AppColors.primary,
                  //   textColor: AppColors.primary,
                  //   onTap: () {
                  //     context.pushReplacement('/login');
                  //   },
                  //   text: 'Remind me later',
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
