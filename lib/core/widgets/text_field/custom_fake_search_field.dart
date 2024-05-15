import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/widgets/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFakeSearchField extends StatelessWidget {
  const CustomFakeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomTextFormField(
        readOnly: true,
        hintText: 'Search any Product..',
        prefix: Icon(
          Icons.search,
          size: 16.dg,
          color: AppColors.lightgrey,
        ),
        suffix: Icon(
          Icons.mic_none_outlined,
          size: 16.dg,
          color: AppColors.lightgrey,
        ),
      ),
    );
  }
}
