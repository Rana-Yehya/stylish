import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/core/data/storage/storage_provider_impl.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsController extends BaseRootChangeNotifier {
  final StorageProviderImpl storageProviderImpl;
  final DatabaseProviderImpl databaseProviderImpl;
  final picker = ImagePicker();
  File? imageFile;
  String base64Image = '';
  bool isImageUpdated = false;
  SettingsController({
    required this.storageProviderImpl,
    required this.databaseProviderImpl,
  });
  Uint8List? imageBytes;
  UserModel? userModel;
  XFile? pickedFile;
  String? fileExt;
  void getUserData({required String id}) async {
    isLoading = true;
    failure = null;
    setBusy();
    final res =
        await databaseProviderImpl.getFirstFilteredEqData('users', 'id', id);
    userModel = UserModel.fromJson(res!);
    isLoading = false;
    setIdle();
  }

  Future<void> updateUserData() async {
    isLoading = true;
    failure = null;
    setBusy();
    userModel!.image = fileExt;
    await databaseProviderImpl.updateData('users', userModel!.toJson());
    // userModel = UserModel.fromJson(res!);
    isLoading = false;
    setIdle();
  }

  Future<void> pickAndConvertImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      // No image was picked
      //  General.showToast(message: 'لم يتم اختيار صوره');
    } else {
      imageFile = File(pickedFile!.path);
      fileExt = imageFile!.path.split('/').last;
      imageBytes = await pickedFile!.readAsBytes();
      isImageUpdated = true;
      setState();
      // Convert image bytes to base64 string
      // String base64String = base64Encode(imageBytes!);

      // Form the data URL with the appropriate MIME type
      // String mimeType = 'image/${pickedFile!.path.split('.').last}';
      // base64Image = 'data:$mimeType;base64,$base64String';
    }
  }

  Future<void> uploadToDatabase() async {
    isLoading = true;
    failure = null;
    setBusy();
    try {
      if (imageFile != null) {
        // final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
        // final filePath = fileName;
        await storageProviderImpl.insertToStorage(
          'avatars',
          fileExt!,
          imageBytes!,
          //  pickedFile!.mimeType!,
        );
      }
    } catch (e) {
      failure = Failure(messege: 'Failed to upload Image');
    }
    isLoading = false;
    setIdle();
  }
}
