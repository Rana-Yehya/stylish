import 'package:provider/provider.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/main/controller/checkout_controller.dart';
import 'package:stylish/features/main/widgets/home/discount_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/home/rating_widget.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<AuthController>().userModel;
    return ChangeNotifierProvider<CheckoutController>(
      //initialData: getIt<HomeController>(),
      create: (_) => getIt<CheckoutController>()
        ..findPaidItems(
          userId: userModel!.id!,
        ),
      //update: (context, auth, previous) => previous..updates(auth.token, auth.userId)

      child: Consumer<CheckoutController>(
        builder:
            (BuildContext context, CheckoutController model, Widget? child) {
          return model.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 24.w),
                        child: Text(
                          'Coming to you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.location_pin,
                      //       size: 12.dg,
                      //       color: AppColors.black,
                      //     ),
                      //     SizedBox(width: 8.w),
                      //     Text(
                      //       'Delivery Address',
                      //       style: TextStyle(
                      //         color: AppColors.black,
                      //         fontSize: 14.sp,
                      //         fontFamily: 'Montserrat',
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 16.h),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Shopping List',
                      //       style: TextStyle(
                      //         color: AppColors.black,
                      //         fontSize: 14.sp,
                      //         fontFamily: 'Montserrat',
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     ElevatedButton(
                      //       onPressed: () {},
                      //       style: ButtonStyle(
                      //         backgroundColor: MaterialStateProperty.all(AppColors.primary),
                      //         padding: MaterialStateProperty.all(
                      //           EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         'Pay All',
                      //         style: TextStyle(
                      //           color: AppColors.white,
                      //           fontSize: 14.sp,
                      //           fontFamily: 'Montserrat',
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),

                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 16.h);
                          },
                          itemCount: model.paidProducts.length,
                          itemBuilder: (context, paidIndex) {
                            return SizedBox(
                              // width: double.infinity,
                              height: 180.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return shoppingListItem(
                                    image: AppConstants.storageUrl +
                                        model
                                            .products[paidIndex + index].images!
                                            .elementAt(0),
                                    name:
                                        model.products[paidIndex + index].name!,
                                    description: model
                                        .products[paidIndex + index]
                                        .description!,
                                    oldPrice: double.parse(model
                                        .products[paidIndex + index].price!
                                        .toString()),
                                    sale: double.parse((model
                                                .products[paidIndex + index]
                                                .sale ??
                                            0)
                                        .toString()),
                                    quantity: model.paidProducts[paidIndex]
                                        .quantity![index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 16.w);
                                },
                                itemCount: model.paidProducts
                                    .elementAt(paidIndex)
                                    .productId!
                                    .length,
                              ),
                            );
                            // return shoppingListItem();
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

Widget shoppingListItem({
  required String image,
  required String name,
  required String description,
  required double oldPrice,
  required double sale,
  required int quantity,
}) {
  return Container(
    width: 350.w,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      shadows: [
        BoxShadow(
          color: AppColors.shadowContainer,
          blurRadius: 14,
          offset: Offset(0, 6),
          spreadRadius: -8,
        ),
        BoxShadow(
          color: AppColors.shadowContainer,
          blurRadius: 9,
          offset: Offset(0, -4),
          spreadRadius: -7,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ratingWidget(rating: 2.5, reviewCount: 54),
                    Text(
                      sale != 0
                          ? '\$${oldPrice - oldPrice * (sale / 100)}'
                          : '\$$oldPrice',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sale != 0
                        ? discountWidget(oldPrice: oldPrice, sale: sale)
                        : Card(),
                    // discountWidget(sale: 10, oldPrice: 34),
                    // Text(
                    //   'Variations : ',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 12,
                    //     fontFamily: 'Montserrat',
                    //     fontWeight: FontWeight.w500,
                    //     height: 0.15,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Divider(
          color: Color(0xFFBBBBBB),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Order ($quantity):',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 12.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$${(oldPrice - oldPrice * (sale / 100)) * quantity}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 12.sp,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget addLocation() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.h),
    child: IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.add,
        size: 12.dg,
        color: AppColors.black,
      ),
    ),
  );
}

Widget locationWidget() {
  return Container(
    decoration: ShapeDecoration(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      shadows: [
        BoxShadow(
          color: AppColors.shadowContainer,
          blurRadius: 14,
          offset: Offset(0, 6),
          spreadRadius: -8,
        ),
        BoxShadow(
          color: AppColors.shadowContainer,
          blurRadius: 9,
          offset: Offset(0, -4),
          spreadRadius: -7,
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '227, Okuomba, Lagos',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text:
                    '216 St Paul\'s Rd, London N1 2LL, UK\nContact :  +44-784232',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 12.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.edit,
          size: 12.dg,
          color: AppColors.black,
        ),
      ],
    ),
  );
}
