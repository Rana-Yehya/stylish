import 'package:stylish/core/constants/constants.dart';
import 'package:flutter/material.dart';

Widget carouselImage(String imageUrl) {
  return Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Image.network(AppConstants.storageUrl + imageUrl,
          fit: BoxFit.cover, width: 1000.0),
      // Positioned(
      //   bottom: 0.0,
      //   left: 0.0,
      //   right: 0.0,
      //   child: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [
      //           Color.fromARGB(200, 0, 0, 0),
      //           Color.fromARGB(0, 0, 0, 0)
      //         ],
      //         begin: Alignment.bottomCenter,
      //         end: Alignment.topCenter,
      //       ),
      //     ),
      //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      // child: Text(
      //   'No image',
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontSize: 20.0,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
    ),
  );
}
