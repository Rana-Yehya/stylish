import 'dart:developer';

import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/models/static/categories_model.dart';
import 'package:stylish/core/widgets/app_bar/custom_app_bar.dart';
import 'package:stylish/core/widgets/images/carousel_image.dart';
import 'package:stylish/core/widgets/text_field/custom_fake_search_field.dart';
import 'package:stylish/features/main/controller/home_controller.dart';
import 'package:stylish/features/main/widgets/home/category_image_wuth_text.dart';
import 'package:stylish/features/main/widgets/home/product_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/home/see_more_widget.dart';

class HonePage extends StatelessWidget {
  const HonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      //initialData: getIt<HomeController>(),
      create: (_) => getIt<HomeController>()
        ..getBlogs()
        ..getProducts(),
      //update: (context, auth, previous) => previous..updates(auth.token, auth.userId)

      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController model, Widget? child) {
          log(model.isLoading.toString());
          return model.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // CustomAppBar
                      customAppBar(),
                      SizedBox(height: 16.h),
                      // Welcome text
                      CustomFakeSearchField(),
                      SizedBox(height: 16.h),
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                        ),
                        items: model.blogs
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  context.push('/search', extra: {
                                    "category": e.category!,
                                    "isSale": true
                                  });
                                },
                                child: carouselImage(e.image!),
                              ),
                            )
                            .toList(),
                      ),

                      SizedBox(height: 32.h),

                      // All categories
                      seeMoreWidget(textOnLeft: "All Categories"),
                      SizedBox(height: 20.h),
                      // List categories

                      SizedBox(
                        //   width: 100.w,
                        height: 90.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          //  padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 24.w),

                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          //  padding: EdgeInsets.symmetric(horizontal: 8.h),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                context.push('/search', extra: {
                                  "category": [
                                    categories.keys.elementAt(index)
                                  ],
                                  "isSale": false
                                });
                              },
                              child: categoryImageWithText(
                                  assetName: categories.values.elementAt(index),
                                  text: categories.keys.elementAt(index)),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 16.w);
                          },
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Open Restaurants
                      seeMoreWidget(
                        textOnLeft: 'Deal of the Day',
                      ),
                      SizedBox(
                        //     width: 330.w,
                        height: 250.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.products.length,
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          itemBuilder: (BuildContext context, int index) {
                            return productCard(
                                onTap: () {
                                  context.push("/product_view", extra: {
                                    "productModel":
                                        model.products.elementAt(index),
                                  });
                                },
                                image: AppConstants.storageUrl +
                                    model.products[index].images!.elementAt(0),
                                name: model.products[index].name!,
                                description: model.products[index].description!,
                                oldPrice: double.parse(
                                    model.products[index].price!.toString()),
                                sale: double.parse(
                                    (model.products[index].sale ?? 0)
                                        .toString()),
                                rating: 2.5,
                                reviewCount: 344567);
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
