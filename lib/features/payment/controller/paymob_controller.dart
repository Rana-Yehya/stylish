import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/constants/app_images.dart';
import 'package:dio/dio.dart';
import 'package:stylish/core/constants/constants.dart';
import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:stylish/features/main/data/models/product_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymobController extends BaseRootChangeNotifier {
  final Dio dio;
  final DatabaseProviderImpl databaseProviderImpl;
  PaymobController({required this.dio, required this.databaseProviderImpl});
  bool? paymentChoice;
  void changePaymentMethod(bool? value) {
    paymentChoice = value;
    setState();
  }

  UserModel? userModel;
  List<String>? color;
  List<String>? size;
  List<String>? quantity;
  double price = 0;
  List<int> itemsId = List.empty(growable: true);
  List<Map<String, String>> items = List.empty(growable: true);
  double setFinalPrice(double productPrice, double sale) {
    return (productPrice - (productPrice * (sale / 100)));
  }

  setPrice(List<double> productPrice, List<double> sale) {
    int index = 0;
    for (var element in productPrice) {
      price = price + setFinalPrice(element, sale.elementAt(index));
    }
    //  price = setFinalPrice(productPrice, sale);
    setState();
  }

  Future<String> getPaymentKey(String currency) async {
    try {
      String authanticationToken = await _getAuthanticationToken();

      int orderId = await _getOrderId(
        authanticationToken: authanticationToken,
        amount: (100 * (price + 30)).toInt().toString(),
        currency: currency,
      );

      String paymentKey = await _getPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100 * (price + 30)).toInt().toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      return paymentKey;
    } catch (e) {
      //print("Exc==========================================");
      //print(e.toString());
      throw Exception();
    }
  }

  Future<String> _getAuthanticationToken() async {
    try {
      final Response response =
          await dio.post("https://accept.paymob.com/api/auth/tokens", data: {
        "api_key": AppConstants.paymobApiKey,
      });
      return response.data["token"];
    } catch (_) {
      throw Exception();
      //return null;
    }
  }

  Future<int> _getOrderId({
    required String authanticationToken,
    required String amount,
    required String currency,
  }) async {
    try {
      log(items.toString());
      final Response response = await dio
          .post("https://accept.paymob.com/api/ecommerce/orders", data: {
        "auth_token": authanticationToken,
        "amount_cents": amount, //  >>(STRING)<<
        "currency": currency, //Not Req
        "delivery_needed": "false",
        "items": items,
      });
      return response.data["id"]; //INTGER
    } catch (_) {
      throw Exception();
    }
  }

  Future<String> _getPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    try {
      final data = {
        //ALL OF THEM ARE REQIERD
        "expiration": 3600,

        "auth_token": authanticationToken, //From First Api
        "order_id": orderId, //From Second Api  >>(STRING)<<
        "integration_id": paymentChoice == true
            ? AppConstants.mobilePaymentMethodIntegrationId
            : AppConstants
                .cardPaymentMethodIntegrationId, //Integration Id Of The Payment Method

        "amount_cents": amount,
        "currency": currency,

        "billing_data": {
          //Have To Be Values
          "first_name": "Clifford",
          "last_name": "Nicolas",
          "email": userModel!.email,
          "phone_number": userModel!.phone == '' || userModel!.phone == null
              ? "NA"
              : userModel!.phone,
          // "phone_number": userModel!.phone ?? "",

          //Can Set "NA"
          "apartment": "803",
          "floor": "42",
          "street": "Ethan Land",
          "building": "8028",
          "shipping_method": "PKG",
          "postal_code": "01898",
          "city": "Jaskolskiburgh",
          "country": "CR",
          "state": "Utah"
        },
      };
      log(data.toString());
      final Response response = await dio.post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: data,
      );
      return response.data["token"];
    } catch (_) {
      throw Exception();
    }
  }

  Future<void> pay(BuildContext context) async {
    isLoading = true;
    setBusy();
    final paymentKey = await getPaymentKey("EGP");
    if (userModel!.phone != '' && paymentChoice == true) {
      // final paymentKey = await getPaymentKey("EGP");

      final Response response = await dio
          .post("https://accept.paymob.com/api/acceptance/payments/pay", data: {
        "source": {"identifier": userModel!.phone, "subtype": "WALLET"},
        "payment_token": paymentKey // token obtained in step 3
      });
      log(response.data["iframe_redirection_url"].toString());
      await launchUrl(
        Uri.parse(response.data["iframe_redirection_url"]),
      );
    } else if (paymentChoice != true) {
      await launchUrl(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/816095?payment_token=$paymentKey"),
      );
    } else {
      // TODO: Show Error
      failure = Failure(messege: 'Error purchasing the item(s)');
    }

    // await _callBackTransaction();

    isLoading = false;
    setIdle();
  }

  Future<void> addProductToPaidItems() async {
    if (failure == Failure(messege: '') || failure == null) {
      log(items.map((e) => e["name"]).toList().toString());
      log(items.map((e) => e["quantity"]).toList().toString());
      await databaseProviderImpl.insertData('paid-items', {
        "user_id": userModel!.id!,
        "product_id": itemsId,
        "name": items.map((e) => e["name"]).toList(),
        "quantity": items.map((e) => e["quantity"]).toList(),
        "colors": color,
        "size": size,
      });
    }
  }

  void successAlertDialogWidget(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.success,
                width: 50,
                height: 50,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Done'),
              onPressed: () {
                context.pushReplacement('/map_with_location');
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> _callBackTransaction() async {
  //   try {
  //     final Response response = await dio.post(
  //       "https://accept.paymobsolutions.com/api/acceptance/post_pay",
  //     );
  //     log(response.data.toString());

  //     //return response.data["id"]; //INTGER
  //   } catch (_) {
  //     throw Exception();
  //   }
  // }

  void getListOfProducts(
      List<ProductModel> productModel, List<String> quantity) {
    int index = 0;
    for (var element in productModel) {
      //var  index = productModel.indexWhere((e) => e == element);
      itemsId.add(element.id!);
      items.add({
        "name": element.name!,
        "amount_cents": setFinalPrice(
                element.price!.toDouble(), (element.sale ?? 0).toDouble())
            .toString(),
        "description": element.description!,
        "quantity": quantity.elementAt(index).toString(),
      });
      index = index + 1;
    }
  }
}
