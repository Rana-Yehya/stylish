import 'package:dartz/dartz.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';

abstract class AuthProvider {
  Future<Either<Failure, UserModel>> signInWithEmail(
      {required UserModel userModel});

  Future<Either<Failure, UserModel>> signUpNewUser(
      {required UserModel userModel});
  Future<Either<Failure, void>> sendVerificationEmail(
      {required UserModel userModel});
  UserModel? currentSession();
  Future<Either<Failure, void>> resetPasswordForEmail(
      {required UserModel userModel});
  Future<Either<Failure, UserModel>> googleSignIn();
  Future<void> signOut();
}
