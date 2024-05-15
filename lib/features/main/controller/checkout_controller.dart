import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/features/main/data/models/paid_item_product_model.dart';
import 'package:stylish/features/main/data/models/product_model.dart';

class CheckoutController extends BaseRootChangeNotifier {
  final DatabaseProviderImpl databaseProviderImpl;
  CheckoutController({
    required this.databaseProviderImpl,
  });
  List<PaidItemProductModel> paidProducts =
      List<PaidItemProductModel>.empty(growable: true);
  List<ProductModel> products = List<ProductModel>.empty(growable: true);

  void findPaidItems({required String userId}) async {
    isLoading = true;
    failure = null;
    setBusy();
    final res = await databaseProviderImpl.getFilteredEqDataFromString(
        'paid-items', 'user_id', userId);
    for (var element in res) {
      for (int i = 0; i < element['product_id'].length; i++) {
        final product = await databaseProviderImpl.getFirstFilteredEqData(
            'product', 'id', element['product_id'][i].toString());
        products.add(ProductModel.fromJson(product!));
      }

      paidProducts.add(PaidItemProductModel.fromJson(element));
    }
    isLoading = false;
    setIdle();
    failure = null;
  }
}
