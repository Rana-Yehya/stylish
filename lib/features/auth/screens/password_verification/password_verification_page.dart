import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class PasswordVerificationPage extends HookWidget {
  const PasswordVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentText = useState('');
    final codeController = useTextEditingController();
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
                    "We have sent a code to your email",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'example@gmail.com',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
                              text: "88",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  PinCodeTextField(
                    cursorColor: AppColors.primary,
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      borderWidth: 5.w,
                      selectedFillColor: AppColors.white,
                      activeFillColor: AppColors.white,
                      inactiveFillColor: AppColors.white,
                      activeColor: AppColors.primary,
                      selectedColor: AppColors.primary,
                      inactiveColor: AppColors.primary,
                      // shape: PinCodeFieldShape.box,
                      // borderRadius: BorderRadius.circular(10.r),
                      // fieldHeight: 62.h,
                      // fieldWidth: 62.h,
                      //activeFillColor: AppColors.primary,
                    ),
                    textStyle: TextStyle(
                      color: AppColors.primary,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: AppColors.white,
                    enableActiveFill: true,
                    controller: codeController,
                    onCompleted: (value) {},
                    onChanged: (value) {
                      useEffect(() {
                        currentText.value = value;
                        return null;
                      });
                    },
                  ),
                  SizedBox(height: 24.h),
                  customButton(
                    onTap: () {
                      context.pushReplacement('/login');
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
