import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/colors.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/features/product_view/controller/add_product_controller.dart';
import 'package:stylish/features/product_view/presentation/widgets/color_container.dart';
import 'package:stylish/features/product_view/presentation/widgets/shoes_size-container.dart';
import 'package:stylish/features/product_view/presentation/widgets/size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void addItemToCartOrBuyNow({
  required BuildContext context,
  required String text,
  required List<String>? size,
  required List<String>? shoesSize,
  required List<String> colors,
  required AddProductController model,
  required VoidCallback onTap,
  bool enabled = true,
}) async {
  // final model = context.watch<AddProductController>();
  await showModalBottomSheet<void>(
    context: context,
    builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.greyScaffoldBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 16.h),
            shoesSize != List.empty() && shoesSize != null
                ? Text(
                    'Choose Size:',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : SizedBox.shrink(),
            shoesSize != List.empty() && shoesSize != null
                ? SizedBox(height: 8.h)
                : SizedBox.shrink(),
            shoesSize != List.empty() && shoesSize != null
                ? SizedBox(
                    height: 30.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            model.changeShoesSize(index);
                            //  setState(() {});
                          },
                          child: shoesSizeContainer(
                            size: shoesSize.elementAt(index),
                            selectedColor: model.selectedShoesSize == index
                                ? AppColors.primary
                                : null,
                          ),
                        );
                      },
                      //  separatorBuilder: (context, index) {},
                      itemCount: shoesSize.length,
                    ),
                  )
                : SizedBox.shrink(),
            shoesSize != List.empty() && shoesSize != null
                ? SizedBox(height: 20.h)
                : SizedBox.shrink(),
            size != List.empty() && size != null
                ? Text(
                    "Choose Size",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : SizedBox.shrink(),
            size != List.empty() && size != null
                ? SizedBox(height: 8.h)
                : SizedBox.shrink(),
            size != List.empty() && size != null
                ? SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            model.changeSize(index);
                            //  setState(() {});
                          },
                          child: sizeContainer(
                            size: size.elementAt(index),
                            selectedColor: model.selectedSize == index
                                ? AppColors.primary
                                : null,
                          ),
                        );
                      },
                      //  separatorBuilder: (context, index) {},
                      itemCount: size.length,
                    ),
                  )
                : SizedBox.shrink(),
            size != List.empty() && size != null
                ? SizedBox(height: 20.h)
                : SizedBox.shrink(),
            Text(
              "Choose Color: ",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      model.changeColor(index);
                      //  setState(() {});
                    },
                    child: colorContainer(
                      color: colors.elementAt(index).colorFronString(),
                      selected: model.selectedColor == index ? true : null,
                    ),
                  );
                },
                //  separatorBuilder: (context, index) {},
                itemCount: colors.length,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Quantity: ",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          model.quantity != 1
                              ? model.changeQuantity(false)
                              : null;
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: model.quantity == 1
                              ? Color(0xFF8B8B8B)
                              : AppColors.primary,
                        ),
                      ),
                      Text(
                        model.quantity.toString(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          model.changeQuantity(true);
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            customButton(
              onTap: onTap,
              text: text,
              //  enabled: !context.watch<AddProductController>().isCartLoading,
              // color: AppColors.white,
              // textColor: AppColors.primary,
              // borderColor: AppColors.primary,
            ),
          ],
        ),
      );
    },
  );
}
