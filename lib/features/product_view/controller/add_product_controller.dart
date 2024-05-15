import 'dart:developer';

import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/features/main/data/models/product_model.dart';
import 'package:stylish/features/product_view/data/models/cart_wishlist_model.dart';

class AddProductController extends BaseRootChangeNotifier {
  final DatabaseProviderImpl databaseProviderImpl;
  AddProductController({
    required this.databaseProviderImpl,
  });
  CartWishlistModel userProducts = CartWishlistModel(
    productIds: List.empty(growable: true),
    isWishlist: List.empty(growable: true),
  );
  CartWishlistModel userProductsInWishList = CartWishlistModel(
    productIds: List.empty(growable: true),
    isWishlist: List.empty(growable: true),
  );
  List<ProductModel> products = List<ProductModel>.empty(growable: true);

  bool? isInWishList;
  bool? isInCart;
  int? selectedSize;
  int? selectedColor;
  int? selectedShoesSize;
  int quantity = 1;
  bool isCartLoading = false;
  bool isWishlistLoading = false;
  void changeSize(int index) {
    selectedSize = index;
    setState();
  }

  changeShoesSize(int index) {
    selectedShoesSize = index;
    setState();
  }

  changeColor(int index) {
    selectedColor = index;
    setState();
  }

  void changeQuantity(bool isIncreasing) {
    quantity = isIncreasing == true ? quantity + 1 : quantity - 1;
    setState();
  }

  void addToCart({required CartWishlistModel cartWishlistModel}) async {
    isCartLoading = true;
    failure = null;
    isInCart = cartWishlistModel.isProductinWishlist;
    // isInWishList = cartWishlistModel.isProductinWishlist;
    setBusy();
    setState();
    _addProduct(cartWishlistModel: cartWishlistModel);
    //  userProducts = CartWishlistModel.fromJson(res);
    // res.map((e) => userProducts.add(CartWishlistModel.fromJson(e)));
    //userProducts.add(cartWishlistModel);
    //final jsonDate = userProducts.map((e) => e.toJson()).toList();
    //  await databaseProviderImpl.insertData('cart-wishlist', jsonDate);
    isCartLoading = false;
    failure = null;
    setIdle();
  }

  void addToWishlist({required CartWishlistModel cartWishlistModel}) async {
    isWishlistLoading = true;
    failure = null;
    isInWishList = cartWishlistModel.isProductinWishlist;
    // isInWishList = cartWishlistModel.isProductinWishlist;
    setBusy();
    setState();
    _addProduct(cartWishlistModel: cartWishlistModel);
    //  userProducts = CartWishlistModel.fromJson(res);
    // res.map((e) => userProducts.add(CartWishlistModel.fromJson(e)));
    //userProducts.add(cartWishlistModel);
    //final jsonDate = userProducts.map((e) => e.toJson()).toList();
    //  await databaseProviderImpl.insertData('cart-wishlist', jsonDate);
    isWishlistLoading = false;
    failure = null;
    setIdle();
  }

  void _addProduct({required CartWishlistModel cartWishlistModel}) async {
    final res = await databaseProviderImpl.getFirstFilteredEqData(
        'cart-wishlist', 'id', cartWishlistModel.userId!);
    log(res.toString());
    if (res != null) {
      userProducts = CartWishlistModel.fromJson(res);
      if (userProducts.productIds!.contains(cartWishlistModel.productId)) {
        int index = userProducts.productIds!
            .indexWhere((element) => element == cartWishlistModel.productId);
        userProducts.productIds!.removeAt(index);
        userProducts.isWishlist!.removeAt(index);
      } else {
        log(userProducts.productIds.toString());
        userProducts.productIds!.add(cartWishlistModel.productId!);
        userProducts.isWishlist!.add(cartWishlistModel.isProductinWishlist!);
        log(userProducts.productIds.toString());
      }

      await databaseProviderImpl.updateData(
          'cart-wishlist', userProducts.toJson());
    } else {
      userProducts.productIds!.add(cartWishlistModel.productId!);
      userProducts.isWishlist!.add(cartWishlistModel.isProductinWishlist!);
      userProducts.userId = cartWishlistModel.userId;

      await databaseProviderImpl.insertData(
          'cart-wishlist', userProducts.toJson());
    }
  }

  void findInWishList({required CartWishlistModel cartWishlistModel}) async {
    isLoading = true;
    failure = null;
    setBusy();
    final res = await databaseProviderImpl.getFirstFilteredEqData(
        'cart-wishlist', 'id', cartWishlistModel.userId!);

    log(res.toString());
    if (res != null) {
      userProductsInWishList = CartWishlistModel.fromJson(res);
      if (userProductsInWishList.productIds!
          .contains(cartWishlistModel.productId)) {
        int index = userProductsInWishList.productIds!
            .indexWhere((element) => element == cartWishlistModel.productId);
        if (index != -1) {
          isInWishList = userProductsInWishList.isWishlist!.elementAt(index);
        }
      }
    }
    isLoading = false;
    failure = null;
    setIdle();
  }

  void getProducts(List<String> dataEqualTo) async {
    isLoading = true;
    failure = null;
    setBusy();
    final res = await databaseProviderImpl.getOverlappedData(
        'product', 'category', dataEqualTo);
    for (var element in res) {
      products.add(ProductModel.fromJson(element));
    }
    // log(res.toString());
    //   res.map((e) => products.add(.fromJson(e)));
    // log(products.toString());
    isLoading = false;
    setIdle();
    failure = null;
  }
}
