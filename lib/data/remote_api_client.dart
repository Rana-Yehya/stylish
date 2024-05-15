// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:get/get.dart';

// class RemoteApiClient extends GetConnect implements GetxService {
//   late String token;
//   final String url;
//   late Map<String, String> _headers;
//   RemoteApiClient({
//     required this.url,
//   }) {
//     baseUrl = url;
//     timeout = const Duration(seconds: 30);

//     _headers = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authenication': 'Bearer $token',
//     };
//   }

//   Future<Response> getData(String uri) async {
//     try {
//       final response = await get(uri);
//       return response;
//       /*
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw ServerErrorException();
//     }
//     */
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }
// }

// class ServerErrorException extends Error {}
