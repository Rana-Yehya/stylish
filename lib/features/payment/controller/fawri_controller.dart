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

enum PaymentMethod { PAYATFAWRY, CASHONDELIVERY, CARD, MWALLET }

class FawriController extends BaseRootChangeNotifier {
  final Dio dio;
  final DatabaseProviderImpl databaseProviderImpl;
  FawriController({required this.dio, required this.databaseProviderImpl});
  //Charge Request using Card

  Future<void> chargeRequestUsingCard(
      {required PaymentMethod paymentMethod}) async {
    try {
      final Response response = await dio.post(
        "hhttps://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/charge",
        data: {
          "merchantCode": AppConstants.paymobApiKey, // string FROM FAWRY
          "merchantRefNum": 2, // int FROM FAWRY
          "customerProfileId": 4, // int FROM FAWRY (optional)
          "paymentMethod": paymentMethod.name,
          "cardNumber": 45, // int
          'cardExpiryYear': 8, // int 2 digits
          'cardExpiryMonth': 44, // int 2 digits
          'cvv': 24, // int
          'customerName': 'dawd', // string (optional)
          'customerMobile': "Fwfdaw", // string
          'customerEmail': "af", // string
          'amount': 15, //decinal
          'description': "dwqfq", // string
          'language': "en-gb", //"ar-eg" - "en-gb"
          'chargeItems': [],
          'orderWebHookUrl':
              '', //WebHook Url used to notify your application back
        },
      );
      return response.data["token"];
    } catch (_) {
      throw Exception();
      //return null;
    }
  }

  //https://atfawry.fawrystaging.com/ECommerceWeb/Fawry/payments/charge
}
