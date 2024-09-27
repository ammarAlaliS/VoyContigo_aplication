import 'package:dartz/dartz.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/data/sources/auth/auth_firebase_service.dart';
import 'package:quickcar_aplication/domain/repository/auth/auth.dart';
import 'package:quickcar_aplication/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  
  // Implementación del registro de usuario
  @override
  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest) async {
    try {
      return await sl<AuthFirebaseService>().signup(createUserRequest);
    } catch (e) {
      return Left(Exception("Error al registrar usuario"));
    }
  }

  // Implementación del inicio de sesión
  @override
  Future<Either<Exception, String>> signin(CreateSignInUserRequest createSignInUserRequest) async {
    try {
      return await sl<AuthFirebaseService>().signin(createSignInUserRequest); 
    } catch (e) {
      return Left(Exception("Error al iniciar sesión"));
    }
  }

  // Implementación del cierre de sesión
  @override
  Future<Either<Exception, void>> signout() async {
    try {
      return await sl<AuthFirebaseService>().signout();
    } catch (e) {
      return Left(Exception("Error al cerrar sesión"));
    }
  }
}
