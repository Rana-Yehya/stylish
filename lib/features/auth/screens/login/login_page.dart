import 'package:fluttertoast/fluttertoast.dart';
import 'package:stylish/core/constants/app_images.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/core/widgets/button/custom_button_with_image.dart';
import 'package:stylish/core/widgets/text_field/custom_text_form_field.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulHookWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: "");
    final passwordController = useTextEditingController(text: "");
    final isRememberMeChecked = useState(false);
    final isPasswordShown = useState(false);
    return Scaffold(
      body: SafeArea(
        child: Consumer<AuthController>(
          builder: (BuildContext context, AuthController model, Widget? child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome \nBack!',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 36.sp,
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
                        validator: (value) {
                          if (value == null) {
                            return 'Email is Empty';
                          }
                          return null;
                        },
                      ),

                      // password

                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        prefix: Icon(
                          Icons.lock,
                          color: AppColors.greyText,
                        ),
                        textEditingController: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
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
                            return 'Password is Empty';
                          }
                          return null;
                        },
                        hintText: "Password",
                      ),

                      SizedBox(height: 24.h),

                      //IconButton(onPressed: () {}, icon: isRememberMeChecked ? Ico,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: AppColors.primary,
                                  value: isRememberMeChecked.value,
                                  onChanged: (bool? value) {
                                    isRememberMeChecked.value = value ?? false;
                                  },
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        width: 1.w, color: AppColors.primary),
                                  ),
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.white),
                                ),
                                Text(
                                  "Remember Me",
                                  style: TextStyle(
                                    color: const Color(0xFF7E8A97),
                                    fontSize: 12.sp,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push('/forgot_password');
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12.sp,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      customButton(
                        enabled: !model.isLoading,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await model
                                .signInWithEmail(
                              userModel: UserModel(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            )
                                .then((value) async {
                              if (model.failure == null) {
                                if (model.userModel!.emailConfirmedAt == true) {
                                  await model.findLocation().then((value) {
                                    model.userModel!.lat == null ||
                                            model.userModel!.lng == null
                                        ? context
                                            .pushReplacement('/access_location')
                                        : context.pushReplacement('/main');
                                  });
                                } else {
                                  context.pushReplacement('/verification');
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: model.failure!.messege,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.sp);
                              }
                            });
                          }
                        },
                        text: "Login",
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push("/register");
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 27.h),

                      Center(
                        child: Text(
                          "Or",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.body,
                            fontSize: 16.sp,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      customButtonWithImage(
                        color: AppColors.white,
                        borderColor: AppColors.primary,
                        textColor: AppColors.primary,
                        onTap: () {
                          model.googleSignIn().then((value) {
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
                          });
                        },
                        text: "Login With Google",
                        assetName: AppImages.google,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
