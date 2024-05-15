import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/app_images.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/payment/controller/paymob_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stylish/features/main/data/models/product_model.dart';
import 'package:stylish/features/payment/widgets/two_texts_space_between.dart';

class PaymentScreen extends StatelessWidget {
  final List<ProductModel> productModel;
  final List<String> color;
  final List<String> size;
  final List<String> quantity;
  const PaymentScreen({
    super.key,
    required this.productModel,
    required this.color,
    required this.size,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<PaymobController>()
        ..setPrice(
          productModel.map((e) => e.price!.toDouble()).toList(),
          productModel.map((e) => (e.sale ?? 0).toDouble()).toList(),
        ),
      child: Consumer<PaymobController>(
        builder: (BuildContext context, PaymobController model, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Checkout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32.h),
                      SizedBox(
                        height: 100.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 200.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                        AppConstants.storageUrl +
                                            productModel
                                                .elementAt(index)
                                                .images!
                                                .elementAt(0)),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productModel.elementAt(index).name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 16.sp,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        richText(
                                            textOnLeft: 'Brand:',
                                            textOnRight: productModel
                                                .elementAt(index)
                                                .company!),
                                        richText(
                                            textOnLeft: 'Delivery in: ',
                                            textOnRight: '1 week'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 16.w);
                          },
                          itemCount: productModel.length,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Divider(
                        color: AppColors.grey,
                      ),
                      SizedBox(height: 16.h),
                      twoTextsSpaceBetween(
                          textOnLeft: "Color", textOnRight: color.toString()),
                      SizedBox(height: 16.h),
                      twoTextsSpaceBetween(
                          textOnLeft: "Size", textOnRight: size.toString()),
                      SizedBox(height: 16.h),
                      twoTextsSpaceBetween(
                          textOnLeft: "Quanity",
                          textOnRight: quantity.toString()),
                      SizedBox(height: 16.h),
                      Divider(
                        color: AppColors.grey,
                      ),
                      SizedBox(height: 16.h),
                      twoTextsSpaceBetween(
                          textOnLeft: "Order",
                          textOnRight: model.price.toString()),
                      SizedBox(height: 16.h),
                      twoTextsSpaceBetween(
                          textOnLeft: "Shipping", textOnRight: "30"),
                      SizedBox(height: 16.h),
                      twoTextsSpaceBetween(
                          textOnLeft: "Total",
                          textOnRight: (model.price + 30).toString()),
                      SizedBox(height: 16.h),
                      Divider(
                        color: AppColors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Payment',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RadioListTile<bool>(
                        value: false,
                        activeColor: AppColors.primary,
                        groupValue: model.paymentChoice,
                        onChanged: (_) {
                          model.changePaymentMethod(false);
                        },
                        title: Text(
                          'Pay With Online Card',
                          style: TextStyle(
                            color: Color(0xFF6E7179),
                            fontSize: 15.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Image.asset(
                              AppImages.visa,
                              width: 40.w,
                              height: 40.h,
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              AppImages.mastercard,
                              width: 40.w,
                              height: 40.h,
                            ),
                          ],
                        ),
                      ),
                      RadioListTile<bool>(
                        value: true,
                        activeColor: AppColors.primary,
                        groupValue: model.paymentChoice,
                        onChanged: (_) {
                          model.changePaymentMethod(true);
                        },
                        title: Text(
                          'Pay With Mobile Wallet',
                          style: TextStyle(
                            color: Color(0xFF6E7179),
                            fontSize: 15.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Image.asset(
                              AppImages.etisalat,
                              width: 40.w,
                              height: 40.h,
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              AppImages.orange,
                              width: 40.w,
                              height: 40.h,
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              AppImages.vodafone,
                              width: 40.w,
                              height: 40.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: AppColors.greyScaffoldBg,
              child: customButton(
                enabled: !model.isLoading,
                onTap: () {
                  model.color = color;
                  model.size = size;
                  model.quantity = quantity;
                  model.userModel = context.read<AuthController>().userModel;
                  log(model.userModel.toString());
                  model.getListOfProducts(productModel, quantity);
                  model.pay(context).then((value) {
                    if (model.failure != null) {
                      Fluttertoast.showToast(
                          msg: model.failure!.messege,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.sp);
                    } else {
                      model.addProductToPaidItems().then((value) {
                        context.pushReplacement('/map_with_location');
                      });
                    }
                  });
                  // context.pop('/main');
                  // if (model.failure == null) {
                  //   successAlertDialogWidget(context);
                  // }
                  //model.addProductToPaidItems();
                },
                text: "Pay Now",
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget richText({required String textOnLeft, required String textOnRight}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: textOnLeft,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 13.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: textOnRight,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
