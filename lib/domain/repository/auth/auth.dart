import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/domain/handleException/sign_in_exception.dart';

abstract class AuthRepository {
  /// Registra un nuevo usuario.
  /// 
  /// Devuelve un [Either] que contiene una [Exception] o un [String] (mensaje de éxito).
  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest);

  /// Sube imágenes a un directorio específico.
  /// 
  /// Devuelve un [Either] que contiene una [Exception] o un [String] (URL de la imagen).
  Future<Either<Exception, String>> uploadImages(String folder, File imageFile);

  Future<Either<Exception, String>> verifyEmailAndCreateUserTable(CreateUserRequest createUserRequest);

  /// Inicia sesión con un usuario existente.
  /// 
  /// Devuelve un [Either] que contiene un [SignInException] o un [String] (mensaje de éxito).
  Future<Either<SignInException, String>> signin(CreateSignInUserRequest createSignInUserRequest);

  /// Cierra la sesión del usuario actual.
  /// 
  /// Devuelve un [Either] que contiene una [Exception] o void si se cierra la sesión correctamente.
  Future<Either<Exception, void>> signout();
}
