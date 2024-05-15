import 'dart:developer';
import 'dart:typed_data';

import 'package:stylish/core/data/storage/storage_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageProviderImpl extends StorageProvider {
  final Supabase supabase;
  StorageProviderImpl({required this.supabase});
  @override
  Future<String> insertToStorage(
    String tableName,
    String data,
    Uint8List dataEqualTo,
    // String mimeType,
  ) async {
    return await supabase.client.storage.from(tableName).uploadBinary(
          data,
          dataEqualTo,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
  }

  // Future<Map<String, dynamic>?> updateToStorage(
  //   String tableName,
  //   String data,
  //   String dataEqualTo,
  // ) {}
}
