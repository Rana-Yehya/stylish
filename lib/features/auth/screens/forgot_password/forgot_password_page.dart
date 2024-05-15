import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/core/widgets/text_field/custom_text_form_field.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends HookWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: "example@gmail.com");
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
            child: Consumer<AuthController>(
              builder:
                  (BuildContext context, AuthController model, Widget? child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot\npassword?',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 36,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 36.h),
                    // enail

                    CustomTextFormField(
                      prefix: Icon(
                        Icons.email,
                        color: AppColors.greyText,
                      ),
                      textEditingController: emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      hintText: "Email",
                    ),
                    SizedBox(height: 24.h),

                    customButton(
                      onTap: () {
                        model.resetPasswordForEmail(
                            email: emailController.text.trim());
                        model.failure == null
                            ? context.pushReplacement('/main')
                            : Fluttertoast.showToast(
                                msg: model.failure!.messege,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.sp);
                        /*
                        model.failure == null
                            ? context.pushReplacement('/password_verification')
                            : Fluttertoast.showToast(
                                msg: model.failure!.messege,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.sp);
                                */
                      },
                      enabled: !model.isLoading,
                      text: "Send Code",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
