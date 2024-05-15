import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:provider/provider.dart';

class VerificationPage extends HookWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Verification\nCode',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 36,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Please confirm your email first",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    model.userModel!.email,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  /*
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.blackTextFromField,
                          fontSize: 13.sp,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: AppColors.blackTextFromField,
                            fontSize: 14.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                          ),
                          children: const [
                            TextSpan(
                                text: "Resend",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(
                              text: "18",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  */
                  SizedBox(height: 24.h),
                  customButton(
                    onTap: () {
                      model.sendVerificationEmail().then((value) {
                        Fluttertoast.showToast(
                            msg:
                                'Another mail sent to you. Please check your inbox',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.primary,
                            textColor: Colors.white,
                            fontSize: 16.sp);

                        context.pushReplacement('/access_location');
                      });
                    },
                    text: 'Send Code',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
