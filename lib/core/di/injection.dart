import 'package:dio/dio.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/core/data/storage/storage_provider_impl.dart';
import 'package:stylish/core/location/current_location_helper.dart';
import 'package:stylish/features/auth/controller/auth_controller.dart';
import 'package:stylish/features/auth/data/datasource/auth_provider_impl.dart';
import 'package:stylish/features/main/controller/checkout_controller.dart';
import 'package:stylish/features/main/controller/settings_controller.dart';
import 'package:stylish/features/main/controller/wishlist_cart_controller.dart';
import 'package:stylish/features/payment/controller/fawri_controller.dart';
import 'package:stylish/features/payment/controller/paymob_controller.dart';
import 'package:stylish/features/main/controller/home_controller.dart';
import 'package:stylish/features/product_view/controller/add_product_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:stylish/features/search/controller/search_by_category_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance;

//@injectableInit
Future<void> configureInjection(/*String env*/) async {
  getIt.registerLazySingleton(() => Dio()
      /*
    ..options.baseUrl = apiBaseUrl
    ..options.connectTimeout = const Duration(milliseconds: 30000)
    ..options.receiveTimeout = const Duration(milliseconds: 30000)
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        await Future.delayed(delayDuration);
        return handler.next(options);
      },
    ))
    ..httpClientAdapter
    */
      );

  // getIt.registerLazySingleton(() => AppEndPoint());

  // getIt.registerLazySingleton(() => sharedPreferences);
  // getIt.registerLazySingleton(
  //   () => HttpClientHelper(httpClient: getIt()),
  // );

  getIt.registerLazySingleton(() => Supabase.instance);
  getIt.registerFactory(
    () => AuthProviderImpl(
      supabase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => DatabaseProviderImpl(
      supabase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => StorageProviderImpl(
      supabase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SearchByCategoryController(
      databaseProviderImpl: getIt(),
    ),
  );

  getIt.registerFactory(
    () => AuthController(
      authProviderImpl: getIt(),
      databaseProviderImpl: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AddProductController(
      databaseProviderImpl: getIt(),
    ),
  );

  getIt.registerFactory(
    () => HomeController(
      databaseProviderImpl: getIt(),
    ),
  );

  getIt.registerFactory(
    () => LocationHelper(),
  );
  getIt.registerFactory(
    () => FawriController(
      dio: getIt(),
      databaseProviderImpl: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SettingsController(
      databaseProviderImpl: getIt(),
      storageProviderImpl: getIt(),
    ),
  );
  getIt.registerFactory(
    () => CheckoutController(
      databaseProviderImpl: getIt(),
    ),
  );
  getIt.registerFactory(
    () => WishlistCartController(
      databaseProviderImpl: getIt(),
    ),
  );

  getIt.registerFactory(
    () => PaymobController(
      dio: getIt(),
      databaseProviderImpl: getIt(),
    ),
  );

  /*
  getIt.registerLazySingleton(
    () => AppIcons(),
  );
  */
}
