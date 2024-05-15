import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/features/main/data/models/blog_model.dart';
import 'package:stylish/features/main/data/models/product_model.dart';

class HomeController extends BaseRootChangeNotifier {
  final DatabaseProviderImpl databaseProviderImpl;
  HomeController({
    required this.databaseProviderImpl,
  });

  List<ProductModel> products = List<ProductModel>.empty(growable: true);
  List<BlogModel> blogs = List<BlogModel>.empty(growable: true);

  void getProducts() async {
    isLoading = true;
    failure = null;
    setBusy();
    final res = await databaseProviderImpl.getAllData('product');
    for (var element in res) {
      products.add(ProductModel.fromJson(element));
    }
    isLoading = false;
    setIdle();
    failure = null;
  }

  void getBlogs() async {
    isLoading = true;
    failure = null;
    notifyListeners();

    //  notifyListeners();
    final res = await databaseProviderImpl.getAllData('blogs');
    for (var element in res) {
      blogs.add(BlogModel.fromJson(element));
    }
    // res.map((e) {});
    setIdle();
    failure = null;
  }
}
