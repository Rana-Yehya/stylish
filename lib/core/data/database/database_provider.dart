import 'package:dartz/dartz.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';

abstract class DatabaseProvider {
  // void getData(String tableName);

  Future<Map<String, dynamic>?> getFirstFilteredEqData(
    String tableName,
    String data,
    String dataEqualTo,
  );
  Future<List<Map<String, dynamic>>> getOverlappedDataWithSale(
    String tableName,
    String data,
    List<String> dataEqualTo,
  );
  Future<List<Map<String, dynamic>>> getAllData(String tableName);
  Future<List<Map<String, dynamic>>> getFilteredEqData(
    String tableName,
    String data,
    List<String> dataEqualTo,
  );
  Future<List<Map<String, dynamic>>> getOverlappedData(
    String tableName,
    String data,
    List<String> dataEqualTo,
  );
  Future<void> insertData(String tableName, Map<String, dynamic> data);
  Future<void> updateData(String tableName, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> getFilteredEqDataFromString(
    String tableName,
    String data,
    String dataEqualTo,
  );
  // Future<List<Map<String, dynamic>>> filterData(
  //     String tableName, String dataKey, String dataValue,
  // );
}
