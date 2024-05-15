import 'package:dartz/dartz.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:stylish/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_provider.dart';

class AuthProviderImpl extends AuthProvider {
  final Supabase supabase;
  AuthProviderImpl({required this.supabase});
  @override
  Future<Either<Failure, UserModel>> signInWithEmail(
      {required UserModel userModel}) async {
    late AuthResponse res;
    try {
      res = await supabase.client.auth.signInWithPassword(
          email: userModel.email, password: userModel.password!);
      return Right(UserModel(
        id: res.user!.id,
        email: res.user!.email!,
        phone: res.user!.phone,
        createdAt: res.user!.createdAt,
        emailConfirmedAt: true,
        // phoneConfirmedAt: res.user!.phoneConfirmedAt,
      ));
    } on AuthApiException catch (error) {
      if (error.message == 'Email not confirmed') {
        return Right(UserModel(
          email: userModel.email,
          emailConfirmedAt: false,
          // phoneConfirmedAt: res.user!.phoneConfirmedAt,
        ));
      }
      return Left(Failure(messege: (error as AuthApiException).message));
    }
  }

  @override
  Future<Either<Failure, void>> sendVerificationEmail(
      {required UserModel userModel}) async {
    try {
      ResendResponse res = await supabase.client.auth.resend(
        email: userModel.email,
        type: OtpType.email,
      );
      return Right(null);
    } catch (error) {
      return Left(Failure(messege: (error as AuthApiException).message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPasswordForEmail(
      {required UserModel userModel}) async {
    try {
      await supabase.client.auth.resetPasswordForEmail(
        userModel.email,
      );
      return Right(null);
    } catch (error) {
      return Left(Failure(messege: (error as AuthApiException).message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpNewUser(
      {required UserModel userModel}) async {
    try {
      // AuthResponse res = await supabase.client.auth.signUp(
      //   email: userModel.email,
      //   password: userModel.password!,
      //   phone: userModel.phone!,
      // );

      AuthResponse res = await supabase.client.auth.signUp(
        email: userModel.email,
        password: userModel.password!,
        //phone: userModel.phone!,
        data: {
          // "email": userModel.email,
          // "password": userModel.password!,
          // "phone": userModel.phone!,
          "confirmation_sent_at": DateTime.now().toIso8601String(),
        },
      );
      return Right(UserModel(
        id: res.user!.id,
        email: res.user!.email!,
        phone: res.user!.phone,
        createdAt: res.user!.createdAt,
        // emailConfirmedAt: res.user!.emailConfirmedAt,
        // phoneConfirmedAt: res.user!.phoneConfirmedAt,
      ));
    } catch (error) {
      return Left(Failure(messege: (error as AuthApiException).message));
    }
  }

  @override
  UserModel? currentSession() {
    final session = supabase.client.auth.currentSession;
    if (session != null) {
      return UserModel(
        id: session.user.id,
        email: session.user.email!,
        phone: session.user.phone,
        createdAt: session.user.createdAt,
        // emailConfirmedAt: session.user.emailConfirmedAt,
        // phoneConfirmedAt: session.user.phoneConfirmedAt,
      );
    } else {
      return null;
    }
  }

  @override
  Future<Either<Failure, UserModel>> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    try {
      if (accessToken == null) {
        return Left(Failure(messege: 'No Access Token found.'));
      }
      if (idToken == null) {
        return Left(Failure(messege: 'No ID Token found.'));
      }

      AuthResponse res = await supabase.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      return Right(UserModel(
        id: res.user!.id,
        email: res.user!.email!,
        phone: res.user!.phone,
        createdAt: res.user!.createdAt,
        // emailConfirmedAt: res.user!.emailConfirmedAt,
        // phoneConfirmedAt: res.user!.phoneConfirmedAt,
      ));
    } catch (error) {
      return Left(Failure(messege: (error as AuthApiException).message));
    }
  }

  @override
  Future<void> signOut() async {
    await supabase.client.auth.signOut();
  }
}
