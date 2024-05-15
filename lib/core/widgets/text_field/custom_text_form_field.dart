import 'package:stylish/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String hintText;
  final String? labelText;
  final void Function(String _)? onChanged;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLines;
  final Widget? suffix;
  final Widget? prefix;

  const CustomTextFormField({
    super.key,
    this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.enabled,
    this.labelText,
    this.readOnly,
    this.maxLines,
    this.suffix,
    this.prefix,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      //style: Theme.of(context).textTheme.displaySmall,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      enabled: enabled,
      validator: validator,
      controller: textEditingController,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onChanged: onChanged, autofocus: false,
      decoration: InputDecoration(
        isDense: true,
        focusColor: AppColors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 2.5.w,
            color: AppColors.dustyWhite,
          ),
        ),
        fillColor: AppColors.form,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 2.5.w,
            color: AppColors.fillRed,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 2.5.w,
            color: AppColors.fillRed,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            width: 2.5.w,
            color: AppColors.dustyWhite,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        suffixIcon: suffix,
        prefixIcon: prefix,
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
