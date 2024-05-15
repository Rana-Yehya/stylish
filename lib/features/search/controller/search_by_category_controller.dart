import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/features/main/data/models/product_model.dart';

class SearchByCategoryController extends BaseRootChangeNotifier {
  final DatabaseProviderImpl databaseProviderImpl;
  SearchByCategoryController({
    required this.databaseProviderImpl,
  });
  List<ProductModel> products = List<ProductModel>.empty(growable: true);

  void getProductsWithSale(List<String> dataEqualTo) async {
    isLoading = true;
    failure = null;
    setBusy();
    final res = await databaseProviderImpl.getOverlappedDataWithSale(
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

  void getProducts(List<String> dataEqualTo) async {
    isLoading = true;
    failure = null;
    setBusy();
    final res = await databaseProviderImpl.getFilteredEqData(
        'product', 'category', dataEqualTo);
    for (var element in res) {
      products.add(ProductModel.fromJson(element));
    }
    isLoading = false;
    setIdle();
    failure = null;
  }
}
