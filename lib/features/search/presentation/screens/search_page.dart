import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/di/injection.dart';
import 'package:stylish/core/widgets/text_field/custom_text_form_field.dart';
import 'package:stylish/features/main/widgets/home/product_card.dart';
import 'package:stylish/features/search/controller/search_by_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchPage extends HookWidget {
  final List<String> category;
  final bool isSale;
  const SearchPage({super.key, required this.category, required this.isSale});

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    return Scaffold(
      backgroundColor: AppColors.greyScaffoldBg,
      appBar: AppBar(
        title: Text(
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ChangeNotifierProvider<SearchByCategoryController>(
        //initialData: getIt<HomeController>(),
        create: (_) {
          if (isSale == true) {
            return getIt<SearchByCategoryController>()
              ..getProductsWithSale(category);
          } else {
            print(isSale);
            return getIt<SearchByCategoryController>()..getProducts(category);
          }
        },
        //update: (context, auth, previous) => previous..updates(auth.token, auth.userId)

        child: Consumer<SearchByCategoryController>(
          builder: (BuildContext context, SearchByCategoryController model,
              Widget? child) {
            return model.isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),

                        // Search
                        CustomTextFormField(
                          textEditingController: searchTextController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          hintText: 'Search',
                        ),
                        SizedBox(height: 32.h),

                        // Recent Keywords
                        Text(
                          "Search result by category '${category.map((e) => e)}'",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 26.sp,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        SizedBox(height: 20.h),
                        Expanded(
                          child: GridView.builder(
                            itemCount: model.products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.w,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 16.h,
                            ),
                            itemBuilder: (context, index) {
                              return productCard(
                                  onTap: () {
                                    context.push("/product_view", extra: {
                                      "productModel":
                                          model.products.elementAt(index),
                                    });
                                  },
                                  image: AppConstants.storageUrl +
                                      model.products[index].images!
                                          .elementAt(0),
                                  name: model.products[index].name!,
                                  description:
                                      model.products[index].description!,
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
      ),
    );
  }
}
