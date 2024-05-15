import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/core/widgets/text_field/custom_text_form_field.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulHookWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController =
      TextEditingController(text: "elrana112@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");
  final TextEditingController retypePasswordController =
      TextEditingController(text: "123456");
  final TextEditingController phoneController =
      TextEditingController(text: "123456");
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final nameController = useTextEditingController(text: exampleName);

    final isPasswordShown = useState(false);
    final isRetypePasswordShown = useState(false);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
            child: Consumer<AuthController>(
              builder:
                  (BuildContext context, AuthController model, Widget? child) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an \naccount',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 36.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 36.h),
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
                        validator: (value) {
                          if (value == null) {
                            return 'Email is Empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        prefix: Icon(
                          Icons.lock,
                          color: AppColors.greyText,
                        ),
                        textEditingController: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        obscureText: !(isPasswordShown.value),
                        suffix: IconButton(
                          onPressed: () {
                            isPasswordShown.value = !(isPasswordShown.value);
                            // return null;
                          },
                          icon: Icon(
                            isPasswordShown.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.greyText,
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Empty paswwords';
                          }
                          return null;
                        },
                        hintText: "Password",
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        prefix: Icon(
                          Icons.lock,
                          color: AppColors.greyText,
                        ),
                        textEditingController: retypePasswordController,
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        obscureText: !(isRetypePasswordShown.value),
                        suffix: IconButton(
                          onPressed: () {
                            isRetypePasswordShown.value =
                                !(isRetypePasswordShown.value);
                            // return null;
                          },
                          icon: Icon(
                            isRetypePasswordShown.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.greyText,
                          ),
                        ),
                        validator: (value) {
                          if (value != passwordController.text.trim()) {
                            return 'Unmatched paswwords';
                          }
                          return null;
                        },
                        hintText: "Retype Password",
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        prefix: Icon(
                          Icons.phone,
                          color: AppColors.greyText,
                        ),
                        textEditingController: phoneController,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        hintText: "Phone",
                        validator: (value) {
                          if (value == null) {
                            return 'Phone is Empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      customButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            model
                                .signUpNewUser(
                              userModel: UserModel(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                phone: phoneController.text.trim(),
                              ),
                            )
                                .then((_) {
                              model.failure == null
                                  ? context.pushReplacement('/verification')
                                  : Fluttertoast.showToast(
                                      msg: model.failure!.messege,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.sp);
                            });

                            // context.push('/access_location');
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Something is wromg with your entered data",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.sp);
                          }
                        },
                        enabled: !model.isLoading,
                        text: 'Sign Up',
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Do you have an account?",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "log in",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pop();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
