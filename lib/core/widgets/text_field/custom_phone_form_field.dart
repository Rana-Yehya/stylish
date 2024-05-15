// import 'package:doctor_appointment_app/core/di/injections.dart';
// import 'package:doctor_appointment_app/core/theming/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class CustomPhoneFormField extends StatelessWidget {
//   final TextEditingController textEditingController;
//   final TextInputType textInputType;
//   final TextInputAction textInputAction;
//   final bool obscureText;
//   final String hintText;
//   final String? labelText;
//   final void Function(PhoneNumber)? onChanged;
//   final Future<String?> Function(PhoneNumber?)? validator;
//   final bool? enabled;
//   final bool? readOnly;
//   final int? maxLines;
//   final Widget? suffix;
//   final Widget? prefix;

//   const CustomPhoneFormField({
//     super.key,
//     required this.textEditingController,
//     this.textInputType = TextInputType.text,
//     this.textInputAction = TextInputAction.next,
//     this.obscureText = false,
//     required this.hintText,
//     this.onChanged,
//     this.validator,
//     this.enabled,
//     this.labelText,
//     this.readOnly,
//     this.maxLines,
//     this.suffix,
//     this.prefix,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return IntlPhoneField(
//       disableLengthCheck : true,
//       initialCountryCode: 'EG',
//       showDropdownIcon: true,
//       dropdownIcon: Icon(
//         Icons.keyboard_arrow_down_rounded,
//      //   color: Theme.of(context).iconTheme.color,
//       ),
//      // languageCode: context.read<SettingsBloc>().state.languageModel.value,
//      // style: Theme.of(context).textTheme.displaySmall,
//     //  dropdownTextStyle: Theme.of(context).textTheme.displaySmall,
//       invalidNumberMessage:
//           "Invalid Phone Number",
//       pickerDialogStyle: PickerDialogStyle(
//         // backgroundColor: Theme.of(context).canvasColor,
//         // countryNameStyle: Theme.of(context).textTheme.displaySmall,
//         // countryCodeStyle: Theme.of(context).textTheme.displaySmall,
//         // searchFieldInputDecoration: InputDecoration(
//         //   hintText: AppLocalizations.of(context)!
//         //       .translate("search_for_your_country"),
//         // ),
//       ),
//       readOnly: readOnly ?? false,
//       enabled: enabled ?? true,
//       validator: validator,
//       controller: textEditingController,
//       keyboardType: textInputType,
//       textInputAction: textInputAction,
//       obscureText: obscureText,
//       onChanged: onChanged, autofocus: false,
//       decoration: InputDecoration(
//         isDense: true,
//         focusColor: getIt<AppColors>().white,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide(
//             width: 2.5.w,
//             color: getIt<AppColors>().dustyWhite,
//           ),
//         ),
//         fillColor: getIt<AppColors>().form,
//         filled: true,
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide(
//             width: 2.5.w,
//             color: getIt<AppColors>().fillRed,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide(
//             width: 2.5.w,
//             color: getIt<AppColors>().fillRed,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide(
//             width: 2.5.w,
//             color: getIt<AppColors>().dustyWhite,
//           ),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//         suffixIcon: suffix,
//         prefixIcon: prefix,
//         labelText: labelText,
//         hintText: hintText,
//       ),
//     );
//   }
// }
