import 'dart:io';

import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/features/main/widgets/settings/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileHeader({
  required Color coverImageColor,
  required VoidCallback onChangeAvatarTap,
  required String avatar,
  required bool doesUserHaveimage,
  required bool isUpdated,
  File? imageFile,
}) {
  return Center(
    child: AvatarWidget(
      image: avatar, //  widget.avatar,
      radius: 60.r, // Set your desired initial size
      iconBackgroudColor: AppColors.primary,
      doesUserHaveimage: doesUserHaveimage,
      isUpdated: isUpdated,
      imageFile: imageFile,
      onChangeAvatarTap: onChangeAvatarTap,
    ),
  );
}
