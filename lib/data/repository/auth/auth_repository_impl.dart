import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/data/sources/auth/auth_firebase_service.dart';
import 'package:quickcar_aplication/domain/handleException/sign_in_exception.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';
import 'dart:io';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(AuthFirebaseService authFirebaseService);

  
  @override
  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest) async {
    try {
      return await sl<AuthFirebaseService>().signup(createUserRequest);
    } catch (e) {
      return Left(Exception("Error al registrar usuario: ${e.toString()}"));
    }
  }

  @override
  Future<Either<SignInException, String>> signin(CreateSignInUserRequest createSignInUserRequest) async {
    try {
      return await sl<AuthFirebaseService>().signin(createSignInUserRequest); 
    } catch (e) {
      return Left(SignInException("Error al iniciar sesión: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Exception, void>> signout() async {
    try {
      await sl<AuthFirebaseService>().signout();
      return Right(null);
    } catch (e) {
      return Left(Exception("Error al cerrar sesión: ${e.toString()}"));
    }
  }
  
  @override
  Future<Either<Exception, String>> uploadImages(String folder, File imageFile) async {
    try {
      return await sl<AuthFirebaseService>().uploadImages(folder, imageFile);
    } catch (e) {
      return Left(Exception("Error al cargar la imagen: ${e.toString()}"));
    }
  }
  
  @override
  Future<Either<Exception, String>> verifyEmailAndCreateUserTable(CreateUserRequest createUserRequest) async {
   try {
      return await sl<AuthFirebaseService>().verifyEmailAndCreateUserTable(createUserRequest); 
    } catch (e) {
      return Left(SignInException("Error al iniciar sesión: ${e.toString()}"));
    }
  }
}
