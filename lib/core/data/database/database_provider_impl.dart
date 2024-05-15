import 'dart:developer';

import 'package:stylish/core/data/database/database_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseProviderImpl extends DatabaseProvider {
  final Supabase supabase;
  DatabaseProviderImpl({required this.supabase});
  @override
  Future<Map<String, dynamic>?> getFirstFilteredEqData(
    String tableName,
    String data,
    String dataEqualTo,
  ) async {
    final res = await supabase.client
        .from(tableName)
        .select()
        .filter(data, 'eq', dataEqualTo)
        .limit(1);
    return res.firstOrNull;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllData(String tableName) async {
    final res = await supabase.client.from(tableName).select().count();

    return res.data;
  }

  @override
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    final res = await supabase.client.from(tableName).insert(data);
    log(res.toString());
  }

  @override
  Future<void> updateData(String tableName, Map<String, dynamic> data) async {
    final res = await supabase.client
        .from(tableName)
        .update(data)
        .match({'id': data['id']});
    log(res.toString());
  }

  @override
  Future<List<Map<String, dynamic>>> getOverlappedDataWithSale(
    String tableName,
    String data,
    List<String> dataEqualTo,
  ) async {
    final res = await supabase.client
        .from(tableName)
        .select()
        .overlaps(data, dataEqualTo)
        .gt('sale', 0);
    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getOverlappedData(
    String tableName,
    String data,
    List<String> dataEqualTo,
  ) async {
    final res = await supabase.client
        .from(tableName)
        .select()
        .overlaps(data, dataEqualTo);

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getFilteredEqData(
    String tableName,
    String data,
    List<String> dataEqualTo,
  ) async {
    final res = await supabase.client
        .from(tableName)
        .select()
        .filter(data, 'eq', dataEqualTo);
    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getFilteredEqDataFromString(
    String tableName,
    String data,
    String dataEqualTo,
  ) async {
    final res = await supabase.client
        .from(tableName)
        .select()
        .filter(data, 'eq', dataEqualTo);
    return res;
  }
}
