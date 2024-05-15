import 'dart:io';

import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/widgets/dialog/image_dialog.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final Color iconBackgroudColor;
  final String image;
  final bool doesUserHaveimage;
  final bool isUpdated;
  final File? imageFile;
  final VoidCallback onChangeAvatarTap;
  const AvatarWidget({
    super.key,
    required this.image,
    required this.radius,
    required this.iconBackgroudColor,
    required this.doesUserHaveimage,
    required this.isUpdated,
    required this.onChangeAvatarTap,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    // final profileVm = Provider.of<UserProfileViewModel>(context);
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            await imageDialog(
              context: context,
              image: image,
              doesUserHaveimage: doesUserHaveimage,
              isUpdated: isUpdated,
              imageFile: imageFile,
            );
          },
          child: CircleAvatar(
            radius: radius,
            foregroundImage: (isUpdated == true
                ? FileImage(imageFile!)
                : doesUserHaveimage == true
                    ? NetworkImage(image)
                    : AssetImage(image)) as ImageProvider<Object>?,
            //     ? FileImage(profileVm.imageFile!) as ImageProvider<Object>
            //     : NetworkImage(
            //         profileVm.image == ''
            //             ? image
            //             : EndPoints.imagesUrl + profileVm.image,
            //       ),
          ),
        ),
        Positioned(
          bottom: 6.h,
          left: 6.w,
          child: InkWell(
            onTap: onChangeAvatarTap,
            child: Container(
              height: 28.h,
              width: 28.w,
              decoration: ShapeDecoration(
                color: AppColors.primary,
                shape: const OvalBorder(),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 14.dg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
