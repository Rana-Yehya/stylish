import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/widgets/app_bar/custom_app_bar.dart';
import 'package:stylish/core/widgets/text_field/custom_fake_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/main/controller/wishlist_cart_controller.dart';
import 'package:stylish/features/main/widgets/home/product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<AuthController>().userModel;
    return ChangeNotifierProvider<WishlistCartController>(
      //initialData: getIt<HomeController>(),
      create: (_) => getIt<WishlistCartController>()
        ..findInUserFav(
          userId: userModel!.id!,
        ),
      //update: (context, auth, previous) => previous..updates(auth.token, auth.userId)

      child: Consumer<WishlistCartController>(
        builder: (BuildContext context, WishlistCartController model,
            Widget? child) {
          return model.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 24.w),
                      child: Text(
                        'Your favourite',
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
                    TabBar(
                      controller: _controller,
                      isScrollable: false,
                      indicatorColor: AppColors.primary,
                      tabs: [
                        Text(
                          'Wishlist',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Cart',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Welcome text
                    CustomFakeSearchField(),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${model.wishlistProducts.length} Items',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        customButtonWithIcon(
                                            text: 'Sort', icon: Icons.sort),
                                        SizedBox(width: 8.w),
                                        customButtonWithIcon(
                                            text: 'Filter', icon: Icons.filter),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                shrinkWrap: true,
                                // itemCount: model.wishlistProducts.length,
                                // itemBuilder: (context, index) {
                                children: model.wishlistProducts
                                    .map((e) => productCard(
                                          onTap: () {
                                            context
                                                .push("/product_view", extra: {
                                              "productModel": e,
                                            });
                                          },
                                          image: AppConstants.storageUrl +
                                              e.images!.elementAt(0),
                                          name: e.name!,
                                          description: e.description!,
                                          oldPrice:
                                              double.parse(e.price!.toString()),
                                          sale: double.parse(
                                              (e.sale ?? 0).toString()),
                                          rating: 2.5,
                                          reviewCount: 344567,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${model.cartProducts.length} Items',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        customButtonWithIcon(
                                            text: 'Sort', icon: Icons.sort),
                                        SizedBox(width: 8.w),
                                        customButtonWithIcon(
                                            text: 'Filter', icon: Icons.filter),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                shrinkWrap: true,
                                // itemCount: model.wishlistProducts.length,
                                // itemBuilder: (context, index) {
                                children: model.cartProducts
                                    .map(
                                      (e) => productCard(
                                        onTap: () {
                                          context.push("/product_view", extra: {
                                            "productModel": e,
                                          });
                                        },
                                        image: AppConstants.storageUrl +
                                            e.images!.elementAt(0),
                                        name: e.name!,
                                        description: e.description!,
                                        oldPrice:
                                            double.parse(e.price!.toString()),
                                        sale: double.parse(
                                            (e.sale ?? 0).toString()),
                                        rating: 2.5,
                                        reviewCount: 344567,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

Widget customButtonWithIcon({required String text, required IconData icon}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: ShapeDecoration(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(6.r)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$text ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 12.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
        Icon(icon, size: 16.dg, color: AppColors.black),
      ],
    ),
  );
}
