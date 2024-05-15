import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/colors.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';
import 'package:stylish/core/widgets/images/carousel_image.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/main/data/models/product_model.dart';
import 'package:stylish/features/main/widgets/home/discount_widget.dart';
import 'package:stylish/features/main/widgets/home/product_card.dart';
import 'package:stylish/features/product_view/controller/add_product_controller.dart';
import 'package:stylish/features/product_view/data/models/cart_wishlist_model.dart';
import 'package:stylish/features/product_view/presentation/helpers/add_item_to_cart_or_buy_now.dart';
import 'package:stylish/features/product_view/presentation/widgets/color_container.dart';
import 'package:stylish/features/product_view/presentation/widgets/shoes_size-container.dart';
import 'package:stylish/features/product_view/presentation/widgets/size_container.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:stylish/features/main/widgets/home/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductViewPage extends StatelessWidget {
  final ProductModel productModel;
  const ProductViewPage({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<AuthController>().userModel;
    return ChangeNotifierProvider(
      create: (_) => getIt<AddProductController>()
        ..findInWishList(
          cartWishlistModel: CartWishlistModel(
            productId: productModel.id,
            userId: userModel!.id!.toString(),
          ),
        )
        ..getProducts(productModel.category!),
      child: Consumer<AddProductController>(
        builder:
            (BuildContext context, AddProductController model, Widget? child) {
          return model.isLoading == true
              ? Scaffold(
                  backgroundColor: AppColors.greyScaffoldBg,
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: AppColors.greyScaffoldBg,
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          model.addToWishlist(
                            cartWishlistModel: CartWishlistModel(
                              productId: productModel.id,
                              userId: userModel!.id!.toString(),
                              isProductinWishlist: model.isInWishList != null
                                  ? !model.isInWishList!
                                  : true,
                            ),
                          );
                        },
                        icon: Icon(
                          model.isInWishList == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: false,
                          ),
                          items: productModel.images!
                              .map((e) => carouselImage(e))
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 24.h),
                                Text(
                                  productModel.name!,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  productModel.company!,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                ratingWidget(rating: 2.5, reviewCount: 25),
                                Row(
                                  children: [
                                    Text(
                                      productModel.sale != 0 &&
                                              productModel.sale != null
                                          ? '\$${productModel.price! - productModel.price! * (productModel.sale! / 100)}  '
                                          : '\$$productModel.price',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 16.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    productModel.sale != 0 &&
                                            productModel.sale != null
                                        ? discountWidget(
                                            oldPrice:
                                                productModel.price!.toDouble(),
                                            sale: productModel.sale!.toDouble())
                                        : Card(),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Product Details',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                ReadMoreText(
                                  productModel.description!,
                                  trimMode: TrimMode.Line,
                                  trimLines: 2,
                                  colorClickableText: AppColors.primary,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(height: 20.h),
                                // ratingDelivaryPriceTime(),

                                productModel.shoesSize != List.empty() &&
                                        productModel.shoesSize != null
                                    ? Text(
                                        'Available Sizes:',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                productModel.shoesSize != List.empty() &&
                                        productModel.shoesSize != null
                                    ? SizedBox(height: 8.h)
                                    : SizedBox.shrink(),
                                productModel.shoesSize != List.empty() &&
                                        productModel.shoesSize != null
                                    ? SizedBox(
                                        height: 30.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return shoesSizeContainer(
                                              size: productModel.shoesSize!
                                                  .elementAt(index),
                                              selectedColor: AppColors.primary,
                                            );
                                          },
                                          //  separatorBuilder: (context, index) {},
                                          itemCount:
                                              productModel.shoesSize!.length,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                productModel.shoesSize != List.empty() &&
                                        productModel.shoesSize != null
                                    ? SizedBox(height: 20.h)
                                    : SizedBox.shrink(),

                                productModel.size != List.empty() &&
                                        productModel.size != null
                                    ? Text(
                                        "Size",
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                productModel.size != List.empty() &&
                                        productModel.size != null
                                    ? SizedBox(height: 8.h)
                                    : SizedBox.shrink(),
                                productModel.size != List.empty() &&
                                        productModel.size != null
                                    ? SizedBox(
                                        height: 40.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return sizeContainer(
                                                size: productModel.size!
                                                    .elementAt(index),
                                                selectedColor:
                                                    AppColors.primary);
                                          },
                                          //  separatorBuilder: (context, index) {},
                                          itemCount: productModel.size!.length,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                productModel.size != List.empty() &&
                                        productModel.size != null
                                    ? SizedBox(height: 20.h)
                                    : SizedBox.shrink(),

                                Text(
                                  "Colors",
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
                                      return colorContainer(
                                          color: productModel.color!
                                              .elementAt(index)
                                              .colorFronString(),
                                          selected: true);
                                    },
                                    //  separatorBuilder: (context, index) {},
                                    itemCount: productModel.color!.length,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                model.products != List.empty()
                                    ? Text(
                                        'Similar To',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 20.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                model.products != List.empty()
                                    ? SizedBox(height: 8.h)
                                    : SizedBox.shrink(),

                                model.products != List.empty()
                                    ? SizedBox(
                                        //     width: 330.w,
                                        height: 250.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: model.products.length,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.h),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (model.products[index].id !=
                                                productModel.id) {
                                              return productCard(
                                                  onTap: () {
                                                    context.push(
                                                        "/product_view",
                                                        extra: {
                                                          "productModel": model
                                                              .products
                                                              .elementAt(index),
                                                        });
                                                  },
                                                  image:
                                                      AppConstants.storageUrl +
                                                          model.products[index]
                                                              .images!
                                                              .elementAt(0),
                                                  name: model
                                                      .products[index].name!,
                                                  description: model
                                                      .products[index]
                                                      .description!,
                                                  oldPrice: double.parse(model
                                                      .products[index].price!
                                                      .toString()),
                                                  sale: double.parse((model
                                                              .products[index]
                                                              .sale ??
                                                          0)
                                                      .toString()),
                                                  rating: 2.5,
                                                  reviewCount: 344567);
                                            } else {
                                              return SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomAppBar(
                    elevation: 0,
                    color: AppColors.greyScaffoldBg,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: customButton(
                              //   enabled: !model.isSubLoading,
                              onTap: () async {
                                addItemToCartOrBuyNow(
                                    context: context,
                                    enabled: !model.isCartLoading,
                                    text: model.isInCart == false
                                        ? "Remove from cart"
                                        : "Add Now",
                                    size: productModel.size,
                                    shoesSize: productModel.shoesSize,
                                    colors: productModel.color!,
                                    model: model,
                                    onTap: () {
                                      log(userModel!.id.toString());
                                      model.addToCart(
                                        cartWishlistModel: CartWishlistModel(
                                          productId: productModel.id,
                                          userId: userModel.id!.toString(),
                                          isProductinWishlist:
                                              model.isInCart != null
                                                  ? !model.isInCart!
                                                  : false,
                                        ),
                                      );
                                      context.pop();
                                    });
                              },
                              text: model.isInCart == false
                                  ? 'Added To Cart'
                                  : 'Add To Cart',
                              color: AppColors.white,
                              textColor: AppColors.primary,
                              borderColor: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: customButton(
                              onTap: () {
                                addItemToCartOrBuyNow(
                                  context: context,
                                  text: "Buy Now",
                                  size: productModel.size,
                                  shoesSize: productModel.shoesSize,
                                  colors: productModel.color!,
                                  model: model,
                                  onTap: () {
                                    context.push('/payment', extra: {
                                      'productModel': [productModel],
                                      'color': [
                                        productModel.color!
                                            .elementAt(model.selectedColor!)
                                      ],
                                      'size': [
                                        productModel.size != null
                                            ? productModel.size!
                                                .elementAt(model.selectedSize!)
                                            : productModel.shoesSize!.elementAt(
                                                model.selectedShoesSize!)
                                      ],
                                      'quantity': [model.quantity.toString()],
                                    });
                                    // log(userModel!.id.toString());
                                    // model.addToCart(
                                    //   cartWishlistModel: CartWishlistModel(
                                    //     productId: 6,
                                    //     userId: userModel.id!.toString(),
                                    //     isProductinWishlist: false,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                              text: 'Buy Now',
                              // color: AppColors.white,
                              // textColor: AppColors.primary,
                              // borderColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
