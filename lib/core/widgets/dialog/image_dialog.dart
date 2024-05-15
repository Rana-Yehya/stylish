import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<void> imageDialog({
  required BuildContext context,
  required String image,
  required bool doesUserHaveimage,
  required bool isUpdated,
  required File? imageFile,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: GestureDetector(
          onTap: () {
            context.pop(); // Dismiss the dialog on tap
          },
          child: SizedBox(
              width: 400.w, // Adjust dimensions as needed
              height: 400.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: isUpdated == true
                    ? Image.file(imageFile!)
                    : doesUserHaveimage == true
                        ? Image.network(image)
                        : Image.asset(image),
              ) // Display the profile image
              ),
        ),
      );
    },
  );
}
