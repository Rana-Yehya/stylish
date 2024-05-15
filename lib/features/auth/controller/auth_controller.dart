import 'dart:developer';

import 'package:stylish/core/controllers/base_notifier.dart';
import 'package:stylish/core/data/database/database_provider_impl.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/datasource/auth_provider_impl.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthController extends BaseRootChangeNotifier {
  final AuthProviderImpl authProviderImpl;
  final DatabaseProviderImpl databaseProviderImpl;
  AuthController({
    required this.authProviderImpl,
    required this.databaseProviderImpl,
  });
  UserModel? userModel = UserModel(email: '');
  Future<void> signInWithEmail({required UserModel userModel}) async {
    setBusy();
    isLoading = true;
    failure = null;
    final res = await authProviderImpl.signInWithEmail(userModel: userModel);
    res.fold((l) => failure = l, (r) => this.userModel = r);
    log(userModel.id.toString());
    isLoading = false;
    setIdle();
  }

  Future<void> sendVerificationEmail() async {
    setBusy();
    isLoading = true;
    failure = null;
    await authProviderImpl.sendVerificationEmail(userModel: userModel!);
    isLoading = false;
    setIdle();
  }

  void resetPasswordForEmail({required String email}) async {
    setBusy();
    userModel!.email = email;
    final res =
        await authProviderImpl.resetPasswordForEmail(userModel: userModel!);
    res.fold((l) => failure = l, (_) => null);
    setIdle();
  }

  Future<void> signUpNewUser({required UserModel userModel}) async {
    setBusy();
    isLoading = true;
    failure = null;
    final res = await authProviderImpl.signUpNewUser(userModel: userModel);
    res.fold((l) => failure = l, (r) => this.userModel = r);

    isLoading = false;
    setIdle();
  }

  void currentSession() {
    failure = null;
    userModel = authProviderImpl.currentSession();
  }

  Future<void> googleSignIn() async {
    setBusy();
    isLoading = true;
    failure = null;
    final res = await authProviderImpl.googleSignIn();
    res.fold((l) => failure = l, (r) => userModel = r);
    isLoading = false;
    setIdle();
  }

  void addLocation({double? lat, double? lng}) async {
    setBusy();
    isLoading = true;
    userModel!.lat = lat;
    userModel!.lng = lng;
    await databaseProviderImpl.insertData(
      'users',
      userModel!.toJson(),
    );
    // res.fold((l) => failure = l, (r) => userModel = r);
    isLoading = false;
    setIdle();
  }

  Future<void> findLocation({double? lat, double? lng}) async {
    setBusy();
    isLoading = true;

    final res = await databaseProviderImpl.getFirstFilteredEqData(
      'users',
      'id',
      userModel!.id!,
    );
    if (res != null) userModel = UserModel.fromJson(res);
    isLoading = false;
    setIdle();
  }

  void signOut() async {
    failure = null;

    // notifyListeners();
    await authProviderImpl.signOut();
    userModel = null;
    // notifyListeners();
  }
}
