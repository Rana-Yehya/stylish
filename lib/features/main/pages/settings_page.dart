import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/app_images.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/core/widgets/text_field/custom_text_form_field.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:stylish/features/main/controller/settings_controller.dart';
import 'package:stylish/features/main/widgets/settings/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<AuthController>().userModel;
    return ChangeNotifierProvider<SettingsController>(
      //initialData: getIt<HomeController>(),
      create: (_) => getIt<SettingsController>()
        ..getUserData(
          id: userModel!.id!,
        ),
      //update: (context, auth, previous) => previous..updates(auth.token, auth.userId)

      child: Consumer<SettingsController>(
        builder:
            (BuildContext context, SettingsController model, Widget? child) {
          return model.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                    child: Column(
                      children: [
                        Text(
                          'Settings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 28.h),
                        profileHeader(
                          coverImageColor: AppColors.primary,
                          doesUserHaveimage: model.userModel!.image != null &&
                                  model.userModel!.image != ''
                              ? true
                              : false,
                          avatar: model.userModel!.image != null
                              ? '${AppConstants.storageUrl}/avatars/${model.userModel!.image}'
                              : AppImages.profile,
                          isUpdated: model.isImageUpdated,
                          imageFile: model.imageFile,
                          onChangeAvatarTap: () async {
                            await model.pickAndConvertImage();
                          },
                        ),
                        SizedBox(height: 28.h),
                        Text(
                          'Personal Details',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email Address',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          hintText: model.userModel!.email,
                          // hintColor: Colors.grey[500],
                          // controller: model.nameController,
                          // readOnly: false,
                        ),
                        SizedBox(height: 16.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Address',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          hintText:
                              "${model.userModel!.lat}, ${model.userModel!.lng}",
                          // hintColor: Colors.grey[500],
                          // controller: model.nameController,
                          // readOnly: false,
                        ),
                        SizedBox(height: 16.h),
                        customButton(
                          onTap: () async {
                            await model.uploadToDatabase().then((value) async {
                              await model.updateUserData();
                            });
                          },
                          text: "Update Your Profile",
                          //assetName: AppImages.google,
                        ),
                        SizedBox(height: 16.h),
                        customButton(
                          onTap: () {
                            context.read<AuthController>().signOut();
                            context.pushReplacement("/login");
                          },
                          color: AppColors.white,
                          textColor: AppColors.fillRed,
                          borderColor: AppColors.fillRed,
                          text: "Sign out",
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
