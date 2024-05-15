import 'dart:developer';

import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/features/main/data/models/product_model.dart';

class WishlistCartController extends BaseRootChangeNotifier {
  final DatabaseProviderImpl databaseProviderImpl;
  WishlistCartController({
    required this.databaseProviderImpl,
  });
  List<ProductModel> wishlistProducts =
      List<ProductModel>.empty(growable: true);
  List<ProductModel> cartProducts = List<ProductModel>.empty(growable: true);
  void findInUserFav({required String userId}) async {
    isLoading = true;
    failure = null;
    log(userId);
    setBusy();

    final res = await databaseProviderImpl.getFirstFilteredEqData(
        'cart-wishlist', 'id', userId);
    for (int i = 0; i < res!['product_ids'].length; i++) {
      final product = await databaseProviderImpl.getFirstFilteredEqData(
          'product', 'id', res['product_ids'][i].toString());
      if (res['is_wishlist'][i] == true) {
        wishlistProducts.add(ProductModel.fromJson(product!));
      } else {
        cartProducts.add(ProductModel.fromJson(product!));
      }
    }
    isLoading = false;
    setIdle();
    failure = null;
  }
}
