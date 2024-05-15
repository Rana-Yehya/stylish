import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';

abstract class StorageProvider {
  // void getData(String tableName);

  Future<String> insertToStorage(
    String tableName,
    String data,
    Uint8List dataEqualTo,
    // String mimeType,
  );
  // Future<Map<String, dynamic>?> updateToStorage(
  //   String tableName,
  //   String data,
  //   String dataEqualTo,
  // );
}
